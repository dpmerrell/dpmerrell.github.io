---
title: Support Vector Machines 
layout: note
tags: [machine learning, optimization]
---

* Useful reading: 

    - [Ben-Hur and Weston. *A User's Guide to Support Vector Machines*.](http://pyml.sourceforge.net/doc/howto.pdf)

&nbsp; 

* TL;DR

    - Support Vector Machines (SVMs) are binary classifiers based on a simple idea:
      find a plane that divides the two classes. 
      Then, to predict the class of a test point, see which side of the plane it falls on.

    - This simple idea leads to some pretty interesting mathematics.
      
        * The dual optimization problem opens the door to kernel methods.
          This allows us to divide the classes with curved surfaces instead of flat planes.

        * The soft-margin SVM's *constrained* optimization problem is actually equivalent 
          to an *unconstrained* optimization problem with an interesting meaning.

    - This simple idea does surprisingly well in practice.

* The maximum-margin linear classifier

    - Some intuition: 
        * Given a data set \\( (x_1,y_1), \ldots, (x_N,y_N) \\) belonging to two classes, 
          find a hyperplane defined by
          \\( w \in \mathbf{R}^d, b \in \mathbf{R} \\)
          which separates the classes "as much as possible."

        * That is, for every data point \\( (x_i, y_i) \\) with \\( y_i \in \\{ + 1, - 1 \\} \\), we want
            - \\( w^\top x + b > 0 \\) if \\( y_i = +1 \\), and
            - \\( w^\top x + b < 0 \\) if \\( y_i = -1 \\).
            - In other words, we want \\( y_i ( w^\top x + b) > 0 \\hspace{14pt} \forall i \\)
          
          Furthermore, we want all of the points \\( x_i \\) to be as far away from the plane
          \\( w^\top x + b  = 0\\) as possible.

    - Formulating the optimization problem

        * Margin: a mathematical definition for "as far away from the plane as possible".

            - Let \\(x_+, x_- \\) be two points in the \\(+1, -1\\) classes, respectively.

            - The *margin* of \\(x_+ \\) and \\( x_- \\) , with respect to the plane \\( w^\top x + b  = 0\\),
              is their distance from each other, in the direction *normal* to the plane.
              This is given by
              $$ \frac{w^\top}{\|w\|}(x_+ - x_-). $$
        
        * The Support Vector Machine is defined to be the *maximum margin linear classifier*.
          That is, we want to choose $$w, b$$ such that their plane has maximal margin *for the minimal pair of points*, \\(x_+ \\) and \\( x_- \\).

        * Mathematically:

        $$w^\ast, b^\ast = \text{argmax}_{w,b} \ \text{argmin}_{x_+,x_-} \frac{w^\top}{\|w\|}(x_+ - x_-). $$

        $$ \text{s.t.} \hspace{12pt}  y_i ( w^\top x + b) \geq 1 \hspace{12pt} \forall i $$ 

    - The other side of the coin: formulating the dual optimization problem

* soft-margin support vector machines

    - The intuition

    - Formulating the optimization problem

    - The dual optimization problem

    - A different perspective: Hinge loss minimization

* Practical matters 



<!---
This is the base Jekyll theme. You can find out more info about customizing your Jekyll theme, as well as basic Jekyll usage documentation at [jekyllrb.com](http://jekyllrb.com/)

You can find the source code for the Jekyll new theme at:
{% include icon-github.html username="jekyll" %} /
[minima](https://github.com/jekyll/minima)

You can find the source code for Jekyll at
{% include icon-github.html username="jekyll" %} /
[jekyll](https://github.com/jekyll/jekyll)
-->
