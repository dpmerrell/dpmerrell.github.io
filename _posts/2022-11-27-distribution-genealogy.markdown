---
layout: post
title:  "A genealogy of probability distributions"
date:   2022-11-27 00:00:00 -0500
category: technical
tags: [probability, statistics] 
---

Some of the Wikipedia pages I visit the most belong to probability distributions:

* [Multivariate normal](https://en.wikipedia.org/wiki/Multivariate_normal_distribution])
* [Poisson](https://en.wikipedia.org/wiki/Poisson_distribution)
* [Gamma](https://en.wikipedia.org/wiki/Gamma_distribution)
* [Negative binomial](https://en.wikipedia.org/wiki/Negative_binomial_distribution)
* [Beta](https://en.wikipedia.org/wiki/Beta_distribution)
* Etc.

My favorite parts of these pages are the "Related distributions" and "Random variate generation" sections.
Those sections describe (i) sometimes-surprising mathematical relationships between probability distributions and (ii) algorithmic strategies for generating samples from them.

This paints an interesting picture in my head: a family tree of probability distributions.
It's not actually a tree, but it is a directed graph that suggests some distributions are more ancestor-like while others are more descendant-like.

I've sketched it out in the SVG below.
Making this diagram required many choices regarding (a) which information to include and (b) how to display it in space.
You're free to disagree with my choices.

I really wanted to capture some of the _generative stories_ underlying these distributions.
The diagram contains a combination of exact, approximate, asymptotic, and algorithmic relationships.
Various other relationships are excluded: conjugate priors, for example.

![title text]({{ site.baseurl }}/assets/images/distribution-genealogy.svg){:width="300px"} 

Try opening the image in a new tab and zooming in for a closer look.

In this picture, randomness begins with nearly-physical representations of uncertainty: fair coins and urns.
The central limit theorem gives the normal distribution a "sink-like" quality in the directed graph (though Cauchy and some Pareto or t-distributions evade capture).

The relationship between e.g., Binomial and Poisson&mdash;marked "flips \\( \rightarrow \infty\\)"&mdash;glosses over a beautiful mathematical process that I might describe in a future post.

\\( \blacksquare\\)  

**Edit 2022-12-15:** Yesterday I came across [Larry Leemis's website](http://www.math.wm.edu/~leemis/chart/UDR/UDR.html) that does something similar, but in much greater detail. [Larry Leemis](http://www.math.wm.edu/~leemis/) is a professor at William and Mary.

