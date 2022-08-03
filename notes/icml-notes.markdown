---
title: "ICML 2022 Notes" 
layout: note
tags: [conference, machine-learning]
---

# Tuesday

## Opening remarks (Tuesday 2022-07-19)

* 6,661 attendees (more than ICML 2019)
* 37% are students
* Awards:
    - Test of time award: 
        * Committee: Arindam Banerjee, Max welling, Ricardo Silva
    - Outstanding paper awards
        * Committee: USC, U Tokyo, Amazon, Tel Aviv U., Facebook, etc.
        

## Invited talk: Weinan E (AM Tuesday 2022-07-19)

* "Towards a Mathematical Theory of Machine Learning"
    - [Strange name... seems like we have an abundance of theories for ML]
        * [statistical learning theory]
    - "An admittedly biased review of the current status of the theory of ML"
    - "Machine learning is about solving some **standard** mathematical problems, but typically in very high dimensions"
        * Supervised learning: approx. a target function (using finite samples)
        * Unsupervised learning: approx. the underlying probability distribution (using finite samples)
        * Reinforcement learning: Solving the Bellman equations for a(n unknown) MDP
    - These are all classic problems in mathematics. The main practical difference encountered in ML is _dimensionality_.
        * e.g., for images: 32 x 32 x 3 dimensions for each image
    - Classical approaches for these things
        * Classical approximation theory
            - polynomial approximation
            - does not scale well at all with dimensionality
        * In contrast, deep nets seem to scale quite well to high dimensions
    - In ML we usually set out to minimize testing error (i.e., "generalization error")
        * Three main components of error: 
            - approximation error: from choice of hypothesis space 
            - estimation error: from finite dataset
            - optimization error: error introduced by training process
            - [strange that he doesn't include the Bayes-optimal error resulting from stochasticity in the domain]
    - Getting around dimensionality
        * illustrative example: monte carlo integration's convergence rate does not depend on dimensionality
        * What about function approximation?
            - Certain kinds of functions can be approximated by two-layer neural networks, with a convergence rate independent of dimensionality
        * Approximation theory for "random feature model"
            - Question: what spaces of functions are "well approximated" by the random feature model?
            - In classical approximation theory, these are the Sobolev and Besov spaces.
            - Define _k(x, x')_, the kernel function associated with the random feature model
                * this induces a reproducing kernel hilbert space
            - There are theorems in this setting:
                * direct approximation:
                * inverse approximation
                * roughly speaking: functions that are well-approximated by the random feature model are functions which admit a particular integral form
        * What class of functions are well-approximated by two-layer neural networks?
        * Barron space: Given a function f, define the Barron norm
            - Interestingly, distance to a curved space is never a Barron norm; distance to origin is a Barron norm
        * Conclusion: roughly speaking, functions that are well approximated by two-ayer nns are functions that admit an integral form (using the Barron norm)
        * Can we extend this to residual networks?
        * He's tried extending it to deeper networks, but results are not satisfactory
            - need a natural way of representing "continuous" multi-layer nns as expectations over probability distributions on the parameters 
    - Another issue: we minimize training error, but we _want_ to minimize testing error.
        * This is encountered classically in e.g., polynomial interpolation
        * "generalization gap": want this to be small
            - We can bound the generalization gap using Rademacher complexity
            - Rademacher complexity: measures its ability to fit random noise on a set of data points.
            - Bad news: this analysis shows sample complexity increases exponentially with dimensionality
            - Good news: for Barron functions, not only do good two-layer NN approximations exist, but they can be found using only a finite training dataset (i.e., acheives "monte carlo error rate")
        * A priori vs. A posteriori estimates
    - Can we find good solutions efficiently using gradient descent?
        * We're dealing with non-convex functions in high dimensions
        * Can it converge fast?
        * Does the solution generalize well?
        * It turns out the convergence rate for gradient-based training algorithms must suffer from curse of dimensionality
        * Unfortunately, this applies to the Barron space of functions
            - I.e., Barron space is the right space for approximation, but is "too big" for training
            - The "right" function space must be bigger than RKHS, but smaller than Barron space
        * In the "highly overparameterized" regime, we have time scale separation
            - Sometimes called the "neural tangent kernel regime"
            - Good news: exponential convergence
            - Bad news: converged solution is no better than that of a random feature model. This is an effectively linear regime.
        * "Mean field formulation"
            - turns out this is equivalent to "Wasserstein metric flow"
            - [I've totally lost the plot at this point]
        * Convergence of gradient flow
    - In the over-parameterized regime, which global minimum gets selected?
        * Generically, the set of global minimizers of the empirical risk forms a submanifold of dimension m - n (Jaim Cooper 2018)
        * This suggests GD solutions can be dynamically unstable for SGD
            - Quantifying this phenomenon: linear stability
                * linearizing GD
                * Stability condition: eigenvalues of the Hessian
            - In practice, GD often settles at the edge of stability    
            - Linear stability analysis for SGD
                * Stability condition
                * Compared with GD, SGD perfers more uniform solutions
                * Non-uniformity is nearly proportional to sharpness
                * SGD favors flatter minima
                    - Flatter solutions generalize better!
        * Exploring the global minima manifold
            - For over-parameterized miodels, global minima form a manifold
            - SGD "bounces around" the manifold
            - Hypothesis: SGD moves toward "flatter" part of manifold
        * Effective dynamics close to minima manifold
    * Unsupervised learning: Approximating prob. distributions
        - The memorization phenomenon
        - Can early stopping help us generalize?
        - The curse of memory in approximation by RNNs
    * Reinforcement learning: existing work focuses on the classical case where state and action spaces are finite (and small)
        - Diffuiculty: reinforcement learning involves all of the aspects we've discussed so far
    * The central theme is about understanding high-dimensional functions
        - A reasonable mathematical picture is taking shape


## Session: Generative deep learning and autoencoders

All were 5-minute "spotlight" talks, except the molecule generation talk (which was ~20 minutes)

* "hubness" priors
    - Yuanban Liang
    - GANs
    - "hubness" phenomenon
* ButterflyFlow
    - Chenlin Meng
    - Normalizing flows -- use invertible layers (with Jacobians, etc. to propagate distributions)
    - New layer: Butterfly layer
        * special family of linear layers that can be represented as a product of "butterfly factors"
        * butterfly factor: banded- or block- diagonal matrix
    - ButterflyFlowNet
    - Evaluations: images (MNIST, CIFAR) and EHR data.
    - Appears to do well on data that exhibit periodicity
* Controlling conditional language models without catastrophic forgetting
    - Tomasz Korbak
    - How to take a pretrained general purpose model (i.e., "foundation" model) and tune it without causing "catastrophic forgetting" (i.e., causing it to lose some of its general capabilities)
    - CDPG: Conditional Distributional Policy Gradients
* GLIDE
    - Alexander Nichol (OpenAI)
    - Text-to-image model
    - "text-guided diffusion model"
    - Diffusion model:
        * Start with noise, iteratively update it until it forms a clear picture
        * train by (a) starting with a noiseless image (b) iteratively corrupting it (c) training a model to remove the noise
    - Guidance
        * they tried two kinds: CLIP and classifier-free
    - Evaluation: human preference
* Structure-preserving GANs
   - Wei Zhu (UMass Amherst)
   - How to include certain structures (group symmetries, etc.) in GANs?
       * GAN is "probability distance" minimization
       * GAN with embedded structure: how to incorporate desired structure into the two players?
           - Use a "smarter" generator with the structure embedded in it
           - Use "smarter" discriminator
* "DeepSpeed-MoE" Mixture of Experts inference and training
    - Currently, ML is limited by compute
    - Can we acheive next-gen model quality on current-gen hardware?
    - mixture of experts is a promising path
        * NLG model training with MoE
        * 5x cheaper to train
        * uses 8x as many parameters :(
    - PR-MoE is more parameter-efficient
        * brings it down to 4x parameters
    - Designing highly scalable MoE inference system
    - https://www.deepspeed.ai/
* Estimating the optimal covariance with imperfect mean in diffusion probabilistic models
    - https://github.com/baofff/Extended-Analytic-DPM
* Equivariant diffusion for molecule generation in 3D
    - https://arxiv.org/abs/2203.17003
    - Victor Garcia Satorras, Max Welling, Emiel Hoogeboom
    - Generating molecules for drug discovery, catalyst discovery, material discovery, & solving docking problems
    - Denoising diffusion models
        * define a diffusion process that "destroys" signal towards a standard normal
        * train a denoising model that is the "inverse" of the diffusion process
    - Equivariance
        * Functions should be invariant (or change predictably) under certain transformations: rotations, translations, reflections
        * Distributions should also have these properties
    - Related works
        * Geodiff: equivariant diffusion to generate positional data of molecules
        * E-NF: an equivariant normalizing flow to generate molecules
    - EDMs: Equivariant diffusion models
        * Adds Gaussian noise over time steps
        * Choose tthe denoising model s.t. it has the same form as the _true_ denoising process
    - Optimizing:
        * Sample a molecule from the dataset
        * Add some noise 
            - Atom type is confused _earlier_ in the diffusion process; hence, modeled _later_ in the denoising process
    - Encoding
        * Atom type: one hot
    - Number of atoms is simply sampled from a distribution derived from data
    - Evaluation
    - Interestingly, bond types are not modeled directly. They're inferred from distances between atoms
* Forward operator estimation in generative models with kernel transfer operators
    - Zhichun Wang, Vikas Singh
    - https://proceedings.mlr.press/v162/huang22b/huang22b.pdf
    - Forward operator
        * Map from a simple distribution (e.g., normal distribution) to the unknown data distribution
        * Often estimated by e.g. neural networks (in GANs or VAEs)
    - This work uses simpler and more-efficient kernel techniques to estimate forward operators.
* Conditional GANs with auxiliary discriminative classifier
* Improved StyleGAN-v2 based inversion for OOD images
    - GAN inversion: ill-posed problem of mapping image to latent representation (?)
    - used for image restoration
    - Their work improves on this s.t. OOD images are accurately inverted
* Matching normalizing flows and probability paths on manifolds
    - Continuous normalizing flow: generative models that transform a prior distribution to a model distribution by solving an ODE
    - They're primarily interested in generating samples on manifolds
    - They train CNFs by minimizing "Probability Path Divergence" 
        * PPD is related to/inspired by conservation of mass
    - https://proceedings.mlr.press/v162/ben-hamu22a/ben-hamu22a.pdf
* Marginal distribution adaptation for discrete sets via module-oriented divergence minimization
    - [WTF is this title ????]
* Learning to incorporate texture saliency adaptive attention to image cartoonization
* Another GAN highlight


## Session: Gaussian Processes

* Probabilistic ODE solutions in millions of dimensions
    - Solve ~10M-dimensional ODEs via probabilistic solver
    - https://proceedings.mlr.press/v162/kramer22b.html
    - There is a correspondence between solving ODEs and inferring posteriors for Gaussian processes
* Adaptive Gaussian process change point detection
    - Find points at which the covariance function/covariance matrix changes
    - https://proceedings.mlr.press/v162/caldarelli22a.html
* Volatility based kernels and moving average means for forecasting with Gaussian processes
    - 
* Fenrir: physics-enhanced regression for initial value problems
    - another work that shows/uses a correspondence between solving ODEs and posterior inference on Gaussian processes
    - https://icml.cc/virtual/2022/spotlight/17164

## Session: Graphical neural nets

* SpeqNets: Sparsity-aware permutation-equivariant graph networks
    - GNNs, 2-GNNs, 3-GNNs, ..., k-GNNs
    - (It turns out 3-GNNs are sufficient to discriminate between basically any two molecules)
    - Can we attain a better tradeoff between expressiveness and scalability (for permutation-equivariant function approximation)?
    - Rather than considering all k-tuples of nodes, we use some small number of k-tuples

* Data2Vec: A general framework for self-supervised learning in speech, vision, and language
    - https://proceedings.mlr.press/v162/baevski22a.html
    - Current state of self-supervized learning: different models for different data modalities
    - Little focus on models that generalize across modalities
    - Related work: momentum teacher (BYOL, DINO), contextualized targets (HuBERT)
    - data2vec
        * take your data, apply a mask;
        * Have two copies of the model, a student and a teacher. The student receives the masked input and attempts to predict the teacher's representation of the data.
    - The teacher model isn't exactly the same as the student -- apparently it uses layer averaging
    - Limitations of data2vec:
        * Modality specific feature encoder and masking parameters
        * Backprop requires two forward passes (since we have the student and teacher) (backward pass only goes through student)
    - Conclusions
        * A single learning objective can outperform the best modality-specific algorithms for vision/speech while being competitive in NLP
        * Target representations based on large context windows and from multiple layers lead to a richer SSL task and improve performance
        * Models that work across multiple modalities seem like a promising avenue of research

* Position prediction as an effective pretraining strategy
    - Masked position prediction pretraining (MP3)
        * pretraining: predict positions from a set of tokens (no position embeddings)
        * finetuning: add position embeddings to the transformer and finetune with labels
    - Attains similar performance with much smaller computational expense

* Orchestra: Unsupervised federated learning via globally consistent clustering
    - Federated learning may allow models to learn from user data while preserving privacy
    - What's the catch? Federated learning requires a lot of data availability 

* Deep and flexible graph neural architecture search
    - GNN architecture is usually provided by human expertise
        * There are two basic building blocks: Propagation (P) and Transform (T).
        * These are usually put in alternating order
    - DF-GNAS uses a genetic algorithm to explore different sequences of P and T operations
    
* GNNRank: Learning global rankings from pairwise comparisons via directed graph neural networks
    - Suppose a graph has nodes representing "competitors" and directed edges representing "matches" between them.
    - Then GNNRank is a graph neural network architecture that can learn to rank the nodes.
    - https://arxiv.org/pdf/2202.00211.pdf

* Large-scale graph neural architecture search
    - Most techniques do not scale well to large graphs
    - 

* Optimization-induced graph implicit nonlinear diffusion
    - message passing neural nets can only pass messages to k-neighbors after k layers!
    - Implicit GNNs: GNNs with infinite layers
    - Implicit GNNs with anisotropic diffusion


## Test of time award

* Poisoning attacks against SVMs
    - Battista Biggio et al.
    - Early days of poisoning attacks
        * simple models
        * security related applications (spam filtering, network intrusion detection, worm signature generation)
    - "Pavel's challenge": show that a popular machine learning method can be poisoned
        * At the time SVMs were quite popular and theoretically grounded
    - Rough start from trying to understand what happens when you change a training point
    - Prior work: incremental and decremental SVM learning
        * A great place to start
        * Not exactly what they were trying to do
    - Goal: to maximize classification error by injecting poisoning samples into training set
    - Strategy: find an optimal attack point x_C in training set that maximizes classification error
    - Main idea
        * Adapt the derivation from incremental SVM but when shifting the poisoning point (the solution is not piecewise linear anymore)
        * So... let's use gradients: how does the SVM solution change during a single update of x_c
        * Preserve KKT optimality
        * Since we know how to compute the gradient, we can maximize the loss on validation points
    - Poisoning as a bilevel optimization problem
        * S. Mei and Xiaojin Zhu (!)
        * Attacker's objective: maximize generalization error on untainted data, w.r.t. poisoning attack
    - Why/when does the attack actually work?
        * Unbounded loss/feature space
        * Constrained/low capacity model
        * Relatively easy to defend against it (easily detected outlier behavior)
    - From poisoning to evasion
        * Main idea: formalize an attack as an optimization problem
        * minimize g(x') s.t. |x-x'| < epsilon
    - Discovery of adversarial examples in deep nets
        * ML security boomed (in terms of **number of papers**)
        * More than 5k papers since 2017
    - Question: what is the future of MLSec, given that there is little evidence of real-world attacks against ML/AI systems?
        * Can we use MLSec to help solve some of today's real industrial challenges?
            - Robustness? Detect OOD examples? Improve maintainability and interpretability? Learn more reliably from noisy/incomplete data?
    
## Session: Applications. Neuroscience, Cognitive science

* Bayesian nonparametric learning for point processes with spatial homogeneity: NBA shot locations
    - Professional basketball
        * Questions
            * How do we model shot locations?
        * Contributions
            - A point process model
    - Dirichlet process mixture model
    - Evaluation
        * Simulation study
            - posteriors covered ground truth pretty well
            - did better than a suite of baseline techniques

* On the effects of artificial data modification
    - Used for enhancing datasets, evaluating models, understanding learned representations
    - What are the implicit assumptions? What are the side effects?
    - Side effects: artifacts created when modifying data
        * E.g., when we mask images, we introduce artifacts such as discontinuous lines
    - Are artifacts associated with label? That would be a problem

* Deep squared euclidean approximation to the levenshtein distance for DNA storage
    - In the DNA storage pipeline, DNA sequences need to be clustered before they can be decoded
    - Levenshtein distance (i.e., edit distance) is used to evaluate the similarity between sequences
    - Generate an embedding for DNA sequences s.t. squared Euclidean distance approximates edit distance
    - Some assumptions:
        * Each element of the embedding vector follows the standard normal

* How faithful is your synthetic data?
    - Evaluating generative models
        * Synthetic data can be sampled from generative models
        * How do we know if the synthetic data is of a high quality? WHat does "quality" mean?
        * Three dimensions proposed:
            - Fidelity
                * alpha-precision: the fraction of generated samples that are within alpha-support of real training samples
            - Diversity: how much of the real data is covered?
            - Generalization: 
        * Post-hoc model auditing

* Error-driven input modulation: Solving the credit assignment problem without a backward pass
    - Backpropagation is not biologically realistic (despite the usual analogistic comparison to neurons)
        * weight transport problem
        * non-local infomration
        * frozen activity
    - PEPITA learning rule for fully connected neural networks
        * Present the Error to Perturb the Input To modulate Activity
        * A heuristic training rule 
            - Is it less expensive???
            - It only uses forward propagation

* How to train your wide neural network without backprop
    - Backpropagation is not biologically plausible (again, for the same reasons)
    - Many biologically-motivated learning rules have been proposed
    - Neural tangent kernel theory allows for theoretical analysis of infinite-width neural networks
    - Weights of wide neural networks are aligned to simple statistics 
    - Alignment at each layer can be quantified
    - Wide, finite-width networks exhibit high alignment
    - Given this observation, they found simplified learning rules equivalent to backpropagation in wide neural networks
    - Not sure what the advantages are...

* Contrastive mixture of posteriors for counterfactual inference, data integration, and fairness
    - Omics data (like transcriptomic data)
    - Representation learning for omics data
    - Challenges
        * Data integration and batch correction
        * Counterfactual predictions of effects of interventions
        * Another challenge (not so much related to omic data): fairness
    - Model: conditional variational autoencoder
        * Given transcriptome and condition, fit encoder/decoder.
    - Contrastive mixture autoencoder
        * 

* Describing differences between text distributions with natural language
    - Training an AI system to provide a "good" description of how two text distributions differ from each other

* Distinguishing rule- and exemplar-based generalization in learning systems
    - Observing the decisions of e.g., a classifier (or animal) and determining how it makes its decisions
    - Does it draw a simple decision boundary ("rule based")? Or does it do something more complicated ("exemplar-based")?
    - [This seems pretty boring. Practically any nontrivial learning system would use multiple features (especially in high-dimensional settings like images)]
    - I probably

* Burst-dependent plasticity and dendritic amplification support target-based learning and hierarchical imitation learning


# Wednesday

## Keynote: Regina Barzilay

* Solving the right problems: making ML models relevant to healthcare and the life sciences
    - [Arrived late, missed first 20 minutes]
    - Molecular modeling
        * functional groups
        * pre-training for molecules: infusing 3D geometry
            - idea: utilize consistency in 2D and 3D representations
            - doesn't yield significant improvement
            - Barzilay thinks the problem is still open, the community hasn't quite solved it yet
    - Continuum of modeling possibilities
    - Synergetic combinations
        * combinations of drugs
        * interactions of drugs
        * modeling combinations with sparse data
            - challenge: have very few observations
        * Biological insight: understand how drugs interact with specific biological processes
        * biochemical representation:
            - molecular targets
            - Compound -> GNN -> representation
    - Generalization
        * Validation becomes tricky in healthcare settings
        * Splitting must be done very carefully
        * Need to validate a model's ability to generalize to (a) new populations (b) new parts of the space of molecules (c) etc.
        * Bane of scaffold splitting: property cliffs
            - properties of molecules can change dramatically as topology or functional groups are modified
        * How to split?
            - Learning to split for automatic bias detection
            - Example in images: identify minority group that is hardest to generalize to
            - Define two models: splitter and predictor
            - Maximize the generalization gap s.t. comparable train/test ratio and [???]
        * Applications
            - Understanding minority groups in Tox-21 dataset
                * Hard split separates data based on _target_.
                * Hard split is not based on _scaffolds_.
                * Dealing with experimental noise: "heuristics galore"
                * Barzilay hopes that as biologists become more ML-aware, sources of technical noise will be driven down
            - Drug-target networks
                * NN that receives drug and target as inputs and returns some predicted value
                * Case study: DepMap
                    - Given a training set, there are many ways you can design the test set
                        * Random split: [stupid]
                        * Easy split: allow targets in train to appear in test
                        * Hard split: don't allow any drug _or_ target in train to appear in test
    - Interpretability
        * Rationales can be informative
        * Without rationales, humans cannot validate predictions
        * Can I trust my classifier?
            - Can we have the model "abstain" on examples for which it is not well-calibrated?
            - A selecteive framework for "confident" confidence
        * Modeling mechanism requires biological context
    - Einstein quote: "If I had an hour to solve a problem and my life depended on the solution, I would spend the first 55 minutes to determine the proper question"

    - Hannes Stark's work with Octavian Ganea [notable postdoc who died recently :(]
        * Equibind: 
            - input: protein 3d structure + molecule. 
            - Output: molecule 3D structure and location
        * prior work: Equidock: invariant rototranslation prediction
        * In reality, molecules are not rigid
            - Equibind's strength is its ability to model _changes_ in molecule structure resulting from binding
        * Standard dataset PDBBind
            - known molecule-protein configurations and arrangements
    - Remarks on Octavian-Eugen Ganea
        * Organizing Molecules in Machine Learning (MoML) conference in October in his memory

## Session 
 
* Tempering fixes data augmentation in Bayesian neural networks
    - Bayesian neural nets
        * prior over parameters; get a posterior over parameters
    - Problem: standard SGD nn's tend to outperform vanilla Bayesian nn's 
    - Bayes and NNs don't combine?
        * Data augmentation seems to be a big part of the gap
    - Data augmentation
        * E.g. for images: rotation, cropping, etc.
    - Typical Bayesian pipeline
        * Start by factorizing posterior: likelihood times prior
        * Usually sensible. But what if we have augmentations in the dataset? The samples are not independent in that case.
    - Simple example: Gaussian mean
        * assume x | mu ~ N(0, sigma^2) where sigma^2  is known
        * augment x with samples drawn from N(x, sigma_noise^2)
        * simple factorization of the likelihood leads to the wrong posterior in this case!
        * However, tempering the factorized posterior can recover the correct posterior
            - I.e., introduce a _temperature_ related to sigma^2 and sigma_noise^2
    - More realistic setting: classification and regression
        * introduce an "invariance" that quantifies the degree to which augmented samples are uncorrelated
    - Concrete task: image classification
        * Augment images with rotations
    - Extensions: they do not explicitly model augmentations, but in principle they could

* Surrogate Likelihoods for Variational Annealed Importance Sampling
    - There are approximate inference methods on a continuum between variational bayes and MCMC
    - In this work, they develop a method that provides useful tradeoffs between (a) inference fidelity and (b) computational expense.

* Nonparametric Sparse Tensor Factorization with Hierarchical Gamma Processes
    - Sparse tensor factorization is great for multi-mode data
    - Most tensor factorizations assume that the proportion of observations remains constant as the number of samples increase.
        * They're interested in the case where the proportion decreases as the number of samples increase
    - Their previous attempt wasn't "flexible" enough. Goal of this work is to create a more flexible sparse tensor model for tensor decomposition
    - They use some kind of hierarchical gamma process as a prior

* Fat-tailed variational inference with anisotropic tail adaptive flows
    - UCB folks: https://proceedings.mlr.press/v162/liang22a.html
    - Typical variational inference: ELBO-maximization
        * E.g., ADVI
    - How do we make the variational family more expressive?
        * Use normalizing flows!
    - But what happens if the target posterior is fat-tailed?
    - Methods
        * Use student-t distributions instead of normal distributions in the normalizing flows
        * they have some math that shows this is necessary to attain certain properties
    - This attains superior performance on a set of common benchmarks in comparison to e.g. ADVI    


* Variational Sparse Coding with Learned Thresholding
    - [Not really sure what's going on in this one]
    - Some kind of thresholding technique for encouraging sparsity in representations

* Structured stochastic gradient MCMC
    - https://proceedings.mlr.press/v162/alexos22a.html
    - Typical ways to infer posterior: exact, VI, MCMC. 
        * In realistic settings we often resort to the latter two.
    - Is there a technique that has the strengths of both VI and MCMC?
    - At a high level: 
        * approximate posterior from variational inference
        * do some kind of sampling technique on top of this
        * [didn't really understand the explanation]

* BAMDT: Bayesian additive semi multivariate decision trees for nonparametric regression
    - nonparametric regression problems
        * response variable (house price)
        * structured (spatial locations on domain) and unstructured features (house numerical attributes)
    - Challenges
        * structured feature space may have a known non-trivial geometry
        * response variable may be discontinuous/irregular
    - Existing methods
        * Spline smoothing
            - Assume smoothness
            - Usually assume an additive model
            - Tensor product splines have too many basis functions
    - Bayesian additive regression trees (BART)
        * Approximate _f_ with simple piecewise constant functions
    - Bayesian additive spanning trees (BAST)
    - Semi-multivariate decision trees (sMDTs)
        * Start with a root node
        * Split a terminal node with a certain probability. If it splits, choose one split rule to obtain a bipartition
            - with a certain prob. perform multivariate split using structured features
            - Otherwise [...missed this]
    - Univariate split rules
        * A node eta in an sMDT represents a subset of the data
        * A univariate split rule divides D_eta into two parts: below the plane and above the plane
    - Multivariate split rules
        * A structured multivariate split divides the data into two parts
        * Main challenges:
            - it's more complicated to do this than in the univariate case
        * Introduce "knot" entities 
    - A bayesian sum-of-multivariate-decision-trees model
        * Use a prior that encourages shallow trees
   
* Variational inference with locally enhanced bounds for hierarchical models 
    - Monte Carlo & VI
        * Simple approach: importance-weighted vi
        * Annealed importance sampling
    - Advantages:
        * bounds get tighter as number of samples increases.
    - Problems:
        * Monte carlo struggles in high dimensions
        * incompatible with subsampling
    - Hierarchical models
        * You could use regular VI
        * Importance-weighted VI 
    - Core idea of this paper: 
        * exploit hierarchical structure to get a tighter bound on evidence: "LOCAL-ELBO"

* Centroid approximation for bootstrap: improving particle quality for inference
    - 

## Session: Chemistry and drug discovery

* LIMO: Latent inceptionism for targeted molecule generation
    - https://github.com/Rose-STL-Lab/LIMO
    - VAE for generating molecules and predicting molecular properties

* Learning to separate voices by spatial regions
    - binaural sensing/source separation

* 3DLinker: An E3 equivariant VAE for molecular linker design
    - Drug development pipeline is expensive -- needle in haystack
    - Drug design, in the abstract, is a molecule generation problem
    - However, this isn't usually the most practical approach
        * Linker design can be more practical
            - link two molecule "parts" together, to form a new molecule with new properties
    - Building blocks: mixed-features message passing
        * Some features are equivariant, others are invariant
        * Need message-passing that preserves the invariance and equivariance
        * Idea: have "invariant messages" and "equivariant messages"

* 3D Infomax improves GNNs for molecular property prediction
    - Want the strengths of 3D models. However, we don't always have access to molecules' 3D structures.
    - Train a neural net to have an internal representation that utilizes 3D structural knowledge

* Biological sequence design with GFlowNets
    - Desiderata for biological sequence design
    - GFlowNet-AL: extension of GFlowNets for active learning
        * keep track of epistemic uncertainty
        * Use some rule (e.g., UCB) to choose next sample

* Pocket2Mol: efficient molecular sampling based on 3D protein pockets
    - Generative model for molecules, given constraints from pocket geometry

* Retroformer: pushing the limits of end-to-end retrosynthesis transformer
    - retrosynthesis is a major building block in organic synthesis
    - task: given a core product, predict the reactants
    - Retroformer: a transformer model that uses both "molecular sequence" and graph

* Constrained Optimization with Dynamic Bound-scaling for Effective NLP Backdoor Defense
    - backdoor attacks: "poisoned" samples
    - backdoor defense: "trigger inversion" (typically used for images)
    - they extend trigger inversion to NLP models

* Path-aware and structure-preserving generation of synthetically accessible molecules
    - reaction-embedded and structure-conditioned VAE

* EquiBind: geometric deep learning for drug binding structure prediction
    - Input: protein 3d structure + molecule
    - Output: molecule location, orientation, and configuration of its atoms
    - Roots in EquiDock, which treats a molecule as a rigid object
    - In reality, molecules can be quite flexible and are modified when they dock to proteins
        * distances between atoms _do_ change
    - Model implementation
        * Kabsch algorithm https://en.wikipedia.org/wiki/Kabsch_algorithm
    - Much faster than traditional docking software 

## Keynote: Aviv Regev. Design for inference in drug discovery and development 

* [She's speaking in person! Unlike many other talks at this conference]
* Our [Genentech's?] mission
    - make scientific discoveries
    - develop them into best-in-class therapeutics
* Medical breakthroughs from technology over the past 40 years
    - recombinant DNA, antibodies,
* Medicines require integrating technology with new biological insights
    - E.g., discoveries about HER2 gene in breast cancer
    - Led to herceptin
    - Discovery of VGEF; responsible for growth of blood vessels
        * impacts certain cancers and macular degeneration
    - Insights: how cells and tissues interact with disease
    - Technologies
* Genentech's ambition for the decade
    - "Double medical advances at less cost to society"
    - opportunity: >100K places in the genome already associated with disease
    - Each place is a potential starting point for therapy design
    - They've observed that drugs which are validated by genetic insights have a much higher probability of success
* Challenge: maps -> mechanisms -> medicines -> patients
    - Each link in this chain is very difficult, slow, failure-prone
    - Therapy design is basically combinatorial; a search over a massive space of possibilities
    - We need to restrict the search space via prior knowledge
    - However, prior knowledge can be restrictive if we don't incorporate it correctly
* Multiplicative levers to maximize patient benefit
    - Knowledge of human biology
    - Technologies that provide high-resolution information at a massive scale/throughput
    - Therapeutic modalities: e.g., recombinant DNA, antibodies, etc.
    - Advances in computation
    - The combination of these is important [perhaps only as good as the weakest link]
* Most of the genetic variants associated with common complex disease are regions that _regulate_ gene expression (not regions that code for proteins)
    - Regulatory circuits govern cell and tissue function
    - To figure out the "wiring" of these circuits, lab techniques are used: perturb the genome, measure response
* Maps to mechanisms: "Lab in a loop" in target discovery
* Example: how does sequence control expression?
    - Approach 1: observe wild-type sequences
    - Approach 2: design new sequences
    - Alternative: TF motifs are prevalent in random DNA
        * An x bits motif is expected to occur every 2^(x-1) bases
        * Random sequences are very easy to synthsize
        * Grow yeast cells with synthesized random sequences
        * "Gigantically parallel reporter assay"
        * Tells us how much expression is driven by each sequence
        * Challenges: 
            - data is extremely noisy and sparse. Each sequence of interest will appear at most once in the assay
            - putting these random synthesized sequences in yeast may not 
        * Lab results: more than 100M regulatory sequences measured
    - Goal 1: learn interpretable model of gene regulation
    - Goal 2: Use this data to train an oracle that takes any sequence and predicts expression levels
        * Model: transformer-based model motivated by biology. >3M trainable parameters
            - Performs well on prediction. Like, 98% accuracy or something
    - Oracle-based design of promoters with abnormally high and low expression
        * Use the oracle + genetic algorithm to search for sequences with desired expression profiles
        * Experimental validation showed that this works!
        * Simulations showed that only 3 or 4 mutations were required. This was born out in experiment!
    - Conflicting expression objectives in different environments constrain expression adaptation
        * In 10 generations
    - Modulation of regulatory complexity by stabilizing selection
        * Initialize with high or low regulatory complexity
        * Introduce each of 3L possible random mutations
        * Select sequence that maintains expression level
            - This produces sequences with desired expression, but with regulatory complexity similar to wild-type sequences.
    - Detecting selection from variation in regulatory sequences
        * Expression conservation coefficient detects signatures of stabilizing slection on gene expression using natural genetic variation in cis-regulatory DNA
            * It's a log-ratio of standard deviations... [didn't catch the details]
            * lower ECC indicates more diversifying/positive selection
            * higher ECC indicates stabilizing selection
        * Evolvability vectors provide a general represntation of the evolutionary properties of regulatory sequences
            * Three archetypes caputre most of the variation in evolvability vectors
* How do we find the combination of nodes in regulatory circuits for therapy targets
    - Classical target discovery: genetic screens
        * Take a population of cells and perturb their genomes
    - Key challenges in genetic screens
        * pre-defined readout: all "hits" look the same
        * too many combinations; each can manifest differently
    - Lab-in-a-loop target discovery: Pooled, high-content screens
    - eg: Perturb-seq in immune dendritic cells (DCs) treated with LPS
    - Massively high content pooled screens for function
        * Perturb-seq is compatible with large scale screens
        * Perturb-seq can be applied at scale
    - Large-scale causal inference of gene regulation
        * causal factor graph model [LOOK THIS UP https://arxiv.org/pdf/2206.07824.pdf]
        * learned factor graph attained excellent performance at low computational expense. Also had useful biological interpretation
    - How do perturbation effects combine?
        * We can't do a full combinatorial screen. There are too many possibilities! There are not enough cells in the world
        * Perturbations and responses are _structured_.
        * Approach: composite perturbation experiments
            - Approach 1: overloading droplets; decompress signal effects
            - Approach 2: Overload guides; decompress lower order effects
            - Aproach 3: Overload guides; predict unobserved combinations
        * Decompressing perturb-seq data
        * Can we predict unobserved combinations?
* SCimilarity: Deep metric learning for identifying "similar" cells
    - In which tissues and diseases can we find fibrotic macrophage-like cells?
* Mechanism to medicine: lab-in-a-loop for molecular drug discovery
    - large molecule optimization and generation
        * Prescient Design!!!
        * Key challenges:
            - prohibitively large discrete space of possibilities
            - Multiple desired properties for each protein
        * Insight: real-world, high dimensional data lie on low-dim manifolds
        * Deep manifold sampler model
            - identifies protein manifold by learning to "denoise"
            - trades off between statistical efficiency and [???]
        * Example: optimizing antibody affinity for a current Genentech target
    - small molecule property prediction
        * Example: successful prediction of antibiotic potency
            - Tommaso Biancalani and Gabriele Scalia!
    - Personalized neoantigen vaccines

* Q&A
    - What are some of the most important public datasets related to her work? 
        * Human Cell Atlas
    - What is a dataset she wishes she had?
        * Perturbational atlases. Observations are good, interventions are even better.
        * Aviv thinks biology is quite special as far as data is concerned.
        * In the field of small molecules, there generally isn't enough public data. 
    - Perturbation studies: has she ever observed a combination of genes that [???]
    - Do you think that the data or the models are holding us back right now?
        * Both can be improved! Large scale data for small molecules is quite limited now. Model improvements are necessary for better out-of-distribution generalization.
        * We need to do better at methodology as well -- splitting the datasets so that we get a better sense of model performance. 

## Session: Physics/Computer vision

* Structure-preserving neural networks: a case studyin the entropy closure of the boltzmann equation
    - Different physical scales of physical modeling
        * E.g., air in this room can be modeled at microscopic (Newton's laws) (kinetic equations) or macroscopic scales
    - Most interested in kinetic equations: moment closures
        * I'm not familiar with kinetic equations: https://encyclopediaofmath.org/wiki/Kinetic_equation
        * Nor am I familiar with the "Boltzmann equation" in this context: https://encyclopediaofmath.org/wiki/Boltzmann_equation
* Composing PDEs with physics-aware neural networks
    - Advection-diffusion processes: modeled by the advection-diffusion equation
    - proposed model: FInite volume neural network (FINN)
    - Seems to replace various functions within the advection-diffusion equation with neural networks
    - Applications: characterizing substance diffusion, determination of unknown functions
* Neuro-symbolic language modeling with automaton-augmented retrieval
    - RetoMaton. Given a LM and its training corpus, we construct a weighted finite-state automaton
    - Background: K-nearest neighbor language model
        * It was computationally expensive to predict chains of words
        * They thought it would be better to store pointers to subsequent words
        * This led them to thinking about chains of words
    - RetoMaton: synergy between a symbolic automaton and a neural language model
        * lower perplexity than the base language model
* Towards coherent and consistent use of entities in narrative generation
    - Why do we care about coherence and consistency? It's a notable property that language models have/don't have
    - Can help quantify limitations of current LMs
    - Current LMs tend to eventually forget about entities as it generates more text.
    - Proposal: extend pre-trained LMs with a "dynamic entity memory"
    - How do we measure progress?
        * long-range entity coherence and consistency metrics
    - They found that entity memory provides very slight improvements to these metrics, but does not approach human ability 
* Pure noise to the rescue of insufficient data: improving imbalanced classification by training on random noise images
    - Past approaches
        * vanilla oversampling (still attains much lower test accuracy on minority classes)
    - Their approach: add random noise to the oversampled images
    - Distribution aware routing batch normalization (DAR-BN)
    - Their approach can also be used to improve balanced classification, on top of existing data augmentation techniques
* Optimally controllable perceptual lossy compression
    - Tradeoff between low bit-rate and low distortion
    - How to acheive optimal distortion-perception tradeoff?
    - distortion-plus-adversarial loss
    - Main contributions
        * One encoder and two encoders are enough for optimally achieving arbitrary D-P tradeoff in certain conditions
        * [I missed this one]
        * [I missed this one too]
    - Results on MNIST and SUNCG (point cloud) datasets
* Learning to solve PDE-constrained inverse problems with graph networks
    - problem: infer knowledge from observation data by leveraging simulation and mathematical models (i.e., PDEs)
        * sparse measurements entail an ill posed problem
        * underlying PDEs can resolve this, though
        * need a fast simulation and a set of priors/regularizers
    - proposal: 
        * GNN-based simulator
            - can handle irregular meshes
        * generative prior
            - map coordinate to mean field value
            - mesh-independent
    - Evaluations
        * wave equation in 2D; with sparse observations in space and time, inferred initial conditions
        * similar for flow assimilation physical system
* ModLaNets: Learning generalizable dynamics via modularity and physical inductive bias
    - Background: fusion of deep learning and analytical mechanics
        * neural networks for next-state prediction
        * neural networks for dynamical system reconstruction
        * neural networks for physical inductive biases
        * previous strategy: model the whole dynamical function
            - Weakenesses: models trained on one system can't be reused for other systems.
    - Proposal: model system elements via modularity
        * Lagrangian is linear combination of kinetic and potential energy
        * Once we have the lagrangian, we can use the Euler-lagrange equations
        * Framework: 
            - transform local coordinates (i.e., generalized coordinates) to global coordinates
                - transformation functions are learned by multilayer perceptrons
                - assume bijective connections between origins and elements are known
            - construct energy
                * kinetic energy
                * potential energy
    - Examples
        * pendulum systems
        * particle systems
        * [??? missed this]
    - Procedure
        * part 1: training
        * part 2: prediction
        * part 3: extension
            - we can reuse neural networks between systems
    - Baselines of comparison: HNN, LNN, baseline (three-layer MLP)
        most representative methods
* Learning to estimate and refine fluid motion with physical dynamics
    - Navier-Stokes
    - prediction-correction scheme
* Tractable dendritic RNNs for reconstructing nonlinear dynamical systems
    - want to infer a model from noisy time series data
    - mathematical tractability
        * analytical computation of fixed points and k-cycles
    - Dendritic PLRNN
        * dendritic computation as linear spline basis expansion 
        * Successful reconstructions in much lower dimesnions
    - Training
        * backprop vs. probabilistic formulation
    - Evaluation on simulated benchmarks
    - Evaluation on empirical data
        * EEG data
        * ECG data
    - Comparisons to other techniques
        * performed well against other techniques on benchmarks, as measured by various metrics
* An intriguing property of geophysics inversion
    - Geophysics inversion: obtain geophysical properties (e.g., velocity) from geophysical measurements (e.g., seismic)
    - Typical approach: "full-waveform inversion"
    - Forward: PDEs. Inverse: their model (a certain neural network architecture)
    - Their model uses fewer parameters than other ones
* A particle transformer for jet tagging

## Session: Self-supervised learning/GNNs

* Adversarial masking for SSL
    - Masked language modeling
        * Models trained by predicting masked words
        * E.g., BERT
    - Masked _image_ modeling
        * Idea: mask out _semantically_ important parts of images
    - Based on augmentation-based SSL
        * given input image X, apply two different augmentations and predict original image
    - _Adversarial_ masking (ADIOS): train a model to mask the data in an adversarial way
    - This produces superior learned representations
* Provable stochastic optimization for global contrastive learning: small batch does not harm performance
    - SimCLR: mini-batch contrastive objective
    - It's been observed that large batch sizes in training yield better performance
    - Proposed method: SogCLR
        * Maintain a moving average between minibatches
        * This yields an objective that is more global than minibatch-specific
    - SogCLR is less sensitive to batch size
    - Empirical evaluations bear out these advantages
* OFA: Unifying Architectures, Tasks, and Modalities Through a Simple Sequence-to-Sequence Learning Framework
    - A pretrained model that attempts to be mode- and task- agnostic
    - Seems to reduce everything to a sequence-to-sequence task
    - Yields good performance 
* Multirate training of neural networks
    - Performance in self-supervised tasks or transfer learning can be affected by learning rates
    - Imagine a version of SGD that partitions the parameters into "fast" and "slow"
        * "slow" parameters are updated less frequently
        * this can yield large speedups in fine-tuning during transfer learning!
* Variational Wasserstein gradient flow
    - Wasserstein gradient flow is an approach for solving optimization problems involving probability distributions.
    - In the past, computing quantities (e.g., expectations, entropy) from the distributions has been expensive
    - They introduce a variational formulation that makes this inexpensive
    - [I don't really understand what's going on here]
* Building robust ensembles via margin boosting
    - Want ensembles of neural nets that are robust to adversarial attacks
    - can formulate this as "margin boosting"
        - zero-sum two-player game
    - They get some empirical results
* Investigating generalization by controlling normalized margin
    - hypothesized implicit bias in SGD
    - Do these implicit biases causally affect generalization?
    - their idea: explicitly control the implicit bias
    - Defining normalized margin
        * for a linear classifier
        * for a neural network
    - By controlling normalized margin, we control the implicit bias
    - Case studies: what is the relationship between normalized margin and generalization?
        * normalized margin _can_ control generalization
* Connect, not collapse: explaining contrastive learning for unsupervized domain adaptation
    - Unsupervised domain adaptation
        * labeled source domain (e.g., sketches)
        * unlabeled target domain (e.g., images)
    - Classical approaches
        * source and target representations should be indistinguishable in order to get good performance
    - Pre-training for UDA
        * pre-train on unlabeled data (combined source + target)
        * fine-tune on labeled data
    - They find that contrastive pre-training doesn't collapse the two domains' representations. Rather, their representations vary quite a lot.
    - They have theoretical results showing that this is okay, if the model encodes relationships between the two domains
* VLUE: A Multi-Task Multi-Dimension Benchmark for Evaluating Vision-Language Pre-training
* Let invariant rationale discovery inspire graph contrastive learning
* Graph neural architecture search under distribution shifts
* Structure-aware transformer for graph representation learning
    - https://github.com/BorgwardtLab/SAT
    - message-passing GNNs use neighborhood aggregation (has several known limitations)
    - graph transformers could address some limitations of MPGNNs.
        * encode the structureal or positional relationships between nodes into the transformer architecture
    - their contribution: 
        * generalize self-attention to account for local structures by extracting a subgraph representation 
    - this seems interesting and worth learning more about

## Session: Deep learning

* Quantifying and learning linear symmetry-based disentanglement
    - [didn't quite get this one]
* Separable group convolutional networks on Lie groups
    - Regular group-convolutional networks
        * in general, result in high computational complexity
    - Separable group convolutions
        * "separable over subgroup and channel dimensions"
    - faster and more parameter-efficient than the nonseparable approach
    - Separable kernels are strictly less expressive, but empirically they do fine. 
        * he guesses it results from implicit regularization.
        * [maybe it's just the "correct" inductive bias?]
* PDO-s3DCNNs: Partial differential operator based steerable CNNs
    - Steerable models formulate equivariance requirements in terms of representation theory and feature fields
    - It's more complicated in 3D than in 2D
* Utilizing expert features for contrastive learning of time-series representations
    - the usual contrastive learning approaches do not learn suitable representations for time series
* Non-convergence results for predictive coding networks
    - Predictive coding networks: an alternative to backprop neural nets for supervised/unsupervised learning, inspired by the brain
    - They are in general more complicated than fully connect neural networks
    - Proved that PCN training is not guaranteed to converge
        * Proof used insights from dynamical systems theory
* Representation topology divergence: a method for comparing data representations
    - R-cross-barcode
    - A metric for dissimilarity between two point-clouds (where there's a one-to-one correspondence between their points)
    - topology-based. Main idea: compare the two manifolds (or, rather, their simplicial approximations)
* Measuring representational robustness of neural networks through shared invariances
    - In practice we may have a set of "desired" invariances
    - "desired" = input transformations that do not change output for a reference network m1
    - Why define invariance using a reference neural network?
        * we have access to the reference network's neural net
        * allows us to investigate interesting questions about deep learning
        * useful for understanding systems of multiple agents controlled by neural networks
    - problem statement
        * given NN m2 and reference network m1 and inputs X
        * how to measure shared invariances between m1 and m2? 
    - proposed technique (STIR)
        * find identically represented inputs x, x' s.t. m1(x) = m1(x')
        * measure similarity of m2(x) and m2(x')
    - evaluation:
        * train 2 resnets on CIFAR; identical hyperparameters, different initializations
        * score them with STIR
        * other questions: how do various choices in a DL pipeline impact STIRs of the resulting models?
* The dual form of neural networks, revisited: connecting test time predictions to training patterns via spotlights of attention
* FlowFormer: linearizing transformers with conservation flows
    - A universal architecture for arbitrary data modalities
    - self-attention results in quadratic complexity 
    - if we can remove the softmax from the transformer, then the complexity is reduced
    - Instead, think of attention as a conserved quantity that "flows" through a network.
    - Solve the network flow problem 
    - this attains the same "competition between features" behavior as softmax-based attention
    - this has linear complexity with sequence length
* Spatial-Channel token distillation for vision MLPs
    - vision MLPs are a thing, I guess?

## Workshop: Computational biology (2022-07-22)

* Opening remarks 
* Predicting and maximizing genomic variant discovery via Bayesian nonparametrics
    - Tamara Broderick
    - Motivation
        - Sequencing costs have come down, but they are still nontrivial
        - Under a fixed budget, it would be great if we could predict the number of variants we'll find [from some experiment]
        - Variant: difference relative to a reference genome
            * Useful for understanding evolution, organism diversity, disease.
            * Can be hard to find. Need either deeper sequencing or more samples to find more.
        - Setup: just completed a pilot study, planning for a follow-up
        - Want to predict: # of new (rare) variants in a follow-up
            * challenge: experimental conditions may change
            * We provide: 1st prediction method where sequencing dpeth can change b/t pilot and follow-up
        - Predicting number of new variants in a followup study -- proposed model: an Indian Buffet Process (IBP)
        - Predicting number of new variants in followup when depth changes --- proposed model: a tweaked IBP
    - Proposed solution
        * We have a reference sample and a set of new samples.
        * We want the _number_ of variants in the new samples.
        * We encode variants using an "order of appearance", rather than by locus
            - [I don't quite understand this]
        * Indian Buffet Process
            - Customers=samples, dishes=variants
            - customer eats existing dish w/ prob. proportional to # of people who ate it so far
            - customer eats a poisson # of new dishes
            - IBP has 3 parameters
                * Learn these from pilot data, use them to make predictions for the follow-up
                * IBP allows us to do this in closed-form!
    - "vanilla" prediction (depth remains the same b/t pilot and followup)
        * prediction task is well-studied.
        * methods based on parametric bayesian, jacknknife, linear programming, etc.
        * all of these methods (including IBP) ignore variant location information
        * Broderick thinks there would be a significant computation/accuracy tradeoff there
    - IBP allows us to handle the more complicated case (depth changes b/t pilot and followup)
        * Vanilla model assumes perfect observations of sequences
        * In reality there is observation noise
            - Each locus is read a random # of times
            - Some reads are errors
            - variant is called or not
        * Prediction problem
            - predict # of variants in follow-up with M samples & depth lambda (different from pilot)
            - New model:
                * IBP, as in vanilla case, for "true" variants
                * "Poisson thinning" for observation noise
                * We no longer have a closed-form formula. But it's close. We just need to evaluate a 1-D integral on a bounded domain
        * We can use this to optimize experiment design
            - Do we get more variants by increasing samples or depth?
            - Solve arg max_{M, lambda} predict # variants s.t. we stay within budget
    - Performance in practice
        * Vanilla prediction problem (depth does not change)
            - Check that our predictions are at least as good as SOTA 
            - Data: African/African-American subpopulation of the gnomAD discovery project
            - Split data into 33 bins
            - a-la cross validation, use each bin for pilot and rest for follow-up
            - shaded regions show variability over bins
                * [Interestingly, IBP and other methods, except Jackknife, underestimate the ground truth]
                * Jackknife is "involved" and requires some parameter selection
            - Broderick observes that IBP is "venerable idea" that seems to get rediscovered frequently
        * varying-depth prediction
            - Similar cross-validation-like setup
            - They don't have actual varying-depth data -- instead they use the data from the previous task, and simulate additional thinning of observations due to sequencing depth
            - In this case IBP tracks ground truth quite well. Jackknife greatly overestimates variant count.
        * Optimal use of the budget
            - data: TCGA uterine cancer
            - setup: budget=B; Each
                * [What's the cost model???]
    - Conclusions
        * They have a model that attains SOTA predictive performance on a more flexible set of tasks!
        * Bayesian approach also permits a variety of other abilities
            - For UQ, they prefer a bootstrap technique rather than the straightforward posterior
    - Q&A:
        * How do you choose the reference sequence?
            - She punts on this question -- she's an ML person, ask a biologist. She does admit it's important and interesting
        * What value does uncertainty quantification provide?
        * How do you judge the quality of uncertainty quantification?
        * Why use the bootstrapping technique for UQ, rather than straightforward posterior uncertainty?
            - The posterior uncertainty is trustworthy when the prior and likelihood are well-specified
            - In this case, sampling uncertainty seems "dominant" and she doesn't think the likelihood is well specified
            - Hence, she trusts bootstrap more

* Generative power of a protein language model trained on multiple sequence alignments
    - Damiano Sgarbossa (EPFL)
    - Understanding proteins
    - Protein families and multiple sequence alignments
        * Conserved positions, coevolved positions, phylogenetic trees
    - major progress in structure prediction (e.g., AlphaFold)
    - NLP & masked language modeling
    - We can do something similar with proteins
        * mask amino acids and train the model to fill them in.
    - Goal and methods
        * Can we generate new protein sequences from any protein family 
    - Comparison of two generative models
        * Potts model
            - statistical model
            - family-specific
            - relies on MCMC
        * MSA Transformer
            - BERT-like architecture
            - self-supervised training
            - uses an additional _axial attention_ mechanism
                * shares information _between_ sequences and _within_ sequences
    - Using MSA transformer as a generative model
        * iteratively mask positions and train the model to fill them in
        * reminds me of the diffusion models gaining currency in image generation. Not really the same, though
    - Scoring generated sequences
        * "coevolution score"
        * "homology score"
            - Hamming distance 
        * "structural score"
    - Q&A
        * How does this compare with VAEs?
            - Past works have shown Potts models are better than VAEs. (And now MSA transformer does better than that)
        * How do we know MSA transformer learns something useful, instead of doing something trivial like plugging in the most common amino acids?
            - the evaluation scores show that generated sequences have fairly high Hamming distance from the natural sequences, so something nontrivial is going on
        * Masking procedure: how does it work? Do you mask a fixed fraction of amino acids?
            - Yes, they use a fixed fraction at 10% or 12% (12% was the fraction used during training)
* RITA: a study on scaling up generative protein sequence models
    - Does protein modeling scale as well as NLP?
    - Does upstream performance transfer to performance on downstream tasks?
    - Downstream tasks
        * protein function prediction (Protein gym?)
        * enzyme function prediction
        * prompt tuning
    - Conclusions: larger models are better!
* Learning batch-invariant representations with domain adaptation in large scale proteomics data
    - Overcoming batch effects in a certain kind of proteomic data
    - Diagnose batch effects via PCA regression and [???]
    - Correct the batch effects via domain adaptation methods
        * Domain adversarial neural networks (DANNs)
    - DANN variants can remove technical variation while preserving biological signal
    - DANN variants can improve generalization in transfer learning settings
        * DANN variant == representation learned by DANN
* COEM: cross-modal embedding for metacell identification
    - metacell: a group of scRNAseq cell profiles that are statistically equivalent to samples derived from the same RNA pool
    - metacells can alleviate sparsity problems in scRNAseq via aggregation
    - SeaCells is designed to identify metacells in RNA or ATAC modality
    - Different data modalities possibly exhibit a time lag between chromatin remodeling of a gene and its transcription
    - COEM: cross-modal embedding for metacell identification
        * joint nonlinear embedding (VAE) -> similarity matrix -> spectral clustering -> 
    - Evaluation
        * metacell evaluation on sci-CAR cell line dataset

* Towards a common coordinate framework: alignment of spatially resolved omics data
    - Jean Fan (JHU, JEFworks)
    - How are cells spatially organized within tissues? How does this differ in health vs. disease?
    - Spatially resolved transcriptomics technologies provide opportunities to answer these questions
        * Check out Atta and Fan (2021) for an overview
    - Topics for this morngin
        - Imaging -based molecular-resolution spatially resolved transcriptomics technologies
        - comparative spatial analysis across samples and technologies
    - mRNA's spatial organization can be imaged within individual cells and tissue samples
    - Once we have this data, we can do various kinds of dimension reduction and clustering on the cells
    - Computational analysis can help identify genes with spatially patterned expression within tissues
    - MERINGUE: builds spatial auto-correlation and cross-correlation analysis to identify and characerize spatially variable genes
        * Most interested in _spatial_ auto- and cross-correlation
        * Hope to infer putative cell-cell interactions
    - MerFISH - type technologies: cells and spots
    - When multiple cells appear in one pixel, there may be confounding
        * COmputational analysis can help recover cell-type-specific gene expression and proportions within multi-cellular pixels
        * Use gene frequencies to infer the latent cell-types
            - Pixels are mixtures of cell-types
            - model is analogous to latent dirichlet allocation
            - trying to infer proportions of cell types within pixels
            - STdeconvolve
    - How can computation help us make "apples-to-apples" spatial comparisons across samples, technologies, etc.?
        * STalign builds on Large Deformation Diffeomorphic Metric Mapping to align spatial transcriptomics datasets
            - https://en.wikipedia.org/wiki/Large_deformation_diffeomorphic_metric_mapping
        * I.e., uses a diffeomorphic mapping to align a new image with a reference image
        * can align data from different technologies, e.g., MERFISH and Visium
    - https://jef.works/
    - Q&A
        * How technology-specific is MERINGUE?
            - It's designed with MERFISH in mind. MERFISH cleanly segments the spatial signal, which is important for the auto- and cross-correlation calculations
            - Other spatial transcriptomics technologies don't segment the signal as cleanly
        * Has she arrived at any insights about the relationship between spatial organization and function?
        * Interpreting cell types from the 
        * Is computational power a bottleneck for her research? Her examples have been mouse brains (which are small)
            - They're working on techniques that scale to larger structures.
            - It's common to use the cloud in computational anatomy
        * There are many kinds of spatial transcriptomic technologies. Some are targeted (FISH, Visium), others are open to the full transcriptome (at lower resolution). Is it worthwhile to develop computational methods around the untargeted approaches?
            - Jean sees technological innovations happening in both directions.
            - Computationalists ought to think about where they can make the greatest impact
* BayesTME: A reference-free Bayesian method for end-to-end analysis of spatial transcriptomics data
    - In spatial transcriptomics, deconvolution can be difficult
    - Motivation: want a generative model of ST that deconvolves ST and takes spatial information into account without needing scRNAseq reference 
    - Big picture of BayesTME
        * raw data -> bleed correction -> type selection -> spot deconvolution -> [??? missed this]
    - Bleed correction
        * Some kind of negative binomial distributional assumption -- didn't catch the details
        * A lot of existing methods make isotropic gaussian assumptions about bleeding - this is usually violated
        * Evaluations show that it has high accuracy and precision (without scRNAseq reference)
        * Also selects optimal number of cell types!
        * segments cells into communities
    - Spatial differential expression
    - evaluation on Zebrafish samples
        * BayesTME identifies several cell types, including tumor, muscle, skin, and interface
    - Q&A
        * Why is it better to have an end-to-end solution, rather than a piece-by-piece one?
            - with a holistic model we can account for all the sources of variation
        * How do you distinguish between biological spatial variation and artificial bleeding?
            - Since they use the spatial information, they can distinguish between those
* EquiBind: geometric deep learning for drug-binding structure prediction (again)
    - evaluated on PDBBind dataset
    - SE(3) transformer paper: https://arxiv.org/pdf/2006.10503.pdf
* Learning to rank metabolites across datasets 
    - dataset: 1727 samples x 2000 metabolites. 80% missing entries
    - metabolomics data collection
        * tissue -> sample -> digested metabolites
    - metabolomics data issues
        * poor feature overlap
        * metabolite levels are reported in relative abundances
            - can't meaningfully compare between (or within!) batches
        * [seems like there are technological issues to solve in metabolomics data]
    - Method: NMF
* 7-UP: generating in-silico CODEX form a small set of immunofluorescence markers
    - James Zou (Stanford)
    - CODEX is a spatial proteomics technology
        * can image up to 40+ biomarkers, but is costly and time consuming
        * goal: use ML to generate multiplex CODEX images from only a few markers
    - 7-UP: imputing 40+ biomarkers from only 7 input markers
        * 1) select input markers 2) precess cell patches 3) extract morphology features 4) impute biomarkers
    - trained and evaluated on largest CODEX datasets
    - HNSC: UPMC dataset
    - Cell type predictions from imputed biomarkers
        * CODEX predictions agree with ground truth quite well
        * used for predicting patient outcomes
            - yielded same predictive power as ground truth CODEX
    - 7-UP generalizes to other datasets, cancer types, locations, etc.
        * WHere did this robustness come from? See the poster :)
* RTfold: RNA secondary structure prediction using deep learning with domain inductive bias
    - RTfold attempts to bridge the gap between:
        * dynamic programming-based methods (better generalization, but limiting assumptions)
        * deep learning methods (powerful representation, but requires a lot of data)
        * want the best of both worlds
    - key ideas
        * efficient end-to-end training using perturbtation and fenchel-yonge loss
        * [missed this]
    - Encode RNA secondary structure constraints into linear program
        * The solution of the linear program will always be discrete
    - End-to-end training with constrained optimization
    - Architecture
        * Layer-wise recursion
        * self-attention
        * move beyond existing fully-convolutional design
* DeepVelo: estimating cell-specific kinetic rates of RNA velocity for multi-lineage systems
    - RNA velocity: change of spliced mature mRNA. v = ds/dt
    - the dynamics of unspliced and spliced mrna are modeled by two ODEs, parametereized by kinetic rates
    - existing methods use constant kinetic rates or predifined dynamics
    - proposed solution:
        * cell-specific rates
        * unconstrained dynamics
    - DeepVelo pipeline
        * Input to model: expression of cell
        * encode: 
        * [missed the other steps]
    - DeepVelo captures multiple dynamics of TMSB10 and recapitulates developing branching lineages on mouse hindbrain data
    - still not sure what data they use, the exact form of the model, or how they evaluate performance

* Panel: ML for drug discovery
   - Panelists: Mohamed Al Quraishi (Columbia), Elana Fertig (JHU), Patrick Schwab (Glaxo Smith Klein), Neeha Zaidii (JHU), Amanda Huff , Pascal Notin


**Shit, I lost half a day's-worth of notes! Incorrectly recovered the file after the terminal closed unexpectedly**

I'm mostly annoyed that I lost my notes for the panel. 
I remember their talking points at a high level.

* Half-remembered notes from the panel (ML for drug discovery)
    - 
    - Will academia or industry be the best place to make an impact?
    - What are the bottlenecks for ML in drug discovery/medicine?

## Workshop: AI for science

* Opening remarks
    - goals:
        * discuss directions in ML that are likely/unlikely to make an impact acoss disciplines
        * highlight scientific questions that are ripe for ML methods
        * pinpoint grand challenges that are cross-disciplinary
        * [some others that I missed]
    - Speakers: 
        * Anima Anandkumar (CalTech, chemistry), 
        * Gitter (UW Madison, biology), 
        * Gomes (Cornell, sustainability), 
        * Gomez-Bombarelli (MIT, materials science), 
        * Han (Flatiron institute, mathematics), 
        * Koller (Insitro, drug discovery), 
        * Noe (FU Berlin, molecular physics), 
        * Tegmark (MIT, physics)
* Frank Noe
    - We would be falling short if we only used ML to keep doing the same things
    - Many parts of science are becoming more expensive per unit outcome -- e.g., drug discovery. It's like the inverse of Moore's law.
    - Ideally, we would have a fully automatic closed loop between ML and a robotic laboratory (with tools for human oversight)
    - For now, Noe is working on a digital version of this with simulations in place of a laboratory
    - Some work in quantum chemistry: PauliNet
        * Solving schrodinger's equation becomes very difficult (exponential expense) as the number of atoms increases
        * Density functional theory has been a useful approach
        * Can extend with ML by running many DFT calculations and then passing the problem instances to an ML model (supervised formulation)
        * An alternative proposed by Noe: Quantum Monte Carlo with deep learning
        * Variational formulation. Use a neural net to represent the wave function; use ML as an optimization strategy
        * Important property: wave function antisymmetry
            - This is responsible for the Pauli exclusion principle, and causes the exponential difficulty of solving the Schrodinger equation.
            - Standard approach is to represent antisymmetry using matrix determinants
            - The problem is that there are exponentially many determinants to compute
            - ML solution: replace some of this machinery with neural networks
        * The resulting system attains high accuracy and scales better to larger systems (e.g., molecules)
    - In this example, physics provided a variational formulation, the loss function, other aspects of the problem
    - Some work in macromolecule dynamics
        * Large molecules (proteins) move, bend, etc.
        * When we want to compute a property of a protein (e.g., binding affinity for a drug), we need to account for the many states taken by the protein as it "wiggles"
        * Current simulation approaches are very slow -- a GPU-year to simulate one hour
        * ML solution: use a generative model -- normalizing flow
            * invertible transformation of random variables
            * "Boltzmann generators": train with known energy (minimize KL divergence between generated and Boltzmann distribution)
            * Maximize generator likelihood of training data X: I.e., minimize KL divergence
        * A limitation of normalizing flows: bijectivity. This hinders the model's ability to represent multimodal distributions
        * Stochasticity can help this. The flow no longer is bijective
    - Coarse-graining with graph neural networks
    - [All in all, these are very creative uses of deep learning. (1) frame physics problem as variational problem (2) use deep learning to represent infinite-dimensional functions (3) train using high-fidelity simulations. Not clear about the role of stochasticity in the Stochastic normalizing flow case.]
    - Q&A
        * How does PaoliNet scale with the number of atoms?
            - On paper, N^4. In practice, N^3. Could be practical for dozens of atoms, possibly ~100.
        * [Future applications]
            - There are still many breakthroughs to make in protein physics. There will be many more AlphaFolds
* Active learning for (Rafael Gomez-Bombarelli)
    - Virtual discovery 
    - What does AI supremacy look like in materials science?
        * explicit rules make the job easier
    - Computational spectrum - virtual science
        * At one end: first principles. At the other end: machine learning
        * first principles do not learn, but they do extrapolate. Sometimes they're cheap
        * ML is fast, improves with data, attains good performance. But only as good as training data.
    - Autodiff uncertainty and ML potentials
        * ML potentials: surrogate function from atomic configurations to e.g., energy of the system
        * GNNs, equivariant models
        * training data: >10^4 pairs of structure, energy pairs
    - Interatomic potentials
    - Uncertainty quantification in NNs is possible
        * Mean-variance estimation
        * monte-carlo dropout
        * ensembling
        * Every prediction now comes with a standard deviation that, in principle, is correlated with error
    - Using NN potentials for molecules
        * Motivation: batteries
        * Lithium chelation. Lithium ion batteries require electorlytes to shuffle Li cations. Liquids cause problems, though!
        * Want to compute Li-organic binding energies
        * Active learning approach -- use DFT calculations to get data
    - Coarse graining auto-encoding framework
    - Differentiable MD simulations
        * Use neural ODE to learn time evolution
        * However it's very unstable, and ground truth is expensive to obtain
        * We can formulate the active learning/sample selection problem as an _adversarial attack_ that maximizes the uncertainty
     

# Themes that I noticed at ICML 2022

* graph neural networks; transformers
* SE(3) layers; invariant and equivariant features
* self-supervized learning; constrastive learning
* robustness
* multi-modal/cross-modal tasks and representations
* data augmentation
* OOD-detection; distributional shift
* Connections between ODEs/PDEs and neural networks
* biological and chemical applications

In probabilistic methods sessions:
* connections between ODE/PDE solvers and posterior inference




