---
title: "PathwayMultiomics visualizations: ISMB 2022" 
layout: note
tags: [julia, visualization, comp-bio]
---

Links to the **interactive visualizations:**

* [Pathway embedding **scatter plot** (TCGA data)]({{ site.baseurl }}/assets/visualizations/tcga_scatter-ismb2022.html)
    - Shows the result of PCA _after_ embedding via PathwayMultiomics.jl\
        * I.e., PathwayMultiomics reduced dimensionality 80k --> 300; then PCA reduced dimensionality 300 --> 3.
    - Click on the legend to view specific cancer types.


* [Pathway activation **comparison plot** (TCGA data)]({{ site.baseurl }}/assets/visualizations/activations-ismb2022.html)
    - Horizontal axis shows different pathways (in alphabetical order).
    - Vertical axis shows the relative pathway activations of different cancer types.
        * In principle we could show activations for individual samples.
          However, that visualization quickly became cluttered.
    - Activation levels have been standardized for visualization.
    - Click on the legend to view specific cancer types.

* [Pathway **factor plot** (TCGA)]({{ site.baseurl }}/assets/visualizations/pathway_factors-ismb2022.html)
    - WARNING: large file (42.6 MB)
    - Each line plot is a row of the matrix Y (i.e., a pathway factor)
        * We only show a representative set of 10 factors. This is already a large file!
        * Horizontal axis shows (assay, gene) pairs.
        * Vertical axis shows pathways' components in the matrix Y.
    - Click on the dropdown menu to view specific pathway factors.
    - Black dots indicate _known_ pathway members.
    - Observations:
        * Some factors correspond poorly to their pathways (e.g., the "MAPK6/MAPK4 signaling" pathway). We're still thinking about ways to manage and interpret these.
        * Other factors correspond quite well to their pathways. They frequently include non-pathway members, too, suggesting PathwayMultiomics' potential for hypothesis generation. 
