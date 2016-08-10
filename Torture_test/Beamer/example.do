
qui log using example, replace

/***

---
title: "Dynamic Slides in MarkDoc Package"
author: E. F. Haghish
date: February 2016


output:
  beamer_presentation:
    theme: "Boadilla"
    colortheme: "lily"
    fonttheme: "structurebold"
---

Creating dynamic slides in Stata
================================

- Dynamic slides are slides created for statistical representation and thus, 
includes code and output from Stata. 

- The __`markdoc`__ command allows you to 
easily create a _smcl log file_ and use it for creating dynamic analysis 
reports or even PDF slides. In this tutorial I will demonstrate how to quickly 
create the slides from Stata. Here are a few capabilities of the package. 


About MarkDoc
=============

MarkDoc is a general purpose literate programming package that can export 
dynamic reports in several formats within Stata. However, this tutorial only 
demonstrates the dynamic slide feature. 

- Adding images and figures
- Interpreting mathematics
- creating PDF slides


How Does it Word?
=================

- Install MarkDoc (ssc install markdoc)
- Install a full LaTeX distribution
- provide the path to **pdfLaTeX** in the `printer()` option (see below)
- Learn from this example!




How about mathematics?
======================

The dynamic slides are compiled with LaTeX and naturally, 
LaTeX mathematical notations are supported. Here is an example:

- $f(x)=\sum_{n=0}^\infty\frac{f^{(n)}(a)}{n!}(x-a)^n$ 




How about Stata Output?
======================

You can execute any command and present the outputs as well!
***/

sysuse auto, clear
tab price if price < 4000

//OFF
histogram price
graph export graph.png, replace 
//ON


/***
Adding a graph
==========================

![Histogram of the *Price* variable](graph.png)



How to create more slides?
==========================

- Every heading creates a new slide. 
- You can also use __#__ at the beginning of the line for creating a new slide. 
- or make a line with equal signs under a text  line (see the code)

***/







qui log c

markdoc example, export(slide) replace // printer("PATH/TO/pdflatex")
