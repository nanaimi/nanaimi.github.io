---
layout: distill
title: High Performance Computing - A Practical Guide
description: A comprehensive guide to High Performance Computing concepts, architectures, and best practices, with hands-on examples from ETH HPC Lab
date: 2024-03-20
categories: code
published: false

authors:
  - name: Nasib Naimi
    affiliations:
      name: ETH Zurich
      
bibliography: hpc-lab-2022.bib

# Optionally, you can add a table of contents to your post.
# NOTES:
#   - make sure that TOC names match the actual section names
#     for hyperlinks within the post to work correctly.
#   - we may want to automate TOC generation in the future using
#     jekyll-toc plugin (https://github.com/toshimaru/jekyll-toc).
toc:
  - name: Introduction to HPC
  - name: HPC Architecture
  - name: ETH HPC Environment
  - name: Performance Optimization
  - name: Modern HPC Trends
  - name: Best Practices and Tools

# Below is an example of injecting additional post-specific styles.
# If you use this post as a template, delete this _styles block.
_styles: >
  .fake-img {
    background: #bbb;
    border: 1px solid rgba(0, 0, 0, 0.1);
    box-shadow: 0 0px 4px rgba(0, 0, 0, 0.1);
    margin-bottom: 12px;
  }
  .fake-img p {
    font-family: monospace;
    color: white;
    text-align: left;
    margin: 12px 0;
    text-align: center;
    font-size: 16px;
  }

---

## Introduction to HPC

High-Performance Computing (HPC) combines computational resources to deliver high computational power for solving complex problems. Modern HPC systems, often called supercomputers, can perform quadrillions of calculations per second.

### Key Concepts

1. **Parallel Computing**: Multiple processors working simultaneously
2. **Distributed Computing**: Computations spread across multiple machines
3. **Scalability**: Ability to handle increased workload with additional resources
4. **Performance Metrics**:
   - FLOPS (Floating Point Operations Per Second)
   - Memory bandwidth
   - Network latency and throughput

## HPC Architecture

### Hardware Components

1. **Compute Nodes**
   - CPUs (multi-core processors)
   - GPUs (for accelerated computing)
   - Memory (RAM)
   - Local storage

2. **Network Infrastructure**
   - High-speed interconnects (InfiniBand, OmniPath)
   - Network topology
   - Bandwidth and latency considerations

3. **Storage Systems**
   - Parallel file systems (Lustre, GPFS)
   - Hierarchical storage management
   - Burst buffers

### Memory Hierarchy

1. **Registers**: Fastest, smallest capacity
2. **Cache Levels**: L1, L2, L3
3. **Main Memory (RAM)**
4. **Local Storage**
5. **Network Storage**

## ETH HPC Environment

### Accessing ETH Clusters

```bash
# To access euler cluster make sure to be in ETHZ Network using VPN
ssh <user_name>@euler.ethz.ch
```

This connects you to the login node which manages basic cluster administration. Here, you should only **compile and run small programs** for testing. Large jobs should run on compute nodes using the batch system.

### Software Stack Management

ETH clusters provide multiple software stacks:
- The old stack uses environment modules
- The [new stack](https://scicomp.ethz.ch/wiki/New_SPACK_software_stack_on_Euler) uses LMOD modules

Switch to the new stack using:
```bash
env2lmod
```

### Practical Job Management

#### Job Submission Examples

1. **Basic Job**
   ```bash
   bsub -W 01:00 -n 1 ./my_program
   ```

2. **Multi-node OpenMP**
   ```bash
   export OMP_NUM_THREADS=8
   bsub -n 8 -R "span[ptile=8]" -W 01:00 ./omp_program
   ```

3. **MPI with Resource Requirements**
   ```bash
   bsub -n 16 -R "rusage[mem=4096]" -W 02:00 mpirun ./mpi_program
   ```

#### Job Monitoring and Control

```bash
# List all jobs
bjobs [options] [JobID]
    -l        # Long format
    -w        # Wide format
    -p        # Show pending jobs
    -r        # Show running jobs

# Detailed resource usage
bbjobs [options] [JobID]
    -l        # Log format
    -f        # Show CPU affinity

# Connect to running job
bjob_connect <JOBID>

# Kill jobs
bkill <jobID>    # Kill specific job
bkill 0          # Kill all your jobs
```

## Matrix Multiplication Case Study

### Memory Hierarchy Impact

Modern processors handle floating point operations very efficiently:
- Addition: typically 1 cycle
- Multiplication: 1-2 cycles
- Memory access: can take hundreds of cycles

This makes memory access optimization critical for performance.

### Blocked Matrix Multiplication

```cpp
// Cache-friendly blocked implementation
void matrix_multiply_blocked(float* A, float* B, float* C, int N, int BLOCK_SIZE) {
    for (int i = 0; i < N; i += BLOCK_SIZE) {
        for (int j = 0; j < N; j += BLOCK_SIZE) {
            for (int k = 0; k < N; k += BLOCK_SIZE) {
                // Block multiplication
                for (int ii = i; ii < min(i+BLOCK_SIZE, N); ii++) {
                    for (int jj = j; jj < min(j+BLOCK_SIZE, N); jj++) {
                        float sum = C[ii*N + jj];
                        for (int kk = k; kk < min(k+BLOCK_SIZE, N); kk++) {
                            sum += A[ii*N + kk] * B[kk*N + jj];
                        }
                        C[ii*N + jj] = sum;
                    }
                }
            }
        }
    }
}
```

### Performance Analysis

Key findings from our matrix multiplication study:
1. Cache utilization is critical for performance
2. Blocked algorithms can significantly reduce memory access
3. Proper block size selection depends on cache size
4. BLAS libraries implement these optimizations internally

## Performance Optimization

### Memory Optimization

1. **Cache Optimization**
   - Data alignment
   - Cache line utilization
   - Stride optimization

2. **Memory Access Patterns**
   - Sequential access
   - Blocked algorithms
   - Vectorization

### Parallel Optimization

1. **Load Balancing**
   - Even distribution of work
   - Dynamic scheduling
   - Work stealing

2. **Communication Optimization**
   - Minimize message passing
   - Overlap computation and communication
   - Use collective operations

### Code Examples

```cpp
// Example: Cache-friendly matrix multiplication
for (int i = 0; i < N; i += BLOCK_SIZE) {
    for (int j = 0; j < N; j += BLOCK_SIZE) {
        for (int k = 0; k < N; k += BLOCK_SIZE) {
            // Block multiplication
            for (int ii = i; ii < min(i+BLOCK_SIZE, N); ii++) {
                for (int jj = j; jj < min(j+BLOCK_SIZE, N); jj++) {
                    float sum = C[ii][jj];
                    for (int kk = k; kk < min(k+BLOCK_SIZE, N); kk++) {
                        sum += A[ii][kk] * B[kk][jj];
                    }
                    C[ii][jj] = sum;
                }
            }
        }
    }
}
```

## Modern HPC Trends

### Cloud HPC

1. **Benefits**
   - Scalability
   - Pay-per-use
   - Quick provisioning

2. **Challenges**
   - Network performance
   - Cost management
   - Data security

### AI and HPC Convergence

1. **AI Workloads**
   - Deep learning training
   - Large language models
   - AI-assisted simulations

2. **Hardware Acceleration**
   - GPUs
   - TPUs
   - FPGAs

### Container Technologies

1. **Singularity/Apptainer**
   - HPC-specific containers
   - Security features
   - MPI support

2. **Docker in HPC**
   - Development workflows
   - CI/CD pipelines
   - Testing environments

## Best Practices and Tools

### Development Tools

1. **Compilers**
   - GCC, Intel, NVIDIA
   - Optimization flags
   - Vectorization reports

2. **Debuggers**
   - GDB, DDT, TotalView
   - Memory checkers
   - Thread analyzers

3. **Profilers**
   - Intel VTune
   - NVIDIA NSight
   - TAU

### Performance Analysis

1. **Metrics**
   - Strong scaling
   - Weak scaling
   - Parallel efficiency

2. **Benchmarking**
   - STREAM
   - LINPACK
   - Application-specific benchmarks

### Resource Management

1. **Module System**
   ```bash
   module avail           # List available modules
   module load compiler   # Load specific module
   module list           # Show loaded modules
   module purge         # Unload all modules
   ```

2. **Environment Setup**
   - Compiler selection
   - Library paths
   - Runtime configurations

## References

1. Introduction to High Performance Computing for Scientists and Engineers
2. Parallel Programming for Science and Engineering
3. The Art of High Performance Computing
4. [TOP500 Supercomputer Sites](https://www.top500.org/)
5. [ETH Zurich Scientific Computing Wiki](https://scicomp.ethz.ch/)
6. [ETH HPC Lab Course Materials](https://www.cse-lab.ethz.ch/teaching/hpcse-i_hs22/)

{% comment %}
ORIGINAL POST CONTENT (Pre-2024 Update):

<!-- # Notes on the High Performance Computing Lab 2022 -->

**NOTE:** 

The following are a collection of notes taken during the course _High Performance Computing Lab for Computational Science and Engineering 2022_. 

## LFS and Batch Systems
 
**LSF:** Load Sharing Facility is a batch system that allows users to submit jobs to a cluster. The cluster is a collection of computers that are connected together to form a single system. The batch system is responsible for scheduling jobs on the cluster and managing resources.

### Useful Commands

```bash
# List all jobs
bjobs [options] [JobID]
    -l        # Long format
    -w        # Wide format
    -p        # Show pending jobs
    -r        # Show running jobs

# Detailed resource usage
bbjobs [options] [JobID]
    -l        # Log format
    -f        # Show CPU affinity

# Connect to running job
bjob_connect <JOBID>

# Kill jobs
bkill <jobID>    # Kill specific job
bkill 0          # Kill all your jobs
```

### Job Submission Examples

1. **Basic Job**
   ```bash
   bsub -W 01:00 -n 1 ./my_program
   ```

2. **Multi-node OpenMP**
   ```bash
   export OMP_NUM_THREADS=8
   bsub -n 8 -R "span[ptile=8]" -W 01:00 ./omp_program
   ```

3. **MPI with Resource Requirements**
   ```bash
   bsub -n 16 -R "rusage[mem=4096]" -W 02:00 mpirun ./mpi_program
   ```

## Matrix Multiplication Case Study

### Memory Hierarchy Impact

Modern processors handle floating point operations very efficiently:
- Addition: typically 1 cycle
- Multiplication: 1-2 cycles
- Memory access: can take hundreds of cycles

This makes memory access optimization critical for performance.

### Blocked Matrix Multiplication

```cpp
// Cache-friendly blocked implementation
void matrix_multiply_blocked(float* A, float* B, float* C, int N, int BLOCK_SIZE) {
    for (int i = 0; i < N; i += BLOCK_SIZE) {
        for (int j = 0; j < N; j += BLOCK_SIZE) {
            for (int k = 0; k < N; k += BLOCK_SIZE) {
                // Block multiplication
                for (int ii = i; ii < min(i+BLOCK_SIZE, N); ii++) {
                    for (int jj = j; jj < min(j+BLOCK_SIZE, N); jj++) {
                        float sum = C[ii*N + jj];
                        for (int kk = k; kk < min(k+BLOCK_SIZE, N); kk++) {
                            sum += A[ii*N + kk] * B[kk*N + jj];
                        }
                        C[ii*N + jj] = sum;
                    }
                }
            }
        }
    }
}
```

### Performance Analysis

Key findings from our matrix multiplication study:
1. Cache utilization is critical for performance
2. Blocked algorithms can significantly reduce memory access
3. Proper block size selection depends on cache size
4. BLAS libraries implement these optimizations internally
{% endcomment %}


---
layout: distill
title: High Performance Computing
description: an example of a distill-style blog post and main elements
date: 2022-08-20
categories: code
published: true

authors:
  - name: Nasib Naimi
    affiliations:
      name: ETH Zurich
      
bibliography: hpc-lab-2022.bib

# Optionally, you can add a table of contents to your post.
# NOTES:
#   - make sure that TOC names match the actual section names
#     for hyperlinks within the post to work correctly.
#   - we may want to automate TOC generation in the future using
#     jekyll-toc plugin (https://github.com/toshimaru/jekyll-toc).
toc:
  - name: LFS and Batch Systems
    # if a section has subsections, you can add them as follows:
    # subsections:
    #   - name: Example Child Subsection 1
    #   - name: Example Child Subsection 2
  - name: 
  - name: 

# Below is an example of injecting additional post-specific styles.
# If you use this post as a template, delete this _styles block.
_styles: >
  .fake-img {
    background: #bbb;
    border: 1px solid rgba(0, 0, 0, 0.1);
    box-shadow: 0 0px 4px rgba(0, 0, 0, 0.1);
    margin-bottom: 12px;
  }
  .fake-img p {
    font-family: monospace;
    color: white;
    text-align: left;
    margin: 12px 0;
    text-align: center;
    font-size: 16px;
  }

---

<!-- # Notes on the High Performance Computing Lab 2022 -->

**NOTE:** 

The following are a collection of notes taken during the course _High Performance Computing Lab for Computational Science and Engineering 2022_. 

## LFS and Batch Systems
 
**LSF:** Load Sharing Facility. LSF manages, monitors, and analyzes the workload for a heterogeneous network of computers and it unites a group of computers into a single system to make better use of the resources on a network. Hosts from various vendors can be integrated into a seamless system

### Logging in on Remote Cluster

{% highlight bash %}
ssh <user_name>@<remote_machine>
# To access euler cluster make sure to be in ETHZ Network using VPN
ssh <user_name>@euler.ethz.ch
{% endhighlight %}

This will connect you to the login node of the cluster which manages basic administration of the cluster and is the common interface for all users. Here, you should only **compile and run small programs** for test and debug purposes. Programs with large execution times and/or large memory requirements should be run on the compute nodes [using the batch system](https://scicomp.ethz.ch/wiki/Using_the_batch_system). 

### Software Stacks, Managing/Loading Modules, and Running/Monitoring Jobs
**NOTE:** Modules must be re-loaded each time a new node is connected.

#### Software Stacks

On Euler and Leonhard clusters multiple software stacks are provided:
- The old software stack on Euler uses environment modules
- The [new software stack](https://scicomp.ethz.ch/wiki/New_SPACK_software_stack_on_Euler) on Euler and the software stack on Leonahrd Open uses LMOD modules

**NOTE:** On Euler the old software stack is the default. Change to the new software stack using:
{% highlight bash %}
env2lmod
{% endhighlight %}

#### Module Commands

{% highlight bash %}

module avail <module_name> # lists all available modules of the supported module category.
module show <module_name> # provides some info on what env variables are changed/set by module file.
module load <module_name> # loads/prepares env to use application/library, by applying instructions shown module show.
module list # displays the currently loaded modules files.
module purge # unload all currently loaded modules and cleans up env of shell. Note: might be better to log out and log in again to get really clean shell.

{% endhighlight %}

#### Running/Monitoring Jobs

We can submit a job to the batch system by using the following command together with *LSF Options*

{% highlight bash %}

bsub *[LSF options]* <*command*> *[arguments]* 
      -o *output_file* # append *output_file* to lsf.oJobID.
      -oo *output_file* # overwrite filename of output.
      -I # submit as batch interactive job, output written directly to terminal instead of file.
      -Ip # interactive job with pseudo-terminal.
      -Is # interactive job with login-shell.
      -W *minutes/HH:MM* # specify time requirements to run job. Default: one core, 4 hours.
      -n *number_of_procs* # request number of cores/threads. NOTE: requesting them does not mean application will use them.
      -R "rusage[mem=XXX]" # request memory in MB per processor core. Default: 1024 MB per processor core.
      -R "rusage[scratch=YYY]" # request scratch space needed by job, in MB per processor core. Default: none.

# combine two commands together by enclosing in quotes
bsub "command1; command2"

# more complex commands can be combined into a shell script and submitted 
bsub < *script* # **Note:** bad idea to submit script as program because batch system does not see what script is doing

{% endhighlight %}

Regarding scratch space, LSF automatically creates a local scratch directory when your job starts and deletes it when the job ends. This directory has a unique name, which is passed to your job via the variable *TMPDIR*. The batch system does not reserve any disk space for this scratch directory by default. If job is expected to write large amounts of temporary data (>250 MB) into *TMPDIR* — or anywhere in the local /scratch file system — enough scratch space must be requested when submitting using *-R "rusage[scratch=YYY]"*.

Helper tool for correctly submittting job with appropriate resources to the batch system can be found [here](https://scicomp.ethz.ch/lsf_submission_line_advisor/).

To run multi-node job, you will need to request span[ptile=XX] with XX being the number of CPU cores per GPU node, which is depending on the node type (the node types are listed in the table above).

Parallel job submission, we need to make sure that the application can be run in parallel in the first place. If not, we are just wasting resources. After doing so, it is important to run a brief [scaling analysis](https://scicomp.ethz.ch/wiki/Parallel_efficiency) to understand how the code scales in order to make an optimal choice of allocated resources(more not always better!).

**OpenMP Jobs:** In case the application is parallelized using OpenMP or linked against a library using OpenMP (Intel MKL, OpenBLAS, etc.). Number of processor cores (or threads) that it can use is controlled by the environment variable *OMP_NUM_THREADS*. **Set this variable before submitting job!**

{% highlight bash %}
export OMP_NUM_THREADS=<number_of_cores>
bsub -R "span[ptile=<number_of_cores>]" -n <number_of_cores> ...
{% endhighlight %}

NOTE: if *OMP_NUM_THREADS* is not set, application will either use one core only, or will attempt to use all cores that it can find, stealing them from other jobs if needed. Hence, will either use too few or too many cores.

**OpenMPI Jobs:** Before submitting and executing an MPI job, corresponding modules must be loaded (compiler + MPI, in that order)

{% highlight bash %}
module load <compiler>
module load <mpi_library>
{% endhighlight %}

Launch an MPI application using *mpirun*

{% highlight bash %}
bsub -n <number_of_cores> mpirun ./hello_world
{% endhighlight %}

NOTE: *mpirun* automatically uses all cores allocated to job by LSF. Thus, it is not necessary to indicate the number again to the *mpirun* command using *mpirun -np number_of_cores*

Jobs can be monitored using the following commands

{% highlight bash %}

bjobs [options] [JobID] # list jobs - running, pending, or suspended
      -l / -w # long / wide format
      -r      # show only runnning jobs
      -p      # show only pending jobs, and the reason for pending
      -d      # show jobs that ended recently
      -x      # show jobs that have triggered exception
      -q queue# show jobs in specified queue
      -u user # show jobs submitted by specified user
      -J jobname # show infromation about specified job

{% endhighlight %}

Get more information on jobs using *bbjobs*

{% highlight bash %}

bbjobs [options] [JobID] # used to see the resource request and usage
      -u user # user username
      -a      # show all jobs
      -r      # show only runnning jobs
      -s      # show only suspended jobs
      -d      # show jobs that ended recently
      -p      # show only pending jobs, and the reason for pending
      -f      # show job cpu affinity, which cores it is running
      -l      # show job information in log format

{% endhighlight %}

To monitor a job directly on the node on which it is running, the following command can be used

{% highlight bash %}

bjob_connect <JOBID> [SSH OPTIONS]

{% endhighlight %}

We can use the following to terminate running/pending/stale jobs

{% highlight bash %}

bkill <jobID(s)>  # Kill the specified job(s).
bkill 0           # kill all jobs submitted by user

{% endhighlight %}

## 1 - Optimizing Matrix Multiplication

***Goal:*** The goal of this part of the mini-project notes is to explain the basic techniques used both by manufacturers and libraries like GotoBLAS in their hand-optimized libraries to obtain these speedups.

### Definitions

| **Term**          | Definition     |
| ------------- |:-------------| 
| FLOPS |  |
| Register         | afdasfafdafadfafddfdafddafadfadf |
| main memory      | centered |
| cache            | are neat |
| memory hierarchy |     |
| cache-line       |     |
| page             |     |
| cache miss       |     |
| page fault       |     |
| remote/local     |  A large parallel computer may have many memory modules, some local to each processor, and so faster to access, and some remote, and so slower.  |
| spatial locality  ||
| temporal locality ||

### Discussion on Complexity and Memory

It turns out that on most modern processors, the instructions that take two floating point numbers (like 3.1416) from two registers, add or multiply them, and put them back in registers, are typically the fastest the machine performs. **Addition** is usually **1 cycle**, the least any instruction can take, and **multiplication** is **usually as fast** or perhaps a bit slower. It turns out that **loads** and **stores**, i.e., moving data from the memory to registers (which is where all the arithmetic and other useful work takes place) are the most expensive operations, sometimes costing **hundreds of cycles** or more. The reason is that any computer memory, from the cheapest PC to the biggest supercomputer, is organized as a **memory hierarchy**.

It is clear that merely counting arithmetic operations is not the whole story; we should try to minimize memory accesses instead.

If there is a memory hierarchy then one can organize the algorithm to minimize the number of accesses to the slower levels of the hierarchy.


run-time estimation: We run this program many times and divide the total elapsed time by the number of times we ran it, in order to get a reliable estimate of the run-time of the program.

**Modeling Memory Hierarchies under simplification**


1. There are only **two levels in the memory hierarchy**, **fast** and **slow**.
2. **All the input data starts in the slow level**, and the output must eventually be written back to the slow level.
3. The size of the fast memory is M, which is large but much smaller than the main memory. In particular, the input of large problems will not fit in the fast memory simultaneously.
4. The programmer explicitly controls when which data moves between the two memories.
5. **Arithmetic (and logic)** can **only** be done **on data residing in the fast memory**. Each such operation takes time $$t_a$$. Moving a word of data from one memory to the other takes time $$t_m >> t_a$$. Hence, if a program performs $$m$$ memory moves and $$a$$ arithmetic operations, the total time it takes is $$T = a \cdot t_a + m \cdot t_m$$ , where it may be that $$m \cdot t_m >> a \cdot t_a$$.

However, we know how the hardware works: it moves data to the cache precisely when the user first tries to load it into a register to perform arithmetic, and puts it back in main memory when the cache is too full to get the next requested word.

*lower bound on speed:* $$T = a \cdot t_a + (m_i + m_o) \cdot t_m$$, $$m_i$$/$$m_o$$ number of inputs/outputs 


**Theorem:** (Hong + Kung, 1981, 13th Symposium on the Theory of Computing) Any implementation of matrix multiplication using $$2n^3$$ arithmetic operations performs at least $$O(n^3 / \sqrt(M)$$ slow memory references.

**Cache Performance improvement via Blocking**


{% highlight bash %}

export OMP_NUM_THREADS=p
bsub -n p -W 01:00 -R "span[ptile=p]" < run_matrixmult.sh

{% endhighlight %}


*Note:* that the matrices are stored in C style row-major order. However, the BLAS library expects matrices stored in column-major order. 

When we provide a matrix stored in row-wise ordering to the BLAS, the library will interpret it as its transpose. Knowing this, we can use an identity $$B^T A^T = (AB)^T$$ and provide matrices A and B to BLAS in rowwise storage, swap the order when calling dgemm and expect the transpose of the result, (AB)^T

*An example using matrix multiply algorithm:*

*dgemm-naive:* Naive implementation of the matrix multiplication without taking into account the memory hierarchy and trying to minimize the number of references to the slow memory.

*dgemm-blocked:* A simple blocked implementation of matrix multiply. The algorithm is implemented with awareness of the memory hierarchy, trying to minimize the number of references to the slow memory.


*BRIEF ON THIS TASK* 

Goal of this task was to understand that the most time intensive operations in running algorithms is accessing data which is not in the cache or no the registers. Accessing this data and writinig it to the different layers of cache memory is much more time intensive that performing a standard arithmetic operation, thus we must write algorithms to make use of both temporal and spatial locality. This was illustrated by means of the matrix multiplication algorithm, which we rewrote to make use of spatial locality. This was done by implementing *blocked-matrixmultiplication* which we then compared to the implementation provided by intel in intelMKTL. Graphs can be seen [here](https://github.com/nanaimi/hpc_lab/blob/test/project_1_naimi_nasib/project_1_naimi_nasib.pdf).

## 2 - Parallel Programming using OpenMP

### OpenMP Introduction

*Open specifications for Multi Processing*

*OpenMP* is an industry standard of a shared-memory programming interface. It comprises a set of compiler directives, library functions, and environment variables. *OpenMP* can be used for writing multi-threaded programs in Fortran, C / C++.

| Advantages | Disadvantages |
| :------------- | :------------- | 
| Incremental parallelization of serial code | Limited scalability |
| Simple parallel algorithms are easy and fast to implement | Implicit communication |
| Correctly-written code will compile and run with a normal compiler on a single CPU. | Danger of incorrect synchronization |


OpenMP follows a *Fork & Join* approach; OpenMP programs begin as a single process, *master thread*, and when the parallel region is reached, a team of threads is spawned. The spawned are then joined on closing of the parallel region.  

<div class="row mt-3">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/omp-forkjoin.png" class="img-fluid rounded z-depth-1" zoomable=true %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/omp-executionmodel.png" class="img-fluid rounded z-depth-1" zoomable=true %}
    </div>
</div>
<div class="caption">
    Left: illustration of the fork and join approach. Right: illustration of the execution model.
</div>

A team of threads is spawned using *parallel directives* for the compiler where the parallel region is defined by the scope in program. Below an example for parallelising a loop using directives and proper scoping.

<div class="row mt-3">
<div class="col-sm mt-3 mt-md-0">

{% highlight cpp %}

#pragma omp parallel 
int i=0;
for(i; i<ARRAY_SIZE; i++) {
  /*do some operation*/
}

{% endhighlight %}

</div>
<div class="col-sm mt-3 mt-md-0">

{% highlight cpp %}
#pragma omp parallel
{
  #pragma omp for 
  {
    int i=0;
    for(i; i<ARRAY_SIZE; i++) {
      /*do some operation*/
    }
  }
}
{% endhighlight %}

</div>
</div>
<div class="caption">
    Left: incorrect implementation, will. Right: correct implementation with proper scoping of compiler directives.
</div>

The data-sharing attribute of variables, which are declared outside the parallel region, is usually shared. The loop iteration variables, however, are private by default.

OpenMP does not put any restriction to prevent data races between shared variables. This is a responsibility of a programmer.

Shared variables introduce an overhead, because one instance of a variable is shared between multiple threads. Therefore, it is often best to minimize the number of shared variables when a good performance is desired.


### OpenMP C++ Compiler Directives

To make use of the OpenMP, include the following header in your c, cpp source.

{% highlight c %}

#include <omp.h>

{% endhighlight %}


| **Directive**      | **Function**     | **Example** |
| ------------- |:-------------|:-------------| 
| parallel | specifies a region to fork | #pragma omp parallel |
| for | inside scope of parallel directive, for parallelising for loops | #pragma omp for |
| critical | specifies a region of code that must be executed by only one thread at a time. | #pragma omp critical |
| reduction({op}:{var}) | in scope of parallel directive. A private copy for each list variable is created for each thread. At the end of the reduction, the reduction variable is applied to all private copies of the shared variable, and the final result is written to the global shared variable. | #pragma omp parallel reduction(+:{some_var}) |
| default({option}) | Allows the user to specify a default scope for all variables in the lexical extent of any parallel region.  | #pragma omp parallel for default(shared) | 
| private({var}) | declares variables in its list to be private to each thread. Private variables are not initialised, even when initialised before the parallel region. | #pragma omp parallel private(local_sum) |
| shared({var}) | declares variables in its list to be shared among all threads in the team. | #pragma omp parallel shared(global_sum) |
| collapse({int}) | Specifies how many loops in a nested loop should be collapsed into one large iteration space and divided according to the schedule clause. The sequential execution of the iterations in all associated loops determines the order of the iterations in the collapsed iteration space. |  |
| barrier | synchronizes all threads in the team. |  |
| sections | The SECTIONS directive is a non-iterative work-sharing construct. It specifies that the enclosed section(s) of code are to be divided among the threads in the team. |  |
| section | Independent SECTION directives are nested within a SECTIONS directive. Each SECTION is executed once by a thread in the team. Different sections may be executed by different threads. It is possible for a thread to execute more than one section if it is quick enough and the implementation permits such. |  |
| nowait | There is an implied barrier at the end of a SECTIONS directive, unless the NOWAIT/nowait clause is used |  |
| firstprivate | FIRSTPRIVATE clause combines the behavior of the PRIVATE clause with automatic initialization of the variables in its list. |  |
| lastprivate | LASTPRIVATE clause combines the behavior of the PRIVATE clause with a copy from the last loop iteration or section to the original variable object. |  |
| schedule({type}[, chunk]) | Describes how iterations of the loop are divided among the threads in the team. The default schedule is implementation dependent.  |  |



*BRIEF ON THIS TASK* 

First, we implement basic directives to parallelise the computation of the dot product. Here we illustrate that there are multiple ways of applying the directives to parallelise the code. We then implement the computation of the mandelbrot set (fixed image size), first sequentially, then parallelising the implementation w/ the omp directives. 

BIB FOR THIS SECTION:

tutorial slides HPC Lab

https://hpc-tutorials.llnl.gov/openmp/

http://jakascorner.com/blog/2016/06/omp-data-sharing-attributes.html#:~:text=The%20data%2Dsharing%20attribute%20of,however%2C%20are%20private%20by%20default.

https://rookiehpc.github.io/index.html


## 3 - Parallel Space Solution of a Nonlinear PDE using OpenMP

Questions:

- why does it not converge for gridsize 64?
- how does ethe work have to be increarsed to scale exaclty with the number of cores? --> factor
- can the implementation be made even faster by using SIMD instructions?


## 4 - Large Scale Graph Partitioning

## 5 - Parallel Programming using the Message Passing Interface MPI

*MPI*, which stands for Message-Passing Interface, is a standard that defines (as its name suggests) an interface for message-passing libraries.

*Ghost Cell* refers to a copy of remote processs data in the memory space of the current process.

Furthermore, we will assume we have an n × n grid of processes organized in a Cartesian topology, as shown in the bottom image of Figure 2. We also assume cyclic borders, which means that, for example, process 0 is also a neighbor of process 3 and 12. Each process has 4 neighbors, sometimes referred to as the neighbor north, south, east and west.

*comments on oversubscribing:* https://www.open-mpi.org/faq/?category=running#oversubscribing

Note that mpirun automatically uses all cores allocated to the job by LSF . It is therefore not necessary to indicate this number again following the mpirun command.


### OpenMPI Functionality

To make use of the Open MPI, include the following header in your c, cpp source.

{% highlight c %}

#include <mpi.h>

{% endhighlight %}


| **Category** | **Command**      | **Function**     |
| ------------- |:-------------|:-------------| 
| Receiving | MPI_Status | Under Receiving. Represents the status of a reception operation, returned by receive operations (MPI_Recv), non-blocking operation wait (MPI_Wait, etc.) or test (MPI_Test, etc.). When the user has no use of the MPI_Status, they can pass the constant MPI_STATUS_IGNORE or equivalent for arrays. |  |
| Synchronisation | MPI_Request | Represents a handle on a non-blocking operation. This is used by wait (MPI_Wait, etc.) and test (MPI_Test, etc.) **to know when the non-blocking operation handled completes**. |
| Misc. | MPI_Init | initialises the MPI environment, it is equivalent to invoking MPI_Init_thread with the MPI_THREAD_SINGLE thread support level. The MPI_Init routine must be called by each MPI process, once and before any other MPI routine. |
| Topology | MPI_Comm_rank | Gets the rank of the calling MPI process in the communicator specified. If the calling MPI process does not belong to the communicator passed, MPI_PROC_NULL is returned. |
| Dataypes | MPI_COMM_WORLD | Rhe communicator provided by MPI; it contains all MPI processes. |
|| MPI_Comm_size | Gets the number of MPI processes in the communicator in which belongs the calling MPI process. |  |
|| MPI_Finalize | Shuts down the MPI library. It must be called by each process at the end of the MPI program. |  |
|  | MPI_Send | Blocking. |
|| MPI_Isend | standard non-blocking send (the capital 'I' stands for immediate return). As a non-blocking send, MPI_Isend will not block until the buffer passed is safe to be reused. In other words, the user must not attempt to reuse the buffer after MPI_Isend returns without explicitly checking for MPI_Isend completion |  |
| Synchronisation | MPI_Wait | Waits for a non-blocking operation to complete. That is, unlike MPI_Test, MPI_Wait will block until the underlying non-blocking operation completes. Since a non-blocking operation immediately returns, it does so before the underlying MPI routine completed. Waiting for that routine to complete is what MPI_Wait is designed for. There are variations of MPI_Wait to monitor multiple request handlers at once: MPI_Waitall, MPI_Waitany and MPI_Waitsome. |
| Receive | MPI_Recv | Receives a message in a blocking fashion: it will block until completion, which is reached when the incoming message is copied to the buffer given. Its non-blocking counterpart is MPI_Irecv. |
| Datatype | MPI_INT | MPI_Datatype that represents an integer type in MPI, it corresponds to an int in C. |
| Receive | MPI_Irecv ||
| Cartesian | MPI_Cart_create | Creates a communicator from the cartesian topology information passed. |
| Cartesian | MPI_Cart_coords | gets the coordinate of a process in a communicator that has a cartesian topology. |
| Cartesian | MPI_Cart_shift | virtually moves the cartesian topology of a communicator (created with MPI_Cart_create) in the dimension specified. It permits to find the two processes that would respectively reach, and be reached by, the calling process with that shift. Shifting a cartesian topology by 1 unit (the displacement) in a dimension therefore allows a process to find its neighbours in that dimension. In case no such neighbour exists, virtually located outside the boundaries of a non periodic dimension for instance, MPI_PROC_NULL is given instead. |
| User datatypes |MPI_Type_free| deallocates the resources assigned to an MPI_Datatype and sets it to MPI_DATATYPE_NULL. Communications that are currently using it will complete normally and MPI datatypes built on the freed one are not affected. |
||MPI_Comm_free | This routine frees a communicator. Because the communicator may still be in use by other MPI routines, the actual communicator storage will not be freed until all references to this communicator are removed. For most users, the effect of this routine is the same as if it was in fact freed at this time of this call. |
| User datatypes |MPI_Type_vector| creates an MPI datatype by replicating an existing MPI_Datatype a certain number of times into a block. The MPI_Datatype created will contain a certain number of such blocks separated with the constant displacement specified. Other ways to create a datatype are MPI_Type_contiguous, MPI_Type_create_hvector, MPI_Type_indexed, MPI_Type_create_hindexed, MPI_Type_create_indexed_block, MPI_Type_create_hindexed_block, MPI_Type_create_struct, MPI_Type_create_subarray, MPI_Type_create_darray. |
| User datatypes | MPI_Type_commit | must be called on user-defined datatypes before they may be used in communications. User-defined datatypes can be created via MPI_Type_contiguous, MPI_Type_vector, MPI_Type_create_hvector, MPI_Type_indexed, MPI_Type_create_hindexed, MPI_Type_create_indexed_block, MPI_Type_create_hindexed_block, MPI_Type_create_struct, MPI_Type_create_subarray, MPI_Type_create_darray. To free an MPI datatype created with MPI_Type_commit, see MPI_Type_free. |
|| MPI_Dims_create | A convenience function in the creation of cartesian topologies (MPI_Cart_create). This routine decomposes a given number of processes over a cartesian grid made of the number of dimensions specified. MPI attempts to balance the distribution by minimising the difference in the number of processes assigned to each dimension. The programmer can restrict the number of process to allocate to any dimension. If MPI is not able to find a decomposition while respecting the restrictions given, the routine returns an erroneous value. Otherwise, the decomposition found is stored in the array passed. |
| | MPI_Bcast  | Broadcasts a message from a process to all other processes in the same communicator. This is a collective operation; it must be called by all processes in the communicator. |
| | MPI_Gather | Collects data from all processes in a given communicator and concatenates them in the given buffer on the specified process. The concatenation order follows that of the ranks. This is a collective operation; **all processes in the communicator must invoke this routine**. *MPI_Igather* non-blocking counterpart. |
|| MPI_Scatter | dispatches data from a process across all processes in the same communicator. As a blocking operation, the buffer passed can be safely reused as soon as the routine returns. Also, MPI_Scatter is a collective operation; all processes in the communicator must invoke this routine. |
|| MPI_Reduce | Is the means by which MPI process can apply a reduction calculation. The values sent by the MPI processes will be combined using the reduction operation given and the result will be stored on the MPI process specified as root. MPI_Reduce is a collective operation; it must be called by every MPI process in the communicator given. |
|| MPI_Comm_split | partitions the group of MPI processes associated with the communicator passed into disjoint subgroups. The split is determined by the colour value passed: MPI processes providing the same colour value will be put in the same subgroup. Within each subgroup, the rank of the MPI processes put in each subgroup are ordered according to the value of the key passed. When multiple MPI processes of a subgroup have provided the same key value, their rank in that subgroup will be determined according to their rank in the old group. A new communicator is created for each subgroup and returned. A process may supply the colour value MPI_UNDEFINED, in which case the new communicator returned is MPI_COMM_NULL. This is a collective call, therefore all MPI processes in the communicator must call the routine, however each process is permitted to provide different values for colour and key. |
| Reduction | MPI_Allreduce | the means by which MPI process can apply a reduction calculation and make the reduction result available to all MPI processes involved. It can be seen as a combination of an MPI_Reduce and MPI_Broadcast. MPI_Allreduce is a collective operation; it must be called by every MPI process in the communicator given. |
|| MPI_Waitall | version of MPI_Wait that can be applied to an array of request handlers. This version waits until all the non-blocking routines concerned complete. |


BIB

https://www.mpich.org/

https://rookiehpc.github.io/mpi/docs

DID NOT LOOK AT PAGERANK PROBLEM


inter-node communication which is more expensive than intra-node communication.


## 6 - High-Performance Computing with Python


Diff between them 

| **Threads** | **Cores** | **Nodes** |
| ------------- |:-------------|:-------------| 
||||

### Initializing and finalizing MPI

before we are able to make use of MPI, the MPI environment must be initialized. This entails the following 

  - 1) Initializing MPI and all respective environments by calling MPI_Init
  - 2) Getting current rank of process and total number of processes
  - 3) Finalizing MPI

{% highlight cpp %}

#include <mpi.h>

// initialize MPI
int mpi_rank, mpi_size, threadLevelProvided;
MPI_Request request;
MPI_Status status;

MPI_Init_thread(&argc, &argv, 
                        MPI_THREAD_MULTIPLE,    // thread support level
                        &threadLevelProvided);  // level of threading support provided by the implementation
MPI_Comm_rank(MPI_COMM_WORLD, &mpi_rank);   // get process rank
MPI_Comm_size(MPI_COMM_WORLD, &mpi_size);   // get number of processes

{% endhighlight %}


### Self-Scheduling Techniques


### MPI4PY

MPI for Python can communicate any built-in or user-defined Python object taking advantage of the features provided by the pickle module. These facilities will be routinely used to build binary representations of objects to communicate (at sending processes), and restoring them back (at receiving processes).

MPI for Python supports direct communication of any object exporting the single-segment buffer interface. This interface is a standard Python mechanism provided by some types (e.g., strings and numeric arrays), allowing access in the C side to a contiguous memory buffer (i.e., address and length) containing the relevant data. This feature, in conjunction with the capability of constructing user-defined MPI datatypes describing complicated memory layouts, enables the implementation of many algorithms involving multidimensional numeric arrays (e.g., image processing, fast Fourier transforms, finite difference schemes on structured Cartesian grids) directly in Python, with negligible overhead, and almost as fast as compiled Fortran, C, or C++ codes.


Initialization of MPI in python happens on import.


“Pickling” is the process whereby a Python object hierarchy is converted into a byte stream, and “unpickling” is the inverse operation, whereby a byte stream (from a binary file or bytes-like object) is converted back into an object hierarchy.

• using the pickle-based communication of generic Python objects, i.e. the all-lowercase methods;
• using the fast, near C-speed, direct array data communication of buffer-provider objects, i.e. the method names starting with an uppercase letter. 

Upper vs. Lower Case MPI4Py

upper case version is fast and requires a buffered version of the data (direct access and type information) and pass the return variable. Upper case versions map almost directly to the C API. Latency is very close to C and Bandwidth is identical.

lower case version can take almost arbitrary python objects and returns the result. much slower than the uppercase versions

Amdahl's Law:
Assumptions:
  - programm is disectable into seriable part(not parallelisable) and a perfectly parallelisabel parallel part.

For 1 core: $$t_1 = t_s + t_p $$

For n cores: $$t_n = t_s + t_p / n $$

speedup: $$ s_n = \frac{t_1}{t_n} = \frac{t_s+t_p}{t_s + t_p/n} = \frac{1}{(1-f)+f/n} $$



MEMORY BOUND
SOMETIMES BETTER TO OPTIMISE FOR L2 CACHE

Comments:

Task 1: Parallel Space Solution of nonlinear PDE using MPI

-2: You did not explain why the MPI_Allreduce call is only necessary for the dot product and the norm.

-3: You did not use iters/sec as measure, as asked for in the project description.

-3: I believe you did not examine the effect of distributing the processes across nodes correctly. The ptile option indicates how many CPU cores per node to allocate. Since you want each process to be located on a **different node**, you need to pass “span[ptile=1]” as an argument. However, you passed the number of cores you want to allocate to ptile. In that case, all processes will be located on the same node, instead of separate nodes.

In the future, please use logarithmic axes instead of simply taking the log of your measurement.


Task 2a: Parallel Space Solution of nonlinear PDE using MPI4Py

-2: Only benchmarked up to 13 processes.

-1: You did not use iters/sec as measure, as asked for in the project description.

## 7 - Numerical Mathematical Software for Extreme-Scale Science

### High-Lvel Languages for Numerical Computations

### Scientific Computing Toolkits and Libraries

### Mathematical HPC Software Frameworks

### PDE Frameworks IPOPT and PETSc


**Parallel Dense Matrix Software Libraries**

*BLAS:* Basic Linear Algebra Subprogramm (BLAS) specifies a set of computational routines for linear algebra operations such as vector and matrix operations. BLAS is a well-known example of a software layer which represents a de facto standard in the field of high-performance computing. All hardware vendors, such as Intel on multicores, or NVIDIA on manycores provide these BLAS routines as building blocks to ensure efficient scientific software portability.

*LAPACK:* Linear Algebra Package, LAPACK, [6] is a software library for matrix operations such as solving systems of linear equations, least-squares problems, and eigenvalue or singular value problems. Almost all LAPACK routines make use of BLAS to perform efficient computations — LAPACK acts as an additional parallel software layer to the underlying BLAS. The motivation for the development of BLAS and LAPACK was to provide efficient and portable implementations for solving dense systems of linear equations and least-squares problems and it was initiated in the 1970s. Influenced by the changes in the hardware architectures (e.g., vector computers, cache-based processors to parallel multiprocessing architectures), it changed from the original specification to, finally, BLAS Level-3 [9] for matrix-matrix operations.

*ScaLAPACK* (Scalable LAPACK) is an extension of LAPACK that is targeted to multiprocessing computers with a distributed-memory hierarchy. Fundamental building blocks of ScaLAPACK are the parallel BLAS (*PBLAS*) and the Basic Linear Algebra Communication Subprograms (*BLACS*). PBLAS is a distributed-memory version of BLAS, and BLACS is a library for handling interprocessor communication. The design policy of ScaLAPACK was to have the ScaLAPACK routines similar to their LAPACK equivalents so that both libraries can be used as a computational software layer for application developers.

*Ipopt* (Interior Point Optimizer, pronounced "Eye-Pea-Opt") is an open source software package for large-scale nonlinear optimization. It can be used to solve general nonlinear programming problems of the form

## Scaling Analysis

Scalability is the changing performance of a parallel program as it utilizes more computing resources.

### Strong Scaling

In case of strong scaling, the number of processors is increased while the problem size remains constant. This also results in a reduced workload per processor. Strong scaling is mostly used for long-running CPU-bound applications to find a setup which results in a reasonable runtime with moderate resource costs. The individual workload must be kept high enough to keep all processors fully occupied. The speedup achieved by increasing the number of processes usually decreases more or less continuously.

In an idealworld a problem would scale in a linear fashion, that is, the program would speed up by a factor of N when it runs on a machine having N nodes. (Of course, as N→ ∞ the proportionality cannot hold because communication time must then dominate. Clearly then, the goal when solving a problem that scales strongly is to decrease the amount of time it takes to solve the problem by using a more powerful computer. These are typically CPU-bound problems and are the hardest ones to yield something close to a linear speedup.

Strong scaling is identifying how a threaded PDE solver gets faster for a fixed PDE problem size. That is, we have the same discretization points per direction, but we run it with more and more threads and we hope/expect that it will compute its result faster.

In general, it is harder to achieve good strong-scaling at larger process counts since the communication overhead for many/most algorithms increases in proportion to the number of processes used.

### Weak Scaling

In case of weak scaling, both the number of processors and the problem size are increased. This also results in a constant workload per processor. Weak scaling is mostly used for large memory-bound applications where the required memory cannot be satisfied by a single node. They usually scale well to higher core counts as memory access strategies often focus on the nearest neighboring nodes while ignoring those further away and therefore scale well themselves. The upscaling is usually restricted only by the available resources or the maximum problem size. For an application that scales perfectly weakly, the work done by each node remains the same as the scale of the machine increases, which means that we are solving progressively larger problems in the same time as it takes to solve smaller ones on a smaller machine.

Weak scaling speaks to the latter point: how effectively can we increase the size of the problem we are dealing with? In a weak scaling study, each compute core has the same amount of work, which means that running on more threads increases the total size of the PDE simulation.

Gustafson’s law and weak scaling

*Weak Scaling Efficiency:* $$Efficiency=t(1)/t(N)$$

Summary
This post discusses two common types of scaling of software: strong scaling and weak scaling. Some key points are summarized below.

• Scalability is important for parallel computing to be efficient.

• Strong scaling concerns the speedup for a fixed problem size with respect to the number of processors, and is governed by Amdahl’s law.

• Weak scaling concerns the speedup for a scaled problem size with respect to the number of processors, and is governed by Gustafson’s law.

• When using HPC clusters, it is almost always worthwhile to measure the scaling of your jobs.

• The results of strong and weak scaling tests provide good indications for the best match between job size and the amount of resources (for resource planning) that should be requested for a particular job.

• Scalability testing measures the ability of an application to perform well or better with varying problem sizes and numbers of processors. It does not test the applications general funcionality or correctness.



### scaling speedup

### Parallel Efficiency

BIB:

https://hpc-wiki.info/hpc/Scaling



A (compute) *node* is a computer part of a larger set of nodes (a cluster). Besides compute nodes, a cluster comprises one or more login nodes, file server nodes, management nodes, etc. A compute node offers resources such as processors, volatile memory (RAM), permanent disk space (e.g. SSD), accelerators (e.g. GPU) etc.

A *core* is the part of a processor that does the computations. A *processor* comprises *multiple cores*, as well as a memory controller, a bus controller, and possibly many other components. A processor in the Slurm context is referred to as a socket, which actually is the name of the slot on the motherboard that hosts the processor. A *single core can have one or two hardware threads*. This is a technology that allows *virtually doubling the number of cores the operating systems perceives* while only doubling part of the core components -- typically the components related to memory and I/O and not the computation components. Hardware multi-threading is very often disabled in HPC.

a CPU in a general context refers to a processor, but in the Slurm context, a CPU is a consumable resource offered by a node. It can refer to a socket, a core, or a hardware thread, based on the Slurm configuration.


Multiple tasks are dispatched on possibly multiple nodes depending on how many core each task needs. The number of cores a task needs depends on the number of subprocesses or software threads in the instance of the running program. The idea is to map each hardware thread to one core, and make sure that each task has all assigned cores assigned on the same node.


Also you sometimes have to distinguish between hardware and software threads. Many (most?) cores support multiple active threads that run concurrently. These are hardware threads. You can have many more threads in software that take turns on the processor, but do not run strictly concurrently.



This same figure shows how the software is structured. A thread is essentially the sequence of instructions from the program. It is executed by one core, and a given core can operate only one thread at a time (if two threads are associated with one core, they are handled one after the other). A process refers to a group of threads which are assigned to a single (shared) memory space: one process will not handle the memory of another process. The process provides the communication between its threads so that they can work on their memory space without conflicts.



<!-- 
## Equations

This theme supports rendering beautiful math in inline and display modes using [MathJax 3](https://www.mathjax.org/) engine.
You just need to surround your math expression with `$$`, like `$$ E = mc^2 $$`.
If you leave it inside a paragraph, it will produce an inline expression, just like $$ E = mc^2 $$.

To use display mode, again surround your expression with `$$` and place it as a separate paragraph.
Here is an example:

$$
\left( \sum_{k=1}^n a_k b_k \right)^2 \leq \left( \sum_{k=1}^n a_k^2 \right) \left( \sum_{k=1}^n b_k^2 \right)
$$

Note that MathJax 3 is [a major re-write of MathJax](https://docs.mathjax.org/en/latest/upgrading/whats-new-3.0.html) that brought a significant improvement to the loading and rendering speed, which is now [on par with KaTeX](http://www.intmath.com/cg5/katex-mathjax-comparison.php).


***

## Citations

Citations are then used in the article body with the `<d-cite>` tag.
The key attribute is a reference to the id provided in the bibliography.
The key attribute can take multiple ids, separated by commas.

The citation is presented inline like this: <d-cite key="gregor2015draw"></d-cite> (a number that displays more information on hover).
If you have an appendix, a bibliography is automatically created and populated in it.

Distill chose a numerical inline citation style to improve readability of citation dense articles and because many of the benefits of longer citations are obviated by displaying more information on hover.
However, we consider it good style to mention author last names if you discuss something at length and it fits into the flow well — the authors are human and it’s nice for them to have the community associate them with their work.

***

## Footnotes

Just wrap the text you would like to show up in a footnote in a `<d-footnote>` tag.
The number of the footnote will be automatically generated.<d-footnote>This will become a hoverable footnote.</d-footnote>

***

## Code Blocks

Syntax highlighting is provided within `<d-code>` tags.
An example of inline code snippets: `<d-code language="html">let x = 10;</d-code>`.
For larger blocks of code, add a `block` attribute:

<d-code block language="javascript">
  var x = 25;
  function(x) {
    return x * x;
  }
</d-code>

**Note:** `<d-code>` blocks do not look well in the dark mode.
You can always use the default code-highlight using the `highlight` liquid tag:

{% highlight javascript %}
var x = 25;
function(x) {
  return x * x;
}
{% endhighlight %}

***

## Layouts

The main text column is referred to as the body.
It is the assumed layout of any direct descendants of the `d-article` element.

<div class="fake-img l-body">
  <p>.l-body</p>
</div>

For images you want to display a little larger, try `.l-page`:

<div class="fake-img l-page">
  <p>.l-page</p>
</div>

All of these have an outset variant if you want to poke out from the body text a little bit.
For instance:

<div class="fake-img l-body-outset">
  <p>.l-body-outset</p>
</div>

<div class="fake-img l-page-outset">
  <p>.l-page-outset</p>
</div>

Occasionally you’ll want to use the full browser width.
For this, use `.l-screen`.
You can also inset the element a little from the edge of the browser by using the inset variant.

<div class="fake-img l-screen">
  <p>.l-screen</p>
</div>
<div class="fake-img l-screen-inset">
  <p>.l-screen-inset</p>
</div>

The final layout is for marginalia, asides, and footnotes.
It does not interrupt the normal flow of `.l-body` sized text except on mobile screen sizes.

<div class="fake-img l-gutter">
  <p>.l-gutter</p>
</div>

***

## Other Typography?

Emphasis, aka italics, with *asterisks* (`*asterisks*`) or _underscores_ (`_underscores_`).

Strong emphasis, aka bold, with **asterisks** or __underscores__.

Combined emphasis with **asterisks and _underscores_**.

Strikethrough uses two tildes. ~~Scratch this.~~

1. First ordered list item
2. Another item
⋅⋅* Unordered sub-list. 
1. Actual numbers don't matter, just that it's a number
⋅⋅1. Ordered sub-list
4. And another item.

⋅⋅⋅You can have properly indented paragraphs within list items. Notice the blank line above, and the leading spaces (at least one, but we'll use three here to also align the raw Markdown).

⋅⋅⋅To have a line break without a paragraph, you will need to use two trailing spaces.⋅⋅
⋅⋅⋅Note that this line is separate, but within the same paragraph.⋅⋅
⋅⋅⋅(This is contrary to the typical GFM line break behaviour, where trailing spaces are not required.)

* Unordered list can use asterisks
- Or minuses
+ Or pluses

[I'm an inline-style link](https://www.google.com)

[I'm an inline-style link with title](https://www.google.com "Google's Homepage")

[I'm a reference-style link][Arbitrary case-insensitive reference text]

[I'm a relative reference to a repository file](../blob/master/LICENSE)

[You can use numbers for reference-style link definitions][1]

Or leave it empty and use the [link text itself].

URLs and URLs in angle brackets will automatically get turned into links. 
http://www.example.com or <http://www.example.com> and sometimes 
example.com (but not on Github, for example).

Some text to show that the reference links can follow later.

[arbitrary case-insensitive reference text]: https://www.mozilla.org
[1]: http://slashdot.org
[link text itself]: http://www.reddit.com

Here's our logo (hover to see the title text):

Inline-style: 
![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 1")

Reference-style: 
![alt text][logo]

[logo]: https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 2"

Inline `code` has `back-ticks around` it.

```javascript
var s = "JavaScript syntax highlighting";
alert(s);
```
 
```python
s = "Python syntax highlighting"
print s
```
 
```
No language indicated, so no syntax highlighting. 
But let's throw in a <b>tag</b>.
```

Colons can be used to align columns.

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

There must be at least 3 dashes separating each header cell.
The outer pipes (|) are optional, and you don't need to make the 
raw Markdown line up prettily. You can also use inline Markdown.

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3

> Blockquotes are very handy in email to emulate reply text.
> This line is part of the same quote.

Quote break.

> This is a very long line that will still be quoted properly when it wraps. Oh boy let's keep writing to make sure this is long enough to actually wrap for everyone. Oh, you can *put* **Markdown** into a blockquote. 


Here's a line for us to start with.

This line is separated from the one above by two newlines, so it will be a *separate paragraph*.

This line is also a separate paragraph, but...
This line is only separated by a single newline, so it's a separate line in the *same paragraph*. -->
