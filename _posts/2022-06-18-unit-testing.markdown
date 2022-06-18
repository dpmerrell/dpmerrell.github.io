---
layout: post
title:  "The Joys of Unit Testing"
date:   2022-06-18 00:00:00 -0500
category: technical 
tags: [programming, julia] 
---

# Some background 

The benefits of [unit testing](https://en.wikipedia.org/wiki/Unit_testing) are well-known to software engineers.
However, they are less well-known to researchers and scientists.

Based on my own experience, I suspect their avoidance of unit tests stems from some misconceptions:

* "Unit tests entail too much overhead in time and effort"
* "Unit tests aren't necessary because my code is simple"

These concerns may be true&mdash;unit tests only become useful if the codebase becomes sufficiently large.
However, the threshold for usefulness can be surprisingly small.
Heuristically, I'd put it at around 50 lines of code.


# Benefits of unit testing (from my experience)

I've worked in environments with a strong emphasis on unit testing&mdash;business ventures and research laboratories.

However, I've only started incorporating unit tests into my PhD research within the past year or so.
The benefits have been remarkable.
I'll list some of them here:

* Unit tests force me to think clearly about the problem my code is solving.
    - In order to write a test, I have to work out one or more simple problems by hand.
* Unit tests can encourage good software design
    - Modularity
    - Simple building blocks with well-defined behaviors
* Unit tests have greatly accelerated development for my research projects.
    - They help me catch bugs in my new features as I write them
    - They've been extremely helpful for navigating code edits
        * The helpfulness increases with the size of edit.
        * Unit tests are a programmer's best tool for reasoning through significant code refactors.

Based on my work experience, unit tests are also indispensable for collaborative development.
They provide a notion of "correctness" that developers must satisfy whenever they submit new code.
For similar reasons, unit tests help me confidently resume work on code _I_ wrote, after not touching it in months.


# Unit testing in Julia

It's very easy to write unit tests for a Julia package.
Julia comes with the [`Test` unit testing package](https://docs.julialang.org/en/v1/stdlib/Test/) pre-installed.

You can climb the learning curve for Julia unit tests in about 15 minutes.
I'll give a sketch of how it works.

Suppose you're writing a Julia package called `YourPackage`.
It has the typical directory structure:
```
YourPackage/
    Project.toml
    Manifest.toml
    src/
        YourPackage.jl
        other_file.jl
        <et cetera>
```

These are the steps to add unit tests to `YourPackage`:

1. Make a `YourPackage/test` directory:
```
YourPackage/
    Project.toml
    Manifest.toml
    src/
        YourPackage.jl
        other_file.jl
        <et cetera>
    test/
``` 
2. In the `YourPackage/test` directory, make a new `runtests.jl` file:
```
YourPackage/
    Project.toml
    Manifest.toml
    src/
        YourPackage.jl
        other_file.jl
        <et cetera>
    test/
        runtests.jl
``` 
3. Write your unit tests in the `runtests.jl` file.
   It may look like the following example:

```
using YourPackage
using Test

@testset "adder tests" begin

    @test adder(1,2) == 3
    @test adder(-5, 7) == 2

end

@testset "subtractor tests" begin

    @test subtractor(5,5) == 0
    @test subtractor(5,-1) == 6

end
```

Here we're pretending `YourPackage` exports two functions: `adder` and `subtractor`.
Notice that we must include the `using YourPackage` and `using Test` lines.
Each test uses the `@test` macro, followed by a Boolean statement.
Tests can be organized into `@testset`s, labeled for clarity (e.g., "adder tests" and "subtractor tests").

Once these elements are all in place, you can run your tests from the Julia command prompt.
1. Press `]` to enter `Pkg` mode
2. Run the `test` command:

```txt
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.6.2 (2021-07-14)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

(YourPackage) pkg> test
```

Julia will execute `runtests.jl` as a script, and report the results of each `@testset` it encounters.


\\( \blacksquare\\)  

