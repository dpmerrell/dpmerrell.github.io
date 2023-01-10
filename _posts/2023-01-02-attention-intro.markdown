---
layout: post
title:  "A less-bad blog post about attention mechanisms"
date:   2023-01-02 00:00:00 -0500
category: technical 
tags: [machine-learning, deep-learning] 
---

A spectrum runs through the world of machine learning, with "curmudgeon statistician" at one end and "deep learning zealot" at the other.
I lean toward the "statistician" end of that spectrum, so I delayed learning about [attention mechanisms](https://en.wikipedia.org/wiki/Attention_(machine_learning)) until recently.

It was surprisingly difficult to find clear explanations of attention.
Most sources tended to be poorly-written Medium posts with a formulaic structure:

1. Point to the famous ["Attention Is All You Need" (AIAYN) paper](https://arxiv.org/abs/1706.03762);
2. bumble through an awkward discussion of "keys," "values," and "queries";
3. show mathematical formulas for different attention mechanisms;
4. describe the transformer architecture in too much detail;
5. show some code snippets.

Maybe that works for some people, but it didn't work for me. 
AIAYN is an important paper, but it seems like a poor way to explain attention mechanisms[^1].

With that background in mind, I've compiled my current understanding of attention mechanisms into this blog post.

This post is **not** a thorough survey of the literature on attention mechanisms.
It only aims to be less bad than other blog posts on the topic.
I hope it makes your path easier than my own.
 

# A gradual explanation of attention

We'll start with attention as _humans_ experience it.
Then we'll present a mathematical description of attention, and show how it fits into machine learning.
Finally, we'll arrive at the _keys, values,_ and _queries_ jargon of AIAYN.

### Attention in humans 

Machine learning researchers chose the word "attention" on purpose.
There is a strong analogy between attention mechanisms in ML and the human notion of attention.

With every waking moment, your brain is flooded with sensory data. 
How are you able to process it? How are you not overwhelmed?

The answer is that your brain filters out most of the data and only allows a small subset to be perceived.
At any given time, only a small amount of the sensory data is considered _relevant_ enough for perception.
When data enters your perception, we say you are "paying attention" to it.

Human attention has certain key properties that will carry over to the machine learning version:

* Attention assigns importance to items. It filters out irrelevant items and keeps relevant ones.
* You have a finite amount of attention. You can _concentrate it_ on few items, or _spread it out_ over many items. 


### Attention as weight assignment

Our explanation of human attention suggests a mathematical description.

Suppose you have some arbitrary set of items, \\(x_1, x_2, \ldots, x_N \\).
Then we can think of attention as an assignment of nonnegative _weights_ \\(p_1, p_2, \ldots, p_N \\) to those items.
We constrain the weights such that \\(\sum_i p_i = 1 \\).

If we interpret the weights \\(p_1, p_2, \ldots, p_N \\) as _importances_, then they satisfy the two properties of attention mentioned in the previous subsection. 

The weights can then inform judgments about the set of items, with heavier items being given greater importance (i.e., more attention).


### Machine learning on collections of items 

This weight assignment becomes relevant for machine learning in settings where each input is a _collection of items_.
Concretely, imagine we have a model that classifies documents.
In this case each _document_ would be regarded as a collection of _words_.

Here's a simple way our model could employ attention:

1. Represent each word with an embedding vector: \\(x_1, x_2, \ldots, x_N\\).
2. Assign a weight to each word: \\(p_1, p_2, \ldots, p_N \\).
3. Compute a _document vector_ \\(z\\) from the weighted average of word vectors: \\(z = \sum_i p_i x_i\\)
4. Let additional layers infer the class from the document vector.

This is illustrated in the following graphic:

![Simple attention model]({{ site.baseurl }}/assets/images/simple-attention.svg){:width="600px"} 

Edges indicate functional dependencies (i.e., an edge from A to B means "B is a function of A").

A practical advantage of this approach is that it naturally accommodates inputs of varying size.
In other words, the document embedding \\(z\\) does not necessarily depend on the document's length&mdash;we could append an arbitrary number of irrelevant words to the document and \\(z\\) would not change. 

At this point we should discuss _where the weights come from._
The big ML idea is to _learn_ a function \\(f\\) that computes the weights.
We call this function that assigns weights to items an _attention mechanism_ or _attention head_.
Typically \\(f\\) consists of two stages:

1. Compute a "relevance" or "compatibility" score for each word in the document;
2. use a softmax function to transform the relevance scores into nonnegative weights.

The relevance score for a word is usually a function of (1) that word's vector representation \\(x_i\\) and (2) additional contextual information about that word.
For example, contextual information could include a word's position in the document, its neighboring words, or some other vector embedding of the word. 
Some of this contextual information may be appended to the word vector \\(x_i\\), but it's also typical to store context information in a separate vector. 

For illustration, contrast this graphic with the previous one:

![attention model with context]({{ site.baseurl }}/assets/images/simple-attention-full.svg){:width="600px"} 

(Note that it does not depict the full set of edges going into the "\\(p\\)" nodes.
Since the \\(p\\) nodes come from a softmax function, each \\(p\\) node depends on every input to the softmax.)

So far we've focused on documents (collections of words) as a concrete example.
However, our discussion could just as easily apply to molecules (collections of atoms),
images (collections of pixels) or other domains.


### Queries, keys and values

Somehow this terse, jargon-ridden paragraph from AIAYN made it fashionable to describe attention in terms of _queries, keys_ and _values_:

> "An attention function can be described as mapping a query and a set of key-value pairs to an output, where the query, keys, values, and output are all vectors. The output is computed as a weighted sum of the values, where the weight assigned to each value is computed by a compatibility function of the query with the corresponding key."

Our previous discussion maps onto that jargon in a fairly straightforward way.
Once again, let's focus on the concrete example of a document model.

It's easiest to start with the queries and keys:

1. "queries" = word vectors
2. "keys" = context vectors 

This means the attention weights are primarily a function of the queries and keys. 
There are many ways to compute \\(p_1, p_2, \ldots, p_N\\) from the queries and keys: so-called "additive", "dot-product", "scaled dot-product", and so on.
I recommend [Lilian Weng's blog post](https://lilianweng.github.io/posts/2018-06-24-attention/) for coverage of those details.

Here's the figure from before, with "queries" and "keys" substituted in the appropriate places:

![keys, values, queries]({{ site.baseurl }}/assets/images/simple-attention-kvq-1.svg){:width="600px"} 

That covers queries and keys. But what about "values?" 

Values require us to introduce new nodes to our diagram&mdash;an additional node for each word.
These new nodes will provide more flexibility to the model.
Specifically, they will allow the word vectors that form \\(z\\) to _differ_ from the word vectors used to compute the attention weights (i.e., the queries).
Here's the figure again, showing the new _value_ nodes:

![keys, values, queries]({{ site.baseurl }}/assets/images/simple-attention-kvq-2.svg){:width="600px"} 

Notice that before this, we only had one word vector representing each word (the _query_).
In contrast, we now have _two_ word vectors representing each word (query _and_ value).
And we still have the keys, which represent context (roughly speaking).

At this point we've arrived at a flexible and broadly applicable class of attention mechanisms.
The queries, keys and values will often be generated by other layers of the network. 
And the output \\(z\\) may be used as a query/key/value in another attention layer!

There are many ways to incorporate these attention mechanisms into the design of a neural network.
The following sections describe a few of them.  


# Global attention

The attention mechanism described above assigns attention weights to every item in the collection, and produces a vector representing the _entire_ collection.
For that reason it's often called _global_ attention.
This is the simplest way to incorporate attention into a neural network.

Global attention is interesting from an interpretability standpoint: for each input received by the model, the attention weights will indicate which items in that input are most relevant for that layer of the model. 


# Multi-head attention

The attention mechanism described above has a fairly strong inductive bias: it assumes the output is a weighted average of item-specific vectors.
To counter this bias, an attention layer can include _multiple_ attention heads.
That is, the same set of queries/keys/values can be passed to multiple attention mechanisms \\(f_1, f_2, \ldots, f_K\\); and afterward, the outputs of these mechanisms can be recombined in some fashion.
For example, AIAYN concatenates their outputs.

Ideally, the different attention heads \\(f_1, f_2, \ldots, f_K\\) "pay attention" to \\(K\\) different aspects of the input; and their recombined output captures all of their "diverse perspectives". 
This allows the output to _not_ be a simple weighted average of values.

Multi-head attention is analogous to having multiple channels in a convolutional neural network.
Additional channels allow a CNN to learn multiple convolutional kernels that detect distinct patterns in the data.


# Self-attention (or intra-attention)

To keep things concrete, let's once again assume we're working with text data (documents of words).

The high level idea of self-attention is to allow each word in the document to "pay attention" to the other words in the document.
This allows the model to capture pairwise interactions between words.
People call this "self-attention" or "intra-attention"; I prefer the term "intra-attention" since it seems more accurate. 

Recall that global attention applies a single attention head \\(f\\) to the entire document \\(x_1, x_2, \ldots, x_N\\), producing a single vector \\(z\\).
In contrast, imagine we have an attention head _for every word in the document_.

More accurately, imagine we have a single attention head \\(f\\), but for each word \\(x_i\\) in the document we compute a new set of attention weights tailored to that word: \\( p_{i,1}, p_{i,2}, \ldots, p_{i,N} \\).
These weights encode the strength of pairwise relationships between word \\(x_i\\) and words \\(x_1, \ldots, x_N\\).
Finally, suppose we use the attention head \\(f\\) to compute \\(z_i \\); a new vector for word \\(i\\).

Here's a graphic, showing the situation for \\(i = 1\\):

![keys, values, queries]({{ site.baseurl }}/assets/images/intra-attention.svg){:width="600px"} 

If we do this for every word in the document, then we end up computing \\(N^2\\) attention weights and producing outputs \\(z_1, z_2, \ldots, z_N\\).
We can think of \\(z_1, z_2, \ldots, z_N\\) as _new_ vectors for the words in the document, updated to include information from pairwise relationships with other words in the document.

Some important things to notice:

* The complexity of intra-attention grows quadratically with the length of the document.
  This is no surprise, since it introduces pairwise interactions between words.
  There are domain-specific strategies for overcoming the \\(O(N^2)\\) complexity, like ignoring words past a certain distance in the document.
* Multiple rounds of intra-attention allow a model to capture higher-order relationships between words, rather than just pairwise relationships.
  Intra-attention can be thought of as a form of message passing, similar to that in graph convolutional networks.

It's straightforward to define a multi-head version of intra-attention.
Do the natural thing&mdash;replace the single attention head with a multi-head mechanism, just as in global attention.

# Wrapping up

I would have liked to cover transformers, but they're important enough to warrant their own post.
(Also, I already spent too much time on this post.)


# Other reading

* [Attention? Attention! (Lilian Weng 2018)](https://lilianweng.github.io/posts/2018-06-24-attention/)
* [Attention is All You Need (Vaswani et al. 2017)](https://arxiv.org/abs/1706.03762)
* [Graph Attention Networks (Velickovic et al 2017)](https://arxiv.org/abs/1710.10903)


\\( \blacksquare\\)  

[^1]: Explanations organized around AIAYN have certain weaknesses. (1) The AIAYN paper doesn't seem intended as a beginner's introduction to attention. Its dense jargon of "keys, values, and queries" is more of a shorthand meant for people who are already familiar with the subject. (2) AIAYN describes a particular application of attention to text data. Its main purpose is to present a particular neural network architecture&mdash;the transformer. (3) If you want a broader conceptual understanding of attention mechanisms, then AIAYN will not serve you very well. The blog posts I read didn't explain how attention generalizes to other data or neural network architectures. The general concept didn't really _click_ in my brain until I digested additional papers about [attention models for graph data](https://arxiv.org/abs/1710.10903).


