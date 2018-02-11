---
layout: post
title:  "Proving Algorithmic Fairness - Introduction"
date:   2016-09-01 20:00:00 -0500
category: research 
tags: [wisconsin, albarghouthi, dantoni, drews, microsoft, nori, fairness] 
---

# Overview

This semester (Fall 2016) I'm beginning an independent study course with 
[Dr. Aws Albarghouthi](http://pages.cs.wisc.edu/~aws/) of UW-Madison's 
CS department. His research focuses on the "art and science of program 
analysis." 

During this course, we plan to investigate an idea called "algorithmic
fairness." It is interesting for both its technical content and
cultural relevance. Here's an example illustrating algorithmic 
fairness's place in the big picture:

*Suppose you're hiring employees for your business, and you've decided
to use a fancy machine learning algorithm to sift through piles of application
documents and select candidates for interviews[^1]. In hiring, it is ethically
correct (and legally necessary) to be unbiased with respect to protected 
classes---e.g., race or religion. Can you guarantee that your algorithm is 
unbiased?* 

In order to get me acquainted with this topic, Dr. Albarghouthi pointed me 
to a paper he's been collaborating on, titled "Proving Algorithmic 
Fairness"[^2]. There is already a body of work devoted to the topic of 
algorithmic fairness[^3], but this paper introduces the following innovations:

* It presents the notion of fairness *with respect to a **population model***.
  A population model can be thought of as a "random person generator", drawing
  from a joint distribution over the space of demographic traits. In our hiring
  example, it would describe the population of possible applicants. The 
  population model is a useful construct in that it provides a standard
  by which to judge fairness. For example, if the population of possible
  applicants has a certain ethnic composition, we can judge the fairness of
  an algorithm by comparing the ethnic composition of its output with the 
  population's ethnic composition. Previous literature on the subject 
  judges fairness with respect to particular datasets instead; it is argued
  that these datasets may possibly be biased themselves. It is envisioned that
  social scientists in government agencies or NGOs would prepare these models.
 
* The paper introduces a new-fangled integration method for its computation
  of probabilities. It's described as a symbolic volume-computation algorithm 
  that uses an SMT solver. The paper's new method is preferred over more 
  typical  Markov Chain Monte Carlo integrators because it guarantees
  a lower bound for the integral; this guarantee allows us to *prove* 
  fairness or unfairness, rather than express a mere statistical *confidence* in
  fairness or unfairness. 

* The concepts of the paper are packaged into a fairness verification tool
  called *FairSquare*, which is tested against a set of benchmark population
  models and classifier algorithms.

# Proving Fairness

Suppose we have a binary classifier algorithm \\(\mathcal{P}\\), whose input is
a person \\(\vec{v}\\) (a vector of that person's traits) and whose output is 
"true" or "false", "hired" or "not hired", etc. A proof of fairness for 
algorithm \\(\mathcal{P}\\) consists of showing that the following inequality
holds:

$$ \frac{P[\mathcal{P}(\vec{v}) \; | \; v_s = true]}{P[\mathcal{P}(\vec{v}) \; | \; v_s = false]} > 1 - \epsilon$$

where \\(v_s \\) is an entry of \\(\vec{v}\\) indicating whether the person
belongs to a protected class---e.g., a particular religion or ethnicity---and
\\(\epsilon < 1\\) is some agreed-upon or mandated standard of fairness, with 
smaller \\(\epsilon\))s implying stricter fairness requirements. 
In English: if we have two people who are equal in every way except their status
in a protected class, we must show that the algorithm is equally likely to 
approve both people (within some threshold). 

Note that it isn't sufficient for the algorithm to
simply ignore protected class data; correlations between protected
class data and hiring criteria can lead to unbalanced outcomes even if
ethnicity or religion are simply "left out" of a hiring algorithm. 

In proving this inequality, it is useful to eliminate the conditional
probabilities via the identity \\(P[A | B] = \frac{P[A \land B]}{P[B]}\\),
giving the inequality

$$ \frac{P[\mathcal{P}(\vec{v}) \; \land  \; v_s = true] \cdot P[v_s = false]}{P[\mathcal{P}(\vec{v}) \; \land \; v_s = false] \cdot P[v_s = true]} > 1 - \epsilon$$

The probabilities of intersections are easier to directly compute than
conditional ones. 

In order to prove the inequality, it suffices to find a lower bound 
\\(> 1 - \epsilon\\) on the 
LHS; hence it suffices to find lower bounds on the probabilities in the 
numerator, and upper bounds on the probabilities in the denominator.
Similarly, in order to disprove the inequality (i.e. prove unfairness), 
it suffices to find an upper bound on the numerator and a lower bound on
the denominator. This pursuit of upper and lower bounds lends itself to the 
paper's Symbolic Volume Integration scheme, which is proven to converge to 
exact integrals in a monotonically increasing manner.

In upcoming posts, I will dig into the content of this paper in more detail.
Topics will include the paper's Symbolic Volume Integration scheme and a 
description of the *FairSquare* tool's performance on some benchmarks.
\\( \blacksquare\\)  

&nbsp;

&nbsp;

[^1]: Using an algorithm is a good idea not only for the obvious speed considerations, but also for consistency; Daniel Kahneman's research in behavioral psychology has shown that even simple classifier algorithms are more reliable for candidate selection (among other things) than human judgment. See [*Thinking, Fast and Slow*](https://www.amazon.com/Thinking-Fast-Slow-Daniel-Kahneman/dp/0374275637/ref=sr_1_1?ie=UTF8&qid=1329063030&sr=8-1), Part III, chapter 21: Intuitions vs. Formulas. 

[^2]: Albarghouthi, D'Antoni, Drews, Nori; in submission as of this writing (2016-09-01).

[^3]: See these for example: [*Fairness Through Awareness*](https://arxiv.org/abs/1104.3913); [*Certifying and Removing Disparate Impact*](https://arxiv.org/abs/1412.3756)
