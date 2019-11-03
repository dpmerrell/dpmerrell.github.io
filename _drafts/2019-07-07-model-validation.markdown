---
layout: post
title:  Cross-Validation: Why and How 
date:   2018-07-17 22:00:00 -0500
category: personal 
tags: [machine learning, methodology] 
---

Machine learning frameworks like scikit-learn have made it very easy to do basic machine learning tasks: 
training models, testing them, and using them to make predictions.

However, these frameworks also make it easy to do machine learning _incorrectly_. 
They do _not_ guarantee that practitioners use correct methodology.

I've seen machine learning practitioners make the following mistakes:
* Clean, standardize, or normalize the entire dataset _before_ making a train/test split
* Fail to use _grouping_ to ensure their train/test splits are valid


## The Big Idea: Estimating a Model's Performance

## Train/Test Leakage

### The train/test independence assumption

### The test/deployment iid assumption

### Grouped splits

## Cross-Validation

### Independence across folds

## A More Complicated Setting: Time-series data

\\( \blacksquare\\)

