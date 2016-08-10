cap erase programming_course.pdf
capture log c
qui log using programming_course, replace


/***
---
title: "Stata, as a programming language"
author: E. F. Haghish 
		
date: March 2016

fontsize: 14pt

output:
  beamer_presentation:
    theme: "Boadilla"
    colortheme: "lily"
    fonttheme: "structurebold"
	
	includes:
      in_header: body.tex
---

ABout the workshop
================================

- Reviewing different features of Stata programming language

- Giving examples and homework for each feature

- The workshop is completely lab-based, teaching solutions to actual problems


ABout the workshop
================================

- The workshop includes a number of "problems" categorized as
Beginner, Intermediate, and Advanced level

- The solutions are already provided, but you should make an attempt for 
solving them yourself

- After each problem, we discuss possible solutions and we spend a few minutes 
programming 

- I will cover a wide-range of programs 


Beginner Level 
================================================================================



Intermediate Level
================================================================================


Problem 1 : File
================

"file allows programmers to read and write both text and binary files, so file 
could be used to write a program to input data in some complicated situation. 
Files are referred to by a file handle. When you open a file, you specify the 
file handle that you want to use"

- read the following file with the program and count the number of lines!
"https://raw.githubusercontent.com/haghish/MarkDoc/master/README.md"

- Write an ado program that reads a file and counts the number of lines


Solution
================
***/

capture program drop countline
program countline
syntax using/
	tempname handle
	file open `handle' using `"`using'"', read
	file read `handle' line
	local lnum 0
	while r(eof) == 0 {	
		file read `handle' line
		local lnum `++lnum'
	}
	file close `handle'
	display as txt "(the file includes {bf:`lnum'} lines)"
end

countline using "https://raw.githubusercontent.com/haghish/MarkDoc/master/README.md"



/***
Advanced Level 
================================================================================

Problem 1 : File
================

In the first problem of the intermediate level, we wrote a program that opens 
a file and counts the number of lines. Rewrite that program with Mata



***/



qui log c
markdoc programming_course, export(slide) replace linesize(120)


