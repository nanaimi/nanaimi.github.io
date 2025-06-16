---
layout: distill
title: notes on a machine learning experimentalist
description: How do the world's leading researchers in machine learning go about conducting experiments?
date: 2024-07-14
categories: academic
published: true

authors:
  - name: Nasib Naimi
    affiliations:
      name: Reliant AI

# bibliography: 2018-12-22-distill.bib

# Optionally, you can add a table of contents to your post.
# NOTES:
#   - make sure that TOC names match the actual section names
#     for hyperlinks within the post to work correctly.
#   - we may want to automate TOC generation in the future using
#     jekyll-toc plugin (https://github.com/toshimaru/jekyll-toc).
toc:
  - name: Why should you bother?

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

## Why am I writing this?

Somehow, through the sheer force of my stuborness and a inordinate amount of luck, I find myself working side-by-side with one of the world's foremost experts on machine learning, specifically reinforcement learning. Marc G. Bellemare was arguably conducting research in AI before it became _"cool"_ and was one of the first 40 employees at DeepMind.

So, granted this great opportunity, I thought it wise to keep notes on how leading experts go about sniffing out the signal from the mess that is machine learning experimentation.

## How should we think about experiments?

Experiments are a tool for exploration. What we wish to discover, is the direction that is promising and aligns with our intuition and hypothesis. As we experiment, i.e explore, more, our intuition and hypothesis should evolve in a conclusive way. Taking the information theoretic perspective, if we start with a system that has high entropy, we wish to measure the random variable that allows us to reduce the entropy the most. This is equivalent to saying we want to gain the most information possible from an experiment. By doing so, we narrow down the distribution post measurement and are able to get a better sense of which direction we should head in. 

Think of experiments as nodes in a tree, where each outcome bifurcates the tree and either concludes in an validated hypothesis or opens up a new question that needs to be answered by an experiment.

## Best practices when setting up an experiment


## Best practices for interpreting results from experiments



