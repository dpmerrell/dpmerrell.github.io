---
layout: post
title:  "What Machine Learning Can Tell Us About Group Decisions"
date:   2018-04-06 23:59:59 -0500
category: research 
tags: [ml, decisions, management] 
---

_When do Groups Actually Make us Smarter?_

Most of us will work in a group at some point during our lives.

In modern America, people are conditioned from a young age to value teamwork and collaboration.

* Kids are encouraged to play team sports; 

* students are assigned group projects; 

* job postings seek "team players" to fill "interdisciplinary" roles.

Despite the hype, anyone who has worked in a group knows how disfunctional they can be.

As our economy moves toward "knowledge work," more of our labor consists of decision-making.
We can expect much of this decision-making will happen within groups---teams, committees, etc.
Despite these trends, it's not obvious that groups are better than individuals at making decisions.

This leads to some reasonable questions:

* When is it better to make decisions in groups? 

* When is it better to make decisions as an individual?

* What can we do to help a group make better decisions over time? 

It turns out that ideas from machine learning can yield insight to these questions.

This post will scratch the surface of relevant machine learning concepts.
We'll extract useful results that can inform group efforts.

## Ensemble Methods: An ML Perspective on Competence and Diversity

Machine learning practitioners seek models that are as accurate as possible.
Often times, they want to train a model that _classifies_ inputs---that sifts them into categories. 

For example, a data scientist might train a classifier to decide whether an email is "spam" or "not spam".
An accurate classifier correctly flags the spam emails without flagging good emails.

Machine learning researchers have found techniques to get higher accuracy by combining multiple classifiers.
These techniques are called _ensemble methods_---they use an _ensemble_ of classifiers to get superior performance. 
In the following sections we'll look at the theory behind ensemble methods and take away some lessons about group productivity. 

# Ensemble Methods: Some Theory

The theoretical justification for ensemble methods goes something like this...

Suppose we have a set of $$n$$ classifiers, which we'll call $$h_1, h_2, \ldots, h_n$$.

For every classifier $$h_i$$, we define a random variable $$X_i \sim \text{Bernoulli}(p_i)$$ that tells when $$h_i$$ makes a mistake. That is, each time a classifier makes a decision, we flip a weighted coin and say the classifier makes a wrong decision if it lands "heads."

We make the following assumptions:

* This is important: we assume the classifiers' mistakes are _independent_ of each other. Their variables $$X_i$$ are uncorrelated.

* We use the classifiers to make a "group decision" by simple plurality vote.

Under these conditions, the 

# Ensemble Methods: Actionable Insights

## The Weighted Majority Algorithm: Organizations Can Learn Over Time

# Some Theory

# Case Study: The World's Biggest Hedge Fund

## Parting Thoughts

Most important takeaways

Speculation: superintelligent organizations?


$$ \frac{P[\mathcal{P}(\vec{v}) \; \land  \; v_s = true] \cdot P[v_s = false]}{P[\mathcal{P}(\vec{v}) \; \land \; v_s = false] \cdot P[v_s = true]} > 1 - \epsilon$$

&nbsp;

&nbsp;

[^1]: 

