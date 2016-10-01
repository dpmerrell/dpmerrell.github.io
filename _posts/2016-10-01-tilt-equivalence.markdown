---
layout: post
title:  "Tilt Equivalence in Symbolic Volume Integration"
date:   2016-10-01 05:00:00 -0500
category: research 
tags: [wisconsin, albarghouthi, dantoni, drews, microsoft, nori, fairness] 
---

I've been continuing my involvement in "Algorithmic Fairness" research.
In particular, I've been working on an improvement to the Symbolic
Volume Integration (SVI) method mentioned in a [previous post]({% post_url 2016-09-05-symbolic-volume-integration %}). 
The idea is to modify SVI in a way that makes it converge
faster. While the previous SVI method depends on the construction of rectangles
that are aligned with the axes, we're aiming to allow rectangles that
are "rotated" or "tilted" with respect to the axes.

To that end, I showed that rotating a rectangle for SVI is equivalent to 
applying the inverse rotation to the region of integration. 

[Here's a link to the writeup.]({{site.url}}/assets/tilt-equivalence.pdf)
\\( \blacksquare\\)  

