---
layout: distill
title: Getting to know JAX and Haiku
description: Some notes on JAX and Haiku I took while learning both.
date: 2021-05-22
published: false

authors:
  - name: Nasib A. Naimi

toc:
  - name: JAX 
  - name: Other Typography?

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

## JAX


JAX vs. Numpy

Key Concepts:

JAX provides a NumPy-inspired interface for convenience.

Through duck-typing, JAX arrays can often be used as drop-in replacements of NumPy arrays.

Unlike NumPy arrays, JAX arrays are always immutable.


NumPy, lax & XLA: JAX API layering

Key Concepts:

jax.numpy is a high-level wrapper that provides a familiar interface.

jax.lax is a lower-level API that is stricter and often more powerful.

All JAX operations are implemented in terms of operations in XLA – the Accelerated Linear Algebra compiler.



To JIT or not to JIT

Key Concepts:

By default JAX executes operations one at a time, in sequence.

Using a just-in-time (JIT) compilation decorator, sequences of operations can be optimized together and run at once.

Not all JAX code can be JIT compiled, as it requires array shapes to be static & known at compile time.


JIT mechanics: tracing and static variables

Key Concepts:

JIT and other JAX transforms work by tracing a function to determine its effect on inputs of a specific shape and type.

Variables that you don’t want to be traced can be marked as static


Static vs Traced Operations

Key Concepts:

Just as values can be either static or traced, operations can be static or traced.

Static operations are evaluated at compile-time in Python; traced operations are compiled & evaluated at run-time in XLA.

Use numpy for operations that you want to be static; use jax.numpy for operations that you want to be traced.

# Some of the most useful functions

## jax.vmap()

Fast and efficient vectorization and parallelization (a.k.a vmap and pmap in JAX). Like numpy vectorization, it simplifies the coding process and speeding up computation drastically.

Just-in-time (JIT) compilation (a.k.a jit in JAX). I think this is the main secret sauce for JAX to perform so much faster than other packages, take a look at the comparisons in quick start on jit and combine jit with vmap.

https://colinraffel.com/blog/you-don-t-know-jax.html

https://jiayiwu.me/blog/2021/04/05/learning-about-jax-axes-in-vmap.html

