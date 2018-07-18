---
layout: post
title:  A Singularity Container for Deep Learning 
date:   2018-07-17 22:00:00 -0500
category: personal 
tags: [visualization, python, repository] 
---

I recently began using containers as part of my research.

The concept is pretty compelling. Containers allow people to... 

* Take their environments with them as they work on different hosts.
  This makes them less dependent on the mercy of system administrators.

* Scale deployment in a very straightforward fashion:
  just copy the container!
  This has big implications in the world of web applications.

* Improve the replicability of computing research.
  It's not enough for researchers to share their code.
  Software usually depends on the host environment in complicated ways.
 
I spent the past several days figuring out how to build [Singularity](http://singularity.lbl.gov/) containers for deep learning.
It was surprisingly difficult to set things up---I had to dig through cryptic error messages, web forums and blog posts to get the information I needed.

After all that labor, I have created a recipe for building Singularity containers equipped with TensorFlow and Keras.
[It's available in this repository.](https://github.com/dpmerrell/singularity-deep-learning)
I hope that it helps other people figure things out faster than I did.

I realize that [Docker](https://www.docker.com/) is the preeminent container service.
I would use it, but Singularity struck me as an easier sell to my system administrators.
I'm working with University of Wisconsin's Biostatistics Department, which often deals with
electronic health records and other sensitive information.
Singularity was designed for these kinds of settings, and has been widely adopted at national laboratories and other research institutes.

\\( \blacksquare\\)

