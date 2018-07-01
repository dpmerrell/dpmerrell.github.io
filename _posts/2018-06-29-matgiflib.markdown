---
layout: post
title:  "Matgiflib: Making GIFs with Matplotlib"
date:   2018-06-29 09:00:00 -0500
category: personal 
tags: [visualization, python, repository] 
---

Some observations:

* Among python programmers, Matplotlib is the dominant package for visualizing information. It is powerful in the hands of skilled users. 

* On the web, GIFs have become a very popular mode of animation.

* Matplotlib's native animation API isn't very straightforward---at least to me.

In light of these observations, I have built a python package which provides a very simple interface for making GIFs with Matplotlib.

My guiding philosophy was to interfere as little as possible with typical Matplotlib programming patterns (e.g., the pyplot interface). Basic familiarity with Matplotlib gets the programmer 99% of the way to making nice GIFs.

There are still improvements to make, but the code is publicly available on Github:

[Matgiflib](https://github.com/dpmerrell/matgiflib)

\\( \blacksquare\\)

