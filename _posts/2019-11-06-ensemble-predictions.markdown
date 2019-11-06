---
layout: post
title:  "Group Decisions: Humans and Machines"
date:   2019-11-06 00:00:00 -0500
category: personal 
tags: [machine learning, decision making, humans, organizations, management] 
---

## Group decisions

* We often find ourselves making decisions as a group:
    - A group of friends, planning an outing
    - Members of an organization, deciding on a course of action
    - Citizens in a republic, deciding who should represent them

* Some take it as an article of faith that groups are 
  smarter than individuals&mdash;as though more brains were an unalloyed good in any situation. 

<!--
    - My public school education&mdash;while it lasted&mdash;always emphasized the importance of "teamwork" and "collaboration". (It certainly didn't try to foster _independence_ or _originality_.) 
    - To me, the value of collaboration always seemed more nuanced.
    - Most of the processes that keep civilization from collapsing _do_ require cooperation between large numbers of people. So in that sense, the public schools were right to emphasize cooperation.
    - However, I always thought that before a good idea can spread and get implemented, _somebody_, at some point, had to do some deep thinking and _generate that idea_&mdash;which is difficult to do in a crowd.
-->

* We know that some organizations are highly functional while others are highly dysfunctional. This is enough to show that the value of collaboration depends strongly on additional factors. 

* We are faced with this question: _what are the conditions for effective group decision making?_ 

* It turns out that machine learning researchers have been thinking about this question for a while, and have produced fascinating answers.

<br>

## Lessons from machine learning: ensemble prediction

* When faced with a difficult prediction task, data scientists will often train _many models_ to make the prediction, and then figure out a way to _combine_ those predictions into a group prediction. The hope is that the group will be more accurate than any of the individuals.

* We call this strategy **ensemble prediction**.
  Researchers have figured out multiple ways to combine models into ensembles; and have identified conditions that determine whether the ensemble will in fact perform better than its individuals.

* We'll describe some ensemble methods. Then we'll apply the insights from machine learning to decision-making in human groups.

### Bagging (TODO) 

[wiki](https://en.wikipedia.org/wiki/Bootstrap_aggregating)

### Random Forests (TODO)


[wiki](https://en.wikipedia.org/wiki/Random_forest)

### Boosting (TODO)

* [Adaptive Boosting](https://en.wikipedia.org/wiki/AdaBoost)
* [Gradient Boosting](https://en.wikipedia.org/wiki/Gradient_boosting)

<br>

## Implications for human group decisions

* **The quality of our group decisions depends on our _mechanism_ for combining brain-power.**
    - Bagging translates directly to a _voting system_ for group decisions.
      Voting systems have been studied for a long time by [public choice theorists](https://en.wikipedia.org/wiki/Public_choice); some systems are better than others.
        - [First past the post](https://en.wikipedia.org/wiki/First-past-the-post_voting). Used in American political elections. Known to have many flaws. Does not efficiently extract insight from individual voters. (In the political setting, it also has the undesirable consequence of producing two-party systems.)
        - [Ranked choice voting](https://en.wikipedia.org/wiki/Ranked_voting). Often touted as a replacement for first past the post.  [Arrow's impossibility theorem](https://en.wikipedia.org/wiki/Arrow%27s_impossibility_theorem) proves that ranked choice systems are unable to simultaneously satisfy various desirable notions of fairness.
        - [Score voting](https://en.wikipedia.org/wiki/Score_voting). Most resembles bagging, but differs in that it does not _normalize_ each voter's distribution of preferences.
            * It has many desirable properties. Because it is a [cardinal voting system](https://en.wikipedia.org/wiki/Cardinal_voting) and not an [ordinal voting system](https://en.wikipedia.org/wiki/Ranked_voting), it side-steps Arrow's infamous theorem. And it does in fact satisfy the kinds of fairness forbidden by the theorem.
            * A normalized version would address the critique that cardinal voting is based on a notion of utility, and that utility cannot be compared meaningfully between individuals. A normalized score system&mdash;identical to bagging&mdash;would be formulated as _predicting which choice is best_&mdash;not some notion of utility maximization.
        - In bagging, models are required to make their predictions _independently_ of each other. This is a mathematical argument for the idea that voters ought to form their decisions independently&mdash;rather than blindly following someone else's opinion.
    - Adaptive boosting combines individual predictions via _weighted vote_. This suggests a voting system where different voters have different levels of credibility, dependent on their past performance. 

* **The quality of our group decisions depends on the _composition_ of our group.**
    - The success of bagging in general, and Random Forests/ExtraTrees in particular, suggests that a large amount of "cognitive diversity" is a good thing in voting-based decisions. This includes
        * Randomly chosen training sets \\(\Leftrightarrow\\) variety of background experience
        * Randomly chosen variables \\(\Leftrightarrow\\) variety of interest and attention
        * Randomly chosen split-points \\(\Leftrightarrow\\) variety of ways that different brains process the same information 
    - Bagging only works if each member of the ensemble performs better than random. We don't get any improvement by combining bad models.
    - Bagging is primarily a method for reducing the [_variance_](https://en.wikipedia.org/wiki/Bias%E2%80%93variance_tradeoff) of a predictor. It doesn't address prediction bias. Roughly speaking: as an ensemble of humans grows larger, the idiosyncratic cognitive flaws of its individuals will cancel out. But the average human cognitive patterns will persist. Humans tend to have high variance, so bagging still yields an advantage. 
    - Adaptive boosting can be thought of as a collection of specialists, selected in such a way that they compensate for each other's weaknesses. Each individual may be quite weak&mdash;only slightly better than random&mdash;but they need to be selected very carefully and their votes combined with appropriate weighting.

\\( \blacksquare\\)  

