---
layout: post
title:  "Solving a Family of Recurrences with the Repertoire Method"
category: Math
tags: [Concrete Math, recurrence] 
---

## Background

In order to sweep some cobwebs out of my brain, I've been
reading through the classic *Concrete Mathematics; A 
Foundation for Computer Science* (Graham, Knuth, Patashnik).
It covers some of the mathematical ideas that underpin
computer science; e.g. recurrences, number theory, discrete
probability, and computational complexity. Donald Knuth is also
well known as the author of *The Art of Computer Programming* 
book series.

*Concrete Mathematics* tends to explain things in a fun and informal 
way, but sometimes that works to its disadvantage. An example of this
is in its first chapter, when the authors sort of slap together an 
illustration of the Repertoire Method for solving recurrences. A
margin note correctly warns,

> Beware: The authors are expecting us to figure out the repertoire
method from seat-of-the-pants examples, instead of giving us a top-down
presentation.

In this post, I try to provide a "top-down presentation" of the 
repertoire method.

## A Family of Recurrences

Suppose you have a recurrence relation for the function \\(f(n)\\)
that looks like this:

\\begin{align}
f(1) & = \Omega & \\\
f(g\_{1}(n)) & = h\_{1}(f(n)), & n\ge 1; \\\
f(g\_{2}(n)) & = h\_{2}(f(n)), & n\ge 1; \\\
 & \vdots & \\\
f(g\_{m}(n)) & = h\_{m}(f(n)), & n\ge 1; \\\
\\end{align}

where the \\(g\_{k}\\) must satisfy certain 
conditions[^1] and the \\(h\_k\\) must satisfy
other conditions[^2]. 
The main idea is that for any index \\(n \ge 1\\), 
you can uniquely express \\(f\\) of it in terms of \\(f\\) of a 
smaller index, allowing you to start with any \\(n\\) and work 
your way down to \\(n=1\\), keeping track of the \\(h\_k\\)s along
the way so that you can compute \\(f(n)\\) once you get there.

We say that we've "solved" a recurrence if we find a closed-form
mathematical expression for the function \\(f(n)\\). Informally,
you can think of a closed-form expression  as something you might 
punch into a calculator.

As it currently stands, this recurrence does not have any free parameters.
If we solve it, we solve exactly one recurrence and therefore get
limited insight. It would be nice if we could generalize this
recurrence into a family of recurrences, and then solve the entire
generalized family at once.

One way to generalize our recurrence---the only way we'll be considering---
is to permit free parameters in the \\(h\_k\\)s, such that our recurrence
looks like this:

\\begin{align}
f(1) & = \Omega & \\\
f(g\_{1}(n)) & = h\_{1}(\alpha\_{1}, f(n)), & n\ge 1; \\\
f(g\_{2}(n)) & = h\_{2}(\alpha\_{2}, f(n)), & n\ge 1; \\\
 & \vdots & \\\
f(g\_{m}(n)) & = h\_{m}(\alpha\_{m}, f(n)), & n\ge 1; \\\
\\end{align}


## Guessing a Solution

Let's suppose you're looking at a recurrence, and you suspect its
solution looks something like this:

$$ f(n) = L \left(\underline{\theta},n \right) = \alpha A(n) + \beta B(n) + \gamma C(n) $$.

where \\(\underline{\theta}\\) is a vector of \\(q\\) parameters whose values 
are unknown. Assuming that the solution can be expressed in the proposed form,
solving the recurrence becomes a matter of solving for the parameters
\\(\underline{\theta}\\). Hence, we would need to generate a system of \\(q\\)
equations.

## A "Repertoire" of Special Cases

where \\(\alpha, \beta, \gamma\\) are constants and
\\(A, B, C\\) are closed-form functions of \\(n\\).

[^1]: The \\(g\_{k}\\)s' codomains must partition \\( \\mathbb{N} \\). This ensures that for any \\(m\\), there is exactly one \\(n\\) and exactly one \\(g\_k\\) such that \\(m = g\_{k}(n)\\). Otherwise, you might ask "What's \\(f(j)\\)?", look at your recurrence, and find that you can't fit \\(j\\) into it! Furthermore, the \\(g\_k\\)s must "point" the natural numbers to each other in a way that doesn't create endless loops and gives each number exactly one "path" back to \\(n=1\\). This turns out to be a tree with its root at \\(1\\).
[^2]: Think of it this way. As you traverse the tree (see footnote 1) from an arbitrary \\(n\\) all the way down to \\(1\\), the \\(g\_k\\)s tell you where you're going next, and the \\(h\_k\\)s compose a sequence of composed computations to complete once you get to the end. That composition of computations can only happen if the \\(h\_k\\)s' ranges and domains fit together right, which is definitely the case if the ranges and domains are equal (the most common scenario). 
