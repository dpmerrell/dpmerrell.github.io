---
layout: post
title:  "Proving Algorithmic Fairness II - Symbolic Volume Integration"
date:   2016-09-05 20:00:00 -0500
category: research
tags: [wisconsin, albarghouthi, dantoni, drews, microsoft, nori, fairness, smt, logic, integrate] 
---

# Background

This is a walk-through explanation of the Symbolic Volume Integration method 
mentioned in 
[Part I]({% post_url 2016-09-01-proving-algorithmic-fairness %})
of this Algorithimic Fairness post series. 

In order to prove or disprove the fairness of an algorithm, we must prove or 
disprove the following inequality:

$$ \frac{P[\mathcal{P}(\vec{v}) \; \land  \; v_s = true] \cdot P[v_s = false]}{P[\mathcal{P}(\vec{v}) \; \land \; v_s = false] \cdot P[v_s = true]} > 1 - \epsilon$$

where \\(v_s \\) is an entry of \\(\vec{v}\\) indicating whether the person
belongs to a protected class---e.g., a particular religion or ethnicity---and
\\(\epsilon < 1\\) is some agreed-upon or mandated standard of fairness, with 
smaller \\(\epsilon\\)s implying stricter fairness requirements. 

# Motivation: Proof Beats Confidence
 
In the world of scientific computing, probabilities---like those in the above
inequality---are typically
estimated using Markov Chain Monte Carlo techniques, which are known to perform 
well in a variety of cases and allow the underlying process to be treated as a 
black box. Due to the stochastic nature of MCMC, any conclusion based on it must
be stated in terms of statistical certainty. In this respect, the new Symbolic Volume 
Integration method has an advantage 
over MCMC---it allows a *proof* of the fairness condition,
rather than a statement of statistical confidence. With proof within 
convenient reach, it is unjustifiable to settle for mere confidence. 

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
can translate them into a set of logical constraints[^1]. 

# The Algorithm
Symbolic Volume Integration consists of the following steps:

* Translate Code into a Predicate Logic Formula
    - Assuming that the population model and decision program can 
    both be expressed as sequences of assignments, probabilistic 
    assignments, and conditional expressions involving simple arithmetic
    (addition and multiplication), we can translate their sequential,
    imperative commands into conjunctions of declarative logical statements.
    - Since we ultimately care about the *composition* of the population 
    model and the decision program---letting the outputs of the population
    model be the inputs of the decision program---we can create one big
    logic formula by conjoining their individual logic formulas. 
    - We conjoin additional requirements to the formula, in order
    to specify the possibility for which we wish to compute probability. 
    For example, if we wanted to compute 
    \\(P[\text{hired} = true  \land \text{age} \ge 60]\\)
    , we would conjoin \\((\text{hired} = true \land  \text{age} \ge 60)\\)
    to the formula. We now have a Big Formula.
    - For each probabilistic assignment in the program, you can think of there
    being a free variable in our big formula. E.g. if a random value for 
    "age" is generated in the population model, it would be a free variable 
    in the logic formula.
    - The free variables just mentioned form a real space, \\(\mathbb{R}^n\\)
    (where \\(n\\) is the number of free variables). Only certain combinations
    of these variables will actually satisfy the big logic formula we constructed.
    It turns out that the valid combinations form a region in \\(\mathbb{R}^n\\),
    which we will call the "admissible region". We can find points in the admissible
    region by using a SMT solver ("Satisfiability Modulo Theories"; in our case, 
    we use an SMT solver called Z3). Bear in mind that the free variables
    are probabilistically assigned, so each of them has an associated PDF. In 
    combination, this implies a joint PDF over \\(\mathbb{R}^n\\) formed by 
    their product (they are independently distributed). 
    Hence, computing probability for a given scenario entails 
    integration of the joint PDF over the scenario's admissible region.
    
* Decompose the Admissible Region into Hyperrectangles
* Integrate over the Hyperrectangles and  


[^1]: Proving an algorithm's fairness would in practice require access to the algorithm's source and parameters. Perhaps future regulators would use black box MCMC methods to identify possible violations of fairness and then request the necessary details as part of an audit.  

 
