---
layout: post
title:  "Themes from ICML 2022"
date:   2022-07-26 00:00:00 -0500
category: personal 
tags: [machine-learning, conference, ml, ai] 
---

I had the fortune of attending [ICML 2022](https://icml.cc/Conferences/2022) in Baltimore, MD last week.

I didn't present any of my work there&mdash;I went because [my advisor](https://www.biostat.wisc.edu/~gitter/) was invited to give a talk in the [AI for Science](http://www.ai4science.net/icml22/) workshop. 
Tony said I could attend the conference, and I was happy to oblige!

It was refreshing to go back to a big machine learning conference, post-pandemic.
Apparently ~6,000 people registered for the conference.
They had 10 sessions running in parallel for three days, and two more days of workshops after that.

It was a deluge of information; I could only catch a small fraction of the content.
I paid attention and [took some notes]({{site.url}}/notes/icml-notes.html), though.

Some themes stood out to me.
I'll list them here in no particular order:

* Biological and chemical applications. The conference had 3 keynote talks, and 2 of them focused on biological applications. There was a computational biology workshop on Friday, and an AI for science workshop on Saturday&mdash;biology and chemistry took center stage in the AI for science workshop.
* Graph neural networks; transformers.
  There were several sessions devoted to GNNs and attention mechanisms.
* Robustness; distributional shift; out-of-distribution (OOD) detection.
  There were sessions and workshops devoted to these topics.
  I didn't attend them, but I saw many of their posters.
  UW-Madison was well-represented in this area.
  [Sharon Li's group](https://pages.cs.wisc.edu/~sharonli/) presented half a dozen or so papers.
* Self-supervised learning and contrastive learning.
  These have become dominant learning paradigms in recent years&mdash;the "general purpose self-supervised training followed by application-specific fine tuning" strategy seems to work great for images and natural language.
  On a somewhat related note: a surprising number of talks focused on data augmentation.
* Multi-modal tasks and representations.
  Most often learning unified representations from images and natural language.
  (I can imagine this extending to, e.g., multiomic data).
* Certain kinds of mathematical sophistication.
  SE(3) layers; invariant and equivariant features.
  Connections between ODEs/PDEs and neural networks.
  Using neural nets to solve differential equations; using differential equations as a form of prior knowledge; using neural networks to solve ill-posed inverse problems.
  These use concepts that I recognize from physics, but haven't noticed in ML until now.

I want to flesh out the first bullet point a bit more; the emphasis on biological and chemical applications.
The two relevant keynotes were given by Regina Barzilay (MIT) and Aviv Regev (Genentech).
Additionally, I'll mention workshop talks by Daphne Koller (Insitro) and Chris Langmead (Amgen).
All of these talks seemed to emphasize that _data is the bottleneck in biological and chemical applications_. 
Several of them seemed to propose closed loops between ML models and laboratories&mdash;an active learning framework. 

I won't claim that these themes give an objective picture of ICML.
Think of it as an opinionated summary.
I'd be interested to hear other people's observations.


<!-- Internal link
[Link to asset]({{site.url}}/assets/myfile.pdf)
-->

<!-- Include an image
![title text]({{ site.baseurl }}/assets/images/your-image.jpg){:height="200px" :width="300px"} 
-->

\\( \blacksquare\\)  

