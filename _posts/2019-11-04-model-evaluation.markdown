---
layout: post
title: Avoiding common pitfalls in machine learning model validation
date:   2019-11-04 00:00:00 -0500
category: technical 
tags: [cross validation, validation, training set, test set, iid, accuracy] 
---

# Introduction[^1] 

I'm writing this post because I see people use incorrect
machine learning methodology far too often&mdash;this includes inappropriate 
or naive uses of cross-validation; train/test leakages during preprocessing; and so on. 

Machine learning packages like scikit-learn make it really easy to get started in ML, 
but they also make it really easy to fool yourself into a false sense of confidence.

This post answers the following question:

> My model got excellent test-set performance... why did it do so poorly in deployment?

[^1]: In this post, we restrict our discussion to supervised learning tasks. The notion of _simulating real-world deployment_ holds for other tasks (e.g., active or reinforcement learning), but all detailed discussion pertains to supervised learning. Furthermore, we restrict ourselves to batch-wise learning tasks&mdash;online learning presents other subtleties for validation.

<!---
<br> 

<center>
<img src="{{ site.baseurl }}/assets/images/king-of-hill-sklearn-meme.png" alt="sklearn king of hill"  width="320" height="420">
</center>

<br>
-->

# Model Validation: Simulating Real-World Deployment
* **The purpose of model validation is to accurately estimate a model's real-world performance, _before actually deploying it_.**
    * Our model may be involved in important decisions. Is it _trustworthy_?
    * We don't want to get excellent test-set performance, only to be _surprised_ when our model gets deployed and performs terribly in the real world.
    * In deployment, we won't generally know the ground-truth for new inputs.
    So it's not usually easy to measure the model's performance _after_ deployment, anyway.
* **It's useful to think of model validation techniques as _simulations of real-world deployment._**
    - The standard train/test split is just one special case of this idea.
        * In deployment, the model will be trained on a limited set of available data. 
            - (In validation, this is simulated by the training set.)
        * the model is then used to make predictions on inputs _it has never seen before_.
            - (In validation, this is simulated by predicting on the test set.)
        * We want to know how well the model will perform on these previously unseen inputs.
            - (In validation, we compare the test set predictions to their true labels, and compute some score that usefully characterizes the model's performance. Accuracy, F1, RMSE, etc.)
    - Cross-validation yields a similar estimate of performance, but with reduced variance.

<br>

# Some Common Pitfalls

* **In many situations, simple train/test splits and cross-validation will yield misleading estimates.**
    - A naive train/test split implicitly assumes that our data consists of iid samples.
    - If our data violates this iid assumption, then the test-set performance will mislead us&mdash;and usually cause us to _overestimate_ our model's real-world performance.
    - This can lead to bad consequences: at the very least, it makes _you_ (the data scientist) seem untrustworthy or incompetent.

* **Careless preprocessing can introduce train/test leakages.**
    - For example: if you standardize your training set and test set _together_, then the \\(\mu\\)s and \\(\sigma\\)s you compute will be _a function of the test set_.
    - This means that your model has, effectively, gotten a sneak-peek at the test set.
    - I.e, your model validation technique is cheating (even if you didn't mean to).
    - In some cases, the effect may be small. But don't count on it!

<br> 

# How to Avoid these Pitfalls

* **Thinking carefully about deployment can help us design sound validation techniques, and avoid fooling ourselves.** 
    * In deployment, what information will be available to the model during training?
        - Your validation technique _must_ correctly simulate this availability&mdash;the validation technique must _not_ touch any other information until test-time.
    * When the deployed model receives new data, how will that data be structured?
        - Individual, iid samples?:
            * This is the simplest case, and is almost always assumed in introductory treatments of machine learning.
                - You may be surprised by how uncommmon it is in practice, though.
            * Under this circumstance, straightforward splits and cross-validation will suffice.
        - A batch of _related_ samples? e.g.:
            * measurements from the same plate in a lab experiment;
            * the set of all transactions for an individual customer
        - The next item in a sequence? e.g.:
            * the next price for a stock; 
            * the next word of text; the next frame of video)

<br>

# Some Practical Recommendations

* Ensure your preprocessing is sound by using **pipelines**.
    - [Scikit-learn's Pipeline implementation is a wonderful concept.](https://scikit-learn.org/stable/modules/generated/sklearn.pipeline.Pipeline.html)
    - A pipeline bundles your preprocessing steps (e.g., standardizing, dimension reduction) together with your model. The result is a single object which can be trained and tested with the same interface as a model.

* If your data is, in fact, iid, then go ahead and use ordinary splits or cross-validation. Scikit-learn implementations:
    - [Stratified K-fold cross-validator](https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.StratifiedKFold.html#sklearn.model_selection.StratifiedKFold)
    - [Stratified shuffle/split](https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.StratifiedShuffleSplit.html#sklearn.model_selection.StratifiedShuffleSplit)
    - Note: stratified techniques yield a more accurate performance estimate without cheating&mdash;be sure to use them when possible!

* When your data can be naturally grouped into related samples (i.e., the iid assumption is violated), then be sure to use **_grouped_ splits/_grouped_ cross-validation**.
    - Of course, [scikit-learn has a great implementation.](https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.GroupKFold.html)
    - The basic idea is that each sample from the same group must be on the same side of each split.  In other words: you should not train _and_ test using samples from the same group.
    - Note: as far as I'm aware, scikit-learn doesn't have a _stratified_ group k-fold cross validator. It might be a good issue to raise...
* When your data has a sequential structure, then you ought to use a cross-validator specially suited for that situation.
    - [Scikit-learn has a **time-series split** implementation.](https://scikit-learn.org/stable/modules/cross_validation.html#timeseries-cv)
* A large swath of practical situations are covered by these techniques.
    - For other situations: just think through the questions listed previously.
    We'll repeat them here for emphasis:
        * In deployment, what information will be available to the model during training?
        * When the deployed model receives new data, how will that data be structured?

<br>

## Additional reading
- [Scikit-learn's cross-validation user guide](https://scikit-learn.org/stable/modules/cross_validation.html)
- Some blog posts about time-series cross-validation
    * [A post by Courtney Cochrane](https://towardsdatascience.com/time-series-nested-cross-validation-76adba623eb9)
    * [A post by Rob Hyndman](https://robjhyndman.com/hyndsight/tscv/)

<br>

