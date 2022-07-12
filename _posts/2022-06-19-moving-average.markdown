---
layout: post
title:  "Are Moving Averages Bayesian?"
date:   2022-06-19 00:00:00 -0500
category: technical 
tags: [bayesian, bayesian-statistics, probability, time-series] 
---

[Moving averages](https://en.wikipedia.org/wiki/Moving_average) are among the most commonly-used tools for "de-noising" time series data.

People usually describe a moving average as a convolutional filter.
This opens the door to many mathematical insights.
For example, [the convolution theorem](https://en.wikipedia.org/wiki/Convolution_theorem) connects convolution in time with point-wise multiplication in Fourier space.

However, I've always suspected moving averages have a Bayesian interpretation. 
The [Wikipedia page](https://en.wikipedia.org/wiki/Moving_average) doesn't mention any such interpretation,
but some whiteboard math has brought me to a few conclusions:

* Given certain normality assumptions, there _is_ a moving average consistent with a probabilistic interpretation:

$$ w_j = \frac{1}{|i-j|\cdot\sigma^2 + \xi^2}. $$

(The meaning of this expression will be explained later.)

* This particular moving average has some unattractive properties, and isn't commonly used (though it could be modified to be more practical).
* Most moving averages simply aren't Bayesian.
  Moving averages have the advantage of being simple and computationally inexpensive.
  But there are more principled, probabilistic strategies for de-noising data.
  


# De-noising as Bayesian inference

When we de-noise data, we make some generative assumptions about the data:

* We assume there is an underlying _signal_ that we wish to know.
* We also assume the existence of _noise_ that corrupts our measurements of the signal.
  The data we observe is a combination of this signal and noise.

A [Hidden Markov Model (HMM)](https://en.wikipedia.org/wiki/Hidden_Markov_model) is perhaps the simplest probabilistic model for noisy time series data. 

Specifically, an HMM assumes the observed data ( \\(x_1, x_2, \ldots \\) ) are _noisy observations_ of a hidden state that evolves over time, (\\(h_1, h_2, \ldots \\) ).

We can depict the situation with a Bayesian network:

![hidden markov model]({{ site.baseurl }}/assets/images/hmm.svg){:width="500px"}


Let's assume Gaussian conditional probabilities:

$$ h_i ~|~ h_{i-1} \sim \mathcal{N}(h_{i-1}, \sigma^2) $$

$$ x_i ~|~ h_i \sim \mathcal{N}(h_i, \xi^2) $$

This is consistent with a discrete, noisily-observed Wiener process.
You could reasonably model e.g., sensor measurements or log-stock prices this way.

We can frame the "de-noising" task as a Bayesian posterior inference.
Specifically, we want to use the _observed data_ to gain knowledge about each _hidden state_ \\(h_i\\).
This consists of the marginal posterior for \\(h_i\\):

$$P(h_i ~|~ \ldots, x_{i-1}, x_i, x_{i+1}, \ldots) \propto P(\ldots, x_{i-1}, x_i, x_{i+1},\ldots ~|~ h_i) \cdot P(h_i)$$

For the remainder of this post, we will focus on finding a maximum likelihood estimate (MLE) for \\(h_i\\).
That is, we discard the prior \\(P(h_i)\\) and find the maximum of \\(P(\ldots, x_{i-1}, x_i, x_{i+1},\ldots ~|~ h_i)\\).

# Connecting HMMs to moving averages

Given our probabilistic assumptions, we end up with the following log-likelihood for \\(h_i\\):

$$ \mathcal{L}(h_i) = \sum_j \frac{(h_i - x_j)^2}{2(|i-j|\cdot \sigma^2 + \xi^2)} $$

Differentiating with respect to \\(h_i\\) yields the following optimality condition:

$$ \frac{\partial \mathcal{L}}{\partial h_i} = \sum_j \frac{(h_i - x_j)}{|i-j|\cdot \sigma^2 + \xi^2}  = 0$$

Now define 

$$ w_j = \frac{1}{|i-j|\cdot\sigma^2 + \xi^2}. $$

Rearranging the terms of the optimality condition yields the following MLE:

$$ h_i^\ast = \frac{\sum_j w_j x_j }{ \sum_j w_j} $$

Which is exactly a moving average for \\(h_i\\).

This moving average has some puzzling (though interesting) properties:

* The moving average uses an unusual "window" proportional to the inverse of \\(|i-j|\\).
  I haven't seen such a window discussed in popular references on moving averages.
* If we had infinite data, the sums used to compute \\(h_i^\ast\\) would not converge.
  This is surprising and unsatisfying.
  This probably isn't an issue in practical settings&mdash;the sums grow logarithmically and we always have finite data.
* I haven't figured out a way to maximize likelihood for the parameters \\(\sigma^2\\) or \\(\xi^2\\) yet.

It's possible that a truncated version of this moving average could be practical.
However, it lacks some of the computational efficiency possessed by e.g., rectangular or exponential weighted averages.

# Last remarks

It's interesting to find a connection between moving averages and HMMs.
However, it's a surprisingly weak connection.
The weights we derived above are not used in practice, and the weights that _are_ used in practice do not admit a probabilistic interpretation. 

I'd go so far as to claim _moving averages aren't really Bayesian_.

If somebody wants to denoise data in a probabilistically principled way, then they ought to consider more sophisticated tools consistent with HMMs:

* The [forward-backward algorithm](https://en.wikipedia.org/wiki/Forward%E2%80%93backward_algorithm) can efficiently maximize posterior marginals (which is analogous to the goal of a moving average).
* The [Viterbi algorithm](https://en.wikipedia.org/wiki/Viterbi_algorithm) can compute the single most likely _hidden history_&mdash;the entire sequence of hidden states (\\(h_1, h_2, \ldots\\) ).
* In some settings a [Kalman filter](https://en.wikipedia.org/wiki/Kalman_filter) may also be appropriate, though it is considerably more complicated than other techniques we've mentioned.


\\( \blacksquare\\)  

