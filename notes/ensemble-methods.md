---
title: Ensemble Methods 
layout: note
tags: [machine learning, optimization]
---

* Useful reading: 

    - [Dietterich. *Machine Learning Research: Four Current Directions*. 1997.](http://aass.oru.se/~tdt/ml/extra-readings/dietterich-aimag-survey.pdf)

      (Yes, it is ironic that I reference a paper from 1997 which has "Current Directions" in its title.
       It actually gives a really helpful overview of ensemble methods, though).

    - [Random Forest Wikipedia article](https://en.wikipedia.org/wiki/Random_forest)

      (One important topic not covered in the "Current Directions" paper)

&nbsp; 

* TL;DR

    - Under some common circumstances, a group ("ensemble") of fairly good models
      will outperform one smarter model.

    - Sufficient conditions for this "group effect" to happen:
    
        * The members of the ensemble are sufficiently *diverse*---they make mistakes in an uncorrelated fashion.

        * Each member of the ensemble meets some *minimal threshold of performance* on its own.


<!---
This is the base Jekyll theme. You can find out more info about customizing your Jekyll theme, as well as basic Jekyll usage documentation at [jekyllrb.com](http://jekyllrb.com/)

You can find the source code for the Jekyll new theme at:
{% include icon-github.html username="jekyll" %} /
[minima](https://github.com/jekyll/minima)

You can find the source code for Jekyll at
{% include icon-github.html username="jekyll" %} /
[jekyll](https://github.com/jekyll/jekyll)
-->
