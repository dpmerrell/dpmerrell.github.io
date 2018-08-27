---
title: Information Theory in Machine Learning 
layout: note
tags: [machine learning, optimization]
---

### Overview

Quantities of the form

$$ \mathbf{E} \big[ - \log p(x) \big] $$

have a concrete and interesting meaning.

Such quantities are used in probability, statistics, and machine learning to describe the randomness of random variables, and relationships *between* random variables.
They're typically called **entropies**.

Historically, entropies had their beginning in statistical physics.
However, their broader usefulness became apparent in the mid 20th century with the dawn of information theory.

This document begins by describing how entropies arise in information theory.
It then gives examples of how they are used in statistics and machine learning.

### Communicating with Discrete Signals

A discrete signal is just a sequence of symbols belonging to some alphabet. 
You're reading a discrete signal right now; its symbols belong to the English alphabet. 

Suppose we have a discrete signal in one place and we want to communicate it somewhere else.
For example suppose I have a message, written in English, which I would like to send to you.
There are many ways I might convey the signal to you; some are smarter than others.

A very smart and modern way would be to 

* have my computer translate the signal into binary,

* send the binary code over the internet, and 

* let your computer translate the signal back to English on your screen.

This little story suggests the important role of *translation* in communication.
It turns out translation is everywhere. It's very physical. Some examples:

* sentence \\(x\\) in my brain &rarr; movement of my vocal chords &rarr; vibrations in the air &rarr; movement in your inner ear &rarr; sentence \\(x\\) in your brain. 


### Encoding

*Encoding* is just a fancy word for translation.
It's a useful word, though, because it's partnered with the word *de*coding. 
Hence, our goal is to 

* *encode* my signal in a way that allows transportation 

* send the encoded signal

* *decode* the signal at your end, allowing you to reproduce the original signal.

A common way to approach encoding is to make a "dictionary" that maps symbols in one alphabet to sequences of symbols in another.
Such a dictionary is called a *code book*, and entries in the dictionary are called *code words*.

Let's make a codebook that maps from symbols in the alphabet to bit-sequences.
A reasonable first approach would assign equal-length bit sequences to each symbol of our alphabet.
For example, I could map each letter of the alphabet to an 8-bit sequence. 

* "A" &rarr; 0000001

* "B" &rarr; 0000010

* "C" &rarr; 0000011

* etc.

This works fine. If you have the same codebook at your end, you'll be able to decode my message. 

However, it turns out that we can be more clever than this.
We can make codebooks that are more *efficient*.

### The Cost of Communication

Suppose I have a *really* big message that I want to send. 
In that case, it might pay dividends to try making my message as small as possible.

One way to do that is to account for the *frequencies* of different symbols in my alphabet.

$$ \sum_{x \ \in \ \text{codebook}} p(x) \cdot \big[ \text{bits for codeword } x \big] $$

$$ \textbf{E}_{x \sim p} \big[ \text{bits for codeword } x  \big] $$

### The Least Expensive Encoding

A fundamental result of information theory: the optimal allocation of bits to symbols is given by 

$$ - \log p(x) $$ 

## The Entropy of a Random Variable

### The Smallest Number of Bits per Codeword

$$ \mathbf{E}_{x \sim p} \big[ - \log p(x) \big] $$ 

### The "Randomness" of a Random Variable

It turns out that entropy can serve as a measure of "randomness".

The entropy of a random variable is greatest if each of its possible values has an equal probability.

Concretely, a uniformly random discrete variable has maximal entropy; 
random variable with only one possible outcome (i.e., a number) has **zero** entropy.

## Entropic Quantities Involving Multiple Signals

### Cross Entropy

The average bits per codeword when we use an *incorrect* encoding.

$$ \mathbf{E}_{x \sim p} \big[ - \log q(x) \big] $$ 

This is the average bits per codeword we'd get if we made a codebook for a \\(q\\) signal, when the signal is actually distributed like \\(p\\).

### KL Divergence

$$ D_{KL}(q \| p) = \mathbf{E}_{x \sim p} \big[ \log \frac{p(x)}{q(x)} \big] $$

$$  = \mathbf{E}_{x\sim p} \big[ - \log q(x) \big] - \mathbf{E}_{x\sim p} \big[ - \log p(x) \big]$$

$$ \hspace{0.25in} = (\text{Cross entropy between q and p}) - (\text{Entropy of p})$$

### Mutual Information

The KL-Divergence from marginals to joint. 

The *inefficiency* of assuming independence between random variables.

$$  = \mathbf{E}_{(x,y) \sim p} \big[ - \log p(x)\cdot p(y) \big] - \mathbf{E}_{(x,y) \sim p} \big[ - \log p(x,y) \big]$$

$$ \hspace{0.25in} = (\text{Cross entropy between marginals and joint}) - (\text{Entropy of joint})$$

### Fisher Information

The Hessian of the KL Divergence

<!---
This is the base Jekyll theme. You can find out more info about customizing your Jekyll theme, as well as basic Jekyll usage documentation at [jekyllrb.com](http://jekyllrb.com/)

You can find the source code for the Jekyll new theme at:
{% include icon-github.html username="jekyll" %} /
[minima](https://github.com/jekyll/minima)

You can find the source code for Jekyll at
{% include icon-github.html username="jekyll" %} /
[jekyll](https://github.com/jekyll/jekyll)
-->
