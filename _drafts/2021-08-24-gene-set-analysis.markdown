---
layout: post
title:  "Gene set analysis methods"
date:   2021-08-24 00:00:00 -0500
category: technical 
tags: [biology, statistics, genomics, transcriptomics] 
---


## Motivation: extracting insight from transcriptomic data

### A flood of transcriptomic data

Chip seq

RNA-seq

### Single genes versus gene sets

* Gene sets are a more biologically meaningful level of analysis than individual genes.
  - E.g., 20% upregulation for a _pathway_ of genes typically has greater biological impact than 200% upregulation for a single gene.
* Differential expression can be detected more reliably for a _set_ of genes, than for individual genes.
  - Greater sensitivity
  - Greater precision 

## Some gene set analysis methods

### Commonalities between methods

1. _Experimental design_
  * How do the measured samples relate to each other?
  * Gene set analyses usually need multiple samples belonging to two classes (e.g., "normal" and "tumor")
  * The goal is to identify systematic differences between the two _classes_&mdash;rather than estimating properties of individual samples.
2. _Scoring_: 
  * Compute an "expression score" for each gene set&mdash;a quantitative comparison between the two classes.
  * A large positive value indicates higher-than-normal expression for that gene set.
  * A large negative value indicates lower-than-normal expression for that gene set.
3. _Statistical Significance_
  * Estimate the statistical significance for each gene set's expression score.
  * What is the null hypothesis?
  * What is the probability of attaining the computed expression score, under the null hypothesis?
4. _Account for Multiple-Hypothesis Testing_: 
  * Adjust the significance estimates, accounting for multiple-hypothesis testing


### The original: GSEA (2005)

1. _Experimental Design_
  * The typical assumptions: multiple samples belonging to two classes.
  * In practice, GSEA requires relatively many samples in each class in order to produce reliable results.
2. _Scoring_. GSEA uses the following steps to score a gene set: 
  * For each gene, compute the correlation between measured expression and phenotype.
  * Sort the genes by these correlations.
  * Compute a running sum over the sorted list of genes.
    - If a gene is in the gene set, increment the running sum.
    - If a gene is _not_ in the gene set, _decrement_ the running sum.
    - The expression score is the maximum absolute value attained by the running sum.
3. _Statistical Significance_.
  * GSEA uses an empirical null hypothesis.
    - randomly permute the samples' class labels.
    - run the scoring procedure.
    - repeat 10k times, and count the fraction of times we exceed the score from step 2.
    - this fraction is an empirical p-value.
  * GSEA also allows a (weaker) null hypothesis that permutes _gene labels_ rather than _class labels_.
    - This is less precise, since the null hypothesis doesn't capture correlation between genes.


### GAGE (2009)

### QuSAGE (2013)


## Speculation about the future



[Link to asset]({{site.url}}/assets/myfile.pdf)

\\( \blacksquare\\)  

