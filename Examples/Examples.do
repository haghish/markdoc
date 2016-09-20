/*
Examples
========

MarkDoc has 3 different engines:

1. convert smcl log-file to document or presentation slides

2. execute a do-file, examine if it's reproducible, and produces dynamic 
document or slides

3. reads the documentation written in ado or mata files and export Stata help 
files of package vignette

This document provides examples for all of the engines


E. F. Haghish
Department of Mathematics and Computer Science
University of Southern Denmark
Odense, Denmark

Aug 2016
*/

cd "/Users/haghish/Documents/Packages/markdoc/Examples"



// =============================================================================
// 
// PART 1 : TESTING SMCL ENGINE
//
// The smcl engine converts smcl log files to variety of formats
// =============================================================================

// Mathematical notations
do ./Mathematics/math_smcl.do





// =============================================================================
// 
// PART 2 : TESTING DO ENGINE
//
// The do engine executes do-files in a cleared workspace
// =============================================================================

// first load data in Stata, because MarkDoc will ignore your current workspace!
sysuse auto, clear
markdoc "./do/errors.do", export(html) replace statax
markdoc "./do/errors.do", export(pdf) replace statax
markdoc "./do/errors.do", export(docx) replace
markdoc "./do/errors.do", export(odt) replace
markdoc "./do/errors.do", export(latex) replace texmaster



// Erase the products
// =============================================================================
cap erase graph.png
cap erase example.docx
cap erase example.html
cap erase example.odt

cap erase example.pdf
cap erase example.smcl
cap erase example.tex
cap erase example.aux
cap erase example.log
cap erase example.out
cap erase example.synctex.gz

cap erase example2.pdf
cap erase example2.smcl
cap erase example2.tex
cap erase example2.aux
cap erase example2.log
cap erase example2.out
cap erase example2.synctex.gz
cap erase myprogram.ado

