---
layout: post
title:  "Some Work in Symbolic Volume Integration"
date:   2016-10-01 05:00:00 -0500
category: research 
tags: [wisconsin, albarghouthi, dantoni, drews, microsoft, nori, fairness] 
---

I've been continuing my involvement in "Algorithmic Fairness" research.
In particular, I've been working on an improvement to a Symbolic
Volume Integration (SVI) method.

The idea is to modify SVI in a way that makes it converge
faster. While the previous SVI method depends on the construction of rectangles
that are aligned with the axes, we're aiming to allow rectangles that
are "rotated" or "tilted" with respect to the axes.

Below are links to some of my research notes:

[Rotated formulas yield the same probabilities.]({{site.url}}/assets/research-notes/tilt-equivalence.pdf)

[The Skitovitch-Darmois Theorem says we can only do this with Gaussian variables.]({{site.url}}/assets/research-notes/skitovitch-darmois.pdf)

[How to generate rotation matrices with rational entries.]({{site.url}}/assets/research-notes/rational-householder.pdf)

Note: we ended up doing the analogous thing with Givens Rotations, rather than Householder Reflections.

\\( \blacksquare\\)  

