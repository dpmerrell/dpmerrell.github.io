---
layout: post
title:  "Making Python packages: some useful resources"
date:   2020-05-24 00:00:00 -0500
category: technical
tags: [python] 
---

Somehow I've spent years using Python without ever packaging my code.
I haven't had the need or occasion to do so.

I decided to take some time and learn about it. 
Here are some useful resources I've stumbled across.
They're listed in order of clarity:

* [The Hitchhiker's Guide to Packaging](https://the-hitchhikers-guide-to-packaging.readthedocs.io/en/latest/quickstart.html)
* [setup.py (for humans)](https://github.com/navdeep-G/setup.py)
* [Python Packaging User Guide](https://packaging.python.org/tutorials/packaging-projects/)
* [`setuptools` Documentation](https://setuptools.readthedocs.io/en/latest/setuptools.html)

A recipe based on my initial understanding:

1. Make sure your code is organized into a package (a hierarchy of directories, each containing an `__init__.py` file).
2. Put a `setup.py` file in the root directory.
   This is the most complex part.
    * `setup.py` is a script that essentially runs a single command: `setup`.
    * The `setup` command is only complicated in that it accepts a _lot_ of arguments.
      A beginner has difficulty knowing which arguments exist, and which are important.
    * See the [example `setup.py`](https://github.com/navdeep-G/setup.py) to get a full sense of the things that might happen in it.
      But notice that all of the busy-ness toward the beginning exists only to provide arguments to the `setup` command later on.
4. Generate distribution archives. 
   A distribution archive is a compressed version of all the code in the package.
   Commands like `pip` can install packages when they're in this form.
5. Register/upload the package to PyPI.
   This allows _anyone_ to install your package via `pip`!

I've encountered `setup.py` files before, without really understanding why they exist.
According to [the setup.py for humans repo](https://github.com/navdeep-G/setup.py),
Guido van Rossum himself complains about the general lack of understanding regarding `setup.py` files: "everyone [cargo cults](https://en.wikipedia.org/wiki/Cargo_cult) them."

Writing this was mostly useful for me. 
If it was useful for you, then I'll count it as a bonus :)

\\( \blacksquare\\)  


