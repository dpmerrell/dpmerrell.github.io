---
layout: post
title:  "A less-bad blog post about transformers"
date:   2023-01-21 00:00:00 -0500
category: technical 
tags: [machine-learning, ai] 
---


Some important things to understand about the transformer architecture:

* The transformer is a _sequence-to-sequence_ model.
    - That is, it receives a sequence \\(x_1, x_2, \ldots, x_M \\) as input and produces a new sequence \\(y_1, y_2, \ldots, y_N\\) as output.
    - Concretely, AIAYN presents the transformer as a model for translating text from one language to another (like in Google Translate).
* The transformer has two primary components: an _encoder_ and a _decoder_.
    - The encoder receives an input sequence and transforms it into a latent representation.
      The idea is that this latent representation _encodes_ the input in some informative way.
    - The decoder receives the latent representation and transforms it into a useful output.
* The transformer is _autoregressive_. That is:
    - it generates the output sequence _one item at a time_; and
    - each new item in the output sequence is a function of the _previous items_.
    - The output sequence terminates when a special "end token" is generated.

The situation is captured in this graphic: 

![transformer autoregressor]({{ site.baseurl }}/assets/images/transformer-autoregressive.svg){:width="600px"} 

The transformer's encoder receives the input sequence \\(x_1, x_2, \ldots, x_M \\) and computes a latent representation for it.
This latent representation gets passed to the decoder.

In this scenario, the transformer has already generated the first \\(t \\) items in the output sequence&mdash;\\(y_1, y_2, \ldots, y_t\\).
The decoder generates \\(y_{t+1}\\) as a function of (i) the latent representation and (ii) the first \\(t\\) items.
Finally, \\(y_{t+1} \\) is appended to the output sequence and the process repeats.
Note that the latent representation remains the same while the output items are being generated; the latent representation only needs to be computed once. 

<!--_-->

It's time to reveal some more details.
The encoder and decoder are each composed of _layers_.
For example, In AIAYN they both contain \\(K = 6\\) layers.

Here's the graphic again, updated to show the layers:

![transformer layers]({{ site.baseurl }}/assets/images/transformer-layers.svg){:width="600px"} 

The encoder's final layer produces the latent representation.
Interestingly, it passes the latent representation to _each layer of the decoder_.
This ensures that the input sequence thoroughly "informs" the generation of the next item in the output sequence.

Each layer 

<!-- Internal link
[Link to asset]({{site.url}}/assets/myfile.pdf)
-->

<!-- Include an image
![title text]({{ site.baseurl }}/assets/images/your-image.jpg){:height="200px" :width="300px"} 
-->

# Other reading

* [Attention is All You Need (Vaswani et al. 2017)](https://arxiv.org/abs/1706.03762)
* [The Illustrated Transformer (Jay Alammar)](https://jalammar.github.io/illustrated-transformer/)


\\( \blacksquare\\)  

