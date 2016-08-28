//capture prog drop markdoc
capture erase example.pdf

sysuse auto, clear
capture log c
qui log using example, replace
/***

---
title: "Dynamic Slides in MarkDoc Package"
author: E. F. Haghish
date: or anything else
fontsize: 14pt

output:
  beamer_presentation:
    theme: "Boadilla"
    colortheme: "lily"
    fonttheme: "structurebold"
	
	includes:
      in_header: body.tex
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
- Learn from this example!




How about mathematics?
======================

The dynamic slides are compiled with \LaTeX{} and naturally, 
\LaTeX{} mathematical notations are supported. Here is an example:

- $f(x)=\sum_{n=0}^\infty\frac{f^{(n)}(a)}{n!}(x-a)^n$ 




How about Stata Output?
======================

You can execute any command and present the outputs as well!
***/


tab price if price < 4000



/***
How to create more slides?
==========================

Every heading creates a new slide. You can also use __#__ at the beginning of 
the line for creating a new slide




# How about wider Stata outputs

if you use commands that produce wider tables, reduce the __fontsize__ 
at the beginning of the document to keep the output within the document. 

***/



qui log c

//capture prog drop markdoc
markdoc example, export(slide) replace  







exit

cap erase example.pdf
! "C:\ado\plus\Weaver\Pandoc\pandoc.exe"  -t beamer source.md -V theme:Boadilla -V ///
   colortheme:lily -V fontsize=8pt -o example.pdf



exit
! "C:\ado\plus\Weaver\Pandoc\pandoc.exe"  -t beamer source.md -V theme:AnnArbor -V fontsize=9pt   -o example.pdf
! "C:\ado\plus\Weaver\Pandoc\pandoc.exe"  -t beamer example.md -V theme:AnnArbor  -o example.pdf
! "C:\ado\plus\Weaver\Pandoc\pandoc.exe"  -t beamer example.md -V theme:Warsaw -o example01.pdf

! "C:\ado\plus\Weaver\Pandoc\pandoc.exe"  -t beamer source.md -o example01.pdf
