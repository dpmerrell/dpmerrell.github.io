---
layout: post
title:  "Parallelism in Julia"
date:   2020-05-26 00:00:00 -0500
category: technical
tags: [julia] 
---

I'm figuring out how to parallelize some Julia code.

Julia's [parallel computing documentation](https://docs.julialang.org/en/v1/manual/parallel-computing/) is very detailed, but isn't very helpful for the uninitiated.
If you're an end user trying to use Julia for a scientific application, for example, then the official documentation may not be the best place to start.

I aim to present the topic in a way that is more sensible for the average end user, who has some background in Julia but doesn't have years of experience writing parallel code.

The main focus will be on embarrassing parallelism -- which covers a large set of practical use cases.

# Cores and Threads

Julia has capabilities for multi-core and multi-thread parallelism.
If those terms are unfamiliar, the following Wikipedia pages may help:

* [Parallel computing](https://en.wikipedia.org/wiki/Parallel_computing)
* [Multiprocessing](https://en.wikipedia.org/wiki/Multithreading_(computer_architecture))
* [Thread (computing)](https://en.wikipedia.org/wiki/Thread_(computing))
* [Multithreading (computer architecture)](https://en.wikipedia.org/wiki/Multithreading_(computer_architecture))

In short: 

* Cores are the physical processors that perform computation.
  (A physical core often hosts multiple _logical_ cores. But they're conceptually the same.)
* Threads are an abstraction used by the operating system.
  A multi-threaded program decomposes a task into subtasks -- threads -- and lets the OS assign them to cores as it sees fit.
  This divorces the _task's_ parallelism from the physical compute resources.
* In its full generality, multithreading can be more complicated than multiprocessing.
  E.g., threads may share memory whereas a core is usually confined to its own block of memory.
  We can think of multithreading as more flexible, but more difficult to do in the general case.

# Embarrassing parallelism in Julia

[Embarrassing parallelism](https://en.wikipedia.org/wiki/Parallel_computing#Fine-grained,_coarse-grained,_and_embarrassing_parallelism) is a good place to start.
It's conceptually simple, easy to do, and shows up frequently in practice.

Julia has two primary ways to write embarrassingly parallel code:

1. The [`pmap`](https://docs.julialang.org/en/v1/stdlib/Distributed/#Distributed.pmap) function;
2. The [`@threads`](https://docs.julialang.org/en/v1/base/multi-threading/#Base.Threads.@threads) macro.

Which one should you use?

* Consider `pmap` if:
    - You need to run a modest number of large, costly tasks.

* Consider `@threads` if:
    - You need to run a large number of small, inexpensive tasks.
    - You're able to set environment variables before running your code.
      Specifically, the variable `JULIA_NUM_THREADS` needs to be set:  
      `$ export JULIA_NUM_THREADS=4`

# Example `pmap`: parallelized linear regression

For an example application of parallelism via `pmap`, think of the classic normal equations solution for linear regression:

\\( \hat{w} = (X^T X)^{-1} X^T y \\)

Let's inspect some of the quantities more closely:

\\( X^T X = \sum_i x_i x_i^T \\)

\\( X^T y = \sum_i x_i \cdot y_i \\)

Both quantities are a sum over the training samples.
This suggests the following embarrassingly parallel algorithm[^1]:

1. Split the training samples into batches;
2. compute \\(X^T X\\) and \\(X^T y \\) for each batch;
3. sum the \\(X^T X\\) and \\(X^T y \\) across batches;
4. compute \\( \hat{w} = (X^T X)^{-1} X^T y \\) using the aggregate \\(X^T X\\) and \\(X^T y \\).

Notice that Step 2 is where the embarrassing parallelism sneaks in.

\\( \blacksquare\\)  

[^1]: This parallelized algorithm isn't usually practical.
      More interesting than its parallelism is 
      the fact that it can run in an _online_ fashion -- we can
      _update_ \\( \hat{w} \\) as we receive more data.
      This also allows it to run on datasets that exceed memory;
      the training set can be processed in appropriately-sized batches.

