---
layout: distill
title: how to read academic papers
description: A rough guide on how to read academic papers in a structured way.
date: 2023-08-20
categories: academic
published: true

authors:
  - name: Nasib Naimi
    affiliations:
      name: ETH Zurich

# bibliography: 2018-12-22-distill.bib

# Optionally, you can add a table of contents to your post.
# NOTES:
#   - make sure that TOC names match the actual section names
#     for hyperlinks within the post to work correctly.
#   - we may want to automate TOC generation in the future using
#     jekyll-toc plugin (https://github.com/toshimaru/jekyll-toc).
toc:
  - name: Why should you bother?
  - name: Step One; Getting a General Idea of the Content
  - name: Step Two; Getting Context
  - name: Step Three; Complete Readthrough
  - name: Step Four; Final Pass
  - name: (Optional) Step Five; Summarizing and Sharing
  - name: Wrapping up
  - name: Sources

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

## Why should you bother?

Reading academic papers is time consuming and sometimes frustrating. Information is dense, sometimes we lack context, or the paper is just not written very well. This guide is more of a checklist I developed through a bit of research online, on how to get through a paper efficiently, while extracting the most relevant content and understanding the concepts to the desired depth. Each step of the process has a bullet point list on what should be done for this step. If you have any further valuable tips on how to make the process even smoother, feel free to reach out to me and I will be sure to add them with the proper acknowledgements.

### Step One; Getting a General Idea of the Content
Before reading a paper in depth, we want to get a general idea of what the topic is, how it approaches the topic, and whether it is relevant for the research being conducted. The goal is to get the necessary context before making the decision to read the paper or not. To do so, we can read the title, abstract, and conclusion of the paper in question. While reading it can be useful to identify the keywords for future reference. After having read through those sections, it can be decided whether or not the paper is relevant.

* Read title, abstract and conclusion
* Identify keywords
* Decide whether paper is relevant

### Step Two; Getting Context

Once we have decided whether or not this paper is of interest for us, we need to get familiar with more of the details. This can be thought of as acclimitization to the subject matter, which is the goal of this step. Knowledge acclimitization gives your brain the necessary context for understanding the rest of the paper in later passes. Once we know what to expect to a certain degree, our brain is primed to receive that knowledge and insights, making the absorption of the content much easier. To gain the necessary context before reading a paper, it is best to read the introduction and examine the tables and/or graphs. 

The introduction gives an overview of the high-level goal of the paper and why it is relevant by: 
- Highlighting why this topic is of interest
- Explaining the problem domain, research scope, and prior research
- Highlighting necessary prerequisite knowledge
- Introducing the goal of the research

The graphs and tables on the other hand, serve to get an understanding of what metrics are being used which helps to understand the contents of the paper better. They serve to provide support for the claims of the methods presented, thus give reader a better understanding as to whether these methods improve on current methods and to what extent. Furthermore, visual representation of data and performance enables an intuitive understanding of the contents.

* Read the Introduction
* Examine the Graphs, diagrams and figures
* Note anything that is unfamiliar or unknown for later reference

<!-- - the goal is to get familiar with the content and understand what we are dealing with
- Involves reading the introduction and examining the tables and graphs within the paper
- knowledge acclimatization provides an easier and more comprehensive examination of the study in later passes
- Reading the Introduction
    - overview of objective of the research efforts
        - explains problem domains, research scope, prior research efforts, methodologies
        - parallels to prior research
        - tells the reader what prerequisite knowledge is required to understand this paper
- Examining the Graphs, diagrams and figures
    - provide support for claims and methods presented
    - help understand contents of paper
    - tables are used within research papers to provide information on the quantitative performances of novel techniques in comparison to similar approaches.
    - visual representation of data and performance enables intuitive understanding of paper context
    - topological illustrations can help depicting the structure of the artificial neural network -->

### Step Three; Complete Readthrough

After having primed our brains for the paper by giving it the necessary context, the next step is to do a full pass of the paper, which means reading it all, end to end. In this step, it is important not to get hung up on things that we did not understand immediately and to leave them for later. In this first full pass, the goal is to understand most of what the paper is presenting and finding out which concepts, terms, formulas, derivations, or algorithms need to be looked at into more detail. In order not to lose sight of the full picture, these areas that require more time to be understood should be noted down for reference in step four but should not be dwelled on for long in step three. To read the full paper, it is usually best to start by reading the abstract and conclusion again before proceeding with the rest of the text and to take some quick notes per sections with short breaks in between the sections.

* Read abstract and conclusion
* Read entire text from introduction onwards
  * Skip over anything (equations, derivations, diagrams, etc.) too complex to understand on the first pass
  * Take brief notes per section and short breaks between sections
* Note all unfamiliar terms and concepts
* Note all the key insights and takeaways

<!-- - involves reading the entire text and skipping over complex equations, arithmetic, or technique formulations that may be more difficult to understand
- skip over any words, definitions, algorithms that you don’t understand or aren’t familiar with but note them for the later step
- Objective is to gain a broad understanding of what’s covered in the paper
    - start with abstract and conclusion and read the rest, taking notes along the way and breaks between sections
    - note all the key insights and takeaways
    - note all unfamiliar terms and concepts -->

### Step Four; Final Pass

In the final pass, the goal is to look into all unfamiliar terms, algorithms, definitions, concepts, and methods that were noted during the first full pass. It's important to take enough time to thoroughly understand everything in this step, so that we can conclude the reading of this paper with a confident feeling of having understood the subject matter. Use any external resources that can aid in understanding such as: presentations, blogposts, articles, textbooks, etc. Also, refer to the cited papers for help finding the appropriate resources. Finding the right aids is the key factor in successfully completing step four.

* Go through each term, algorithm, definition, concept, etc. that was unfamiliar (see your notes)
* Research each of the unfamiliar parts until they have been understood
* Find external resoureces to aid comprehension

Some useful places to look when it comes to machine learning research:

**[The Machine Learning Subreddit](https://www.reddit.com/r/MachineLearning/)**
**[The Deep Learning Subreddit](https://www.reddit.com/r/deeplearning/)**
**[PapersWithCode](https://paperswithcode.com/)**
**[Research Gate](https://www.researchgate.net/)**
**[Machine Learning Apple](https://machinelearning.apple.com/)**s

Top conferences:
**[NIPS](https://papers.nips.cc/)**, **[ICML](https://icml.cc/)**, **[ICLR](https://iclr.cc/)**, **[CVPR](https://cvpr2023.thecvf.com/)**

<!-- - final pass involves going through unfamiliar terms, alogrithms, definitions, concepts, and methods that were noted during step three.
- here, use external materials, searches to understand the unfamiliar parts of the paper
- don’t rush, take your time to understand
- The critical factor to a successful final pass is locating the appropriate sources for further exploration.
- some resources
    - **[The Machine Learning Subreddit](https://www.reddit.com/r/MachineLearning/)**
    - **[The Deep Learning Subreddit](https://www.reddit.com/r/deeplearning/)**
    - **[PapersWithCode](https://paperswithcode.com/)**
    - Top conferences such as **[NIPS](https://papers.nips.cc/)**, **[ICML](https://icml.cc/)**, **[ICLR](https://iclr.cc/)**
    - **[Research Gate](https://www.researchgate.net/)**
    - **[Machine Learning Apple](https://machinelearning.apple.com/)**
- Use the references of the paper to find appropriate resources to further understand research on which the paper was built -->

### (Optional) Step Five; Summarizing and Sharing

Especially when delving into a new topic, in can be very helpful to solidify your knowledge by writing short summaries on the topics or papers being read. This practice really cements the new topics by employing the **[feynman technique](https://en.wikipedia.org/wiki/Learning_by_teaching)**, where you attempt to draw on your knowledge to explain a novel concept in a comprehensive way to someone else. Writing summaries has the added benefit that they can be shared online through blogposts and serve as a reference for others when reading through similar material.

<!-- - to cement the knowledge acquired, it can be helpful to write a short summary that anchors your learnings in your long-term memory.
- these can even be publicized on blogs etc. to help others understand the topic and allow you to build a following and a brand -->

### Wrapping up

Reading research papers can be cumbersome, especially when you are new to it or to the topic. Having a structured approach can make it more manageable to take in the contents of more challenging papers but it is also important to note that knowledge acquisition takes time and should not be rushed. So take your time, remain focus and be sure to revisit more difficult concepts multiple times.

To summarize, these are the steps recommended when reading a research paper:

* Identify a topic
* Find research papers on the topic
* Read title, abstract, and conclusion to gain a vague understanding of the research effort aims and achievements.
* Familiarize yourself with the content reading the introduction and examining figures and graphs presented in the paper.
* Read the entire paper, skipping over more challenging or unfamiliar parts and noting them for later.
* Research unfamiliar terms, terminologies, concepts, algorithms, formulas, derivations, and methods using external resources.
* (Optional) Summarize in your own words essential takeaways, definitions, and algorithms.

### Sources:

https://developer.nvidia.com/blog/how-to-read-research-papers-a-pragmatic-approach-for-ml-practitioners/

https://www.turing.com/kb/how-to-write-research-paper-in-machine-learning-area