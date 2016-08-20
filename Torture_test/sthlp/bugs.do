/***

Adding a list
=============

* this is a text line  
* this is also  
* how about this?  
	
	
Dot in the end
==============

It seems that if a line end with a "." dot, 
and a new line is 
started adter, 
the __sthlp__ engine will add 2 space characters. 
Like this. 
Is that solved? 


This is not true if the text is written immediately. after the dot

Also, removing.
space after the dot does not help!

__AFTER EVALUATING THE {help smcl} file__ it seems {help markdoc} is working 
very fine and there is no bug. This is how Stata renders SMCL document...
but still, there is no reason why there should be 2 spaces.

This problem,
only happens after dots.


Ending the line with accent
===========================

The grave accents are used to `make` font monospace. Can we 


Unsolved
===========================



***/

markdoc "./sthlp/bugs.do", export(sthlp) replace template(empty)
