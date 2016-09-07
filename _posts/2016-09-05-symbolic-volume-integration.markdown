---
layout: post
title:  "Proving Algorithmic Fairness II - Symbolic Volume Integration"
date:   2016-09-05 20:00:00 -0500
category: article
tags: [wisconsin, albarghouthi, dantoni, drews, microsoft, nori, fairness, smt, logic, integrate] 
---

# Background

This is a walk-through explanation of the Symbolic Volume Integration method 
mentioned in Part I of this Algorithimic Fairness post series. 

In order to prove or disprove the fairness of an algorithm, we must prove or 
disprove the following inequality:

$$ \frac{P[\mathcal{P}(\vec{v}) \; \land  \; v_s = true] \cdot P[v_s = false]}{P[\mathcal{P}(\vec{v}) \; \land \; v_s = false] \cdot P[v_s = true]} > 1 - \epsilon$$

where \\(v_s \\) is an entry of \\(\vec{v}\\) indicating whether the person
belongs to a protected class---e.g., a particular religion or ethnicity---and
\\(\epsilon < 1\\) is some agreed-upon or mandated standard of fairness, with 
smaller \\(\epsilon\\)s implying stricter fairness requirements. 

# Proof Beats Confidence
 
In the world of scientific computing, probabilities like these are typically
estimated using Markov Chain Monte Carlo techniques, which are known to perform 
well in a variety of cases and allow the underlying process to be treated as a 
black box. However, the Symbolic Volume Integration method has an advantage 
over MCMC in this application---it allows a *proof* of the fairness condition,
rather than a mere statement of statistical confidence. With proof within 
convenient reach, it is unjustifiable to settle for confidence. 

Symbolic Volume Integration can prove (or disprove) the fairness 
inequality because it guarantees a lower bound on its integral.
Note that in a probabilistic setting the method can also be used to compute 
upper bounds on probabilities; if we need an upper bound on 
\\(P[A] = 1 - P[\neg A]\\), it suffices to find a lower bound on 
\\(P[\neg A]\\). By finding lower bounds on the probabilities in the numerator 
and upper bounds on the probabilities in the denominator, we can prove the
fairness condition. Likewise, upper bounds on the numerator and lower
bounds on the denominator would allow us to disprove the fairness condition.

While Symbolic Volume Integration allows us to obtain a proof of algorithmic 
fairness, it does require an intimate knowledge of the algorithm in 
question. A black box representation of the algorithm will not suffice; 
Symbolic Volume Integration requires the contents of the algorithm so that it
can translate them into a set of logical constraints. 

Proving an algorithm's fairness would
in practice require access to the algorithm's source and parameter settings.
Perhaps future regulators would use black box MCMC methods to identify
possible violations of fairness and then request the necessary 
details as part of an audit.  

 
