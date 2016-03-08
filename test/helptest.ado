/*** DO NOT EDIT THIS LINE -----------------------------------------------------

Version: 1.0.0


Intro Description
=================

myprogram -- A new module for to print text. This description can include 
multiple lines, but not several paragraphs. You may write the title section 
in multiple lines. {help MarkDoc} will connect the lines to create only a 
single paragraph. If you'd like to describe the package more, create a 
description section below this header.

Author(s) section
=================

E. F. Haghish
University of Freiburg
haghish@imbi.uni-freiburg.de
{browse "http://www.haghish.com/markdoc"}

Syntax
=================

{opt myprogram} [{it:anything}] [, {opt b:old} {opt i:talic}] 

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt b:old}}prints bold text{p_end}
{synopt :{opt i:talic}}prints italic text{p_end}
{synoptline}
----------------------------------------------------- DO NOT EDIT THIS LINE ***/

* Note: If you like to leave the "Intro Description" or "Author(s) section
* empty, erase the text but KEEP THE HEADINGS


cap prog drop myprogram
program myprogram
	syntax [anything] [, Bold Italic]
    if missing("`bold'") & missing("`italic'") {
		display as txt `anything'
	}	
	else if !missing("`bold'") & missing("`italic'") {
		local anything : display `anything'
		display as txt "{bf:`anything'}"
	}
	else if missing("`bold'") & !missing("`italic'") {
		local anything : display `anything'
		display as txt "{it:`anything'}"
	}
	else {
		local anything : display `anything'
		display "{bf:{it:`anything'}}"
	}
end


/***


: Typically, the text paragraphs in Stata help files begin with an indention, 
which makes the help file easier to read (and that's important). To do so, 
place a {bf:{c -(}p 4 4 2{c )-}} directive above the line to indent the text
paragraph and you're good to go. 

: this is a text paragraph that is processing __Markdown__, _italic text_ or 
___underscored text___. The only thing left is the link! but how far can this 
__text styling go__? I mean how far does the 
rabit whole go? do you have any idea?


- - -

: this is a text paragraph that is processing __Markdown__, _italic text_ or 
___underscored text___. The only thing left is the link! but how far can this 
__text styling go__? I mean how far does the 
rabit whole go? do you have any idea?


> this is a text paragraph that is processing __Markdown__, _italic text_ or 
___underscored text___. The only thing left is the link! but how far can this 
__text styling go__? I mean how far does the 
rabit whole go? do you have any idea?


Another heading 
----------------------

{p 4 4 2}	
Typically, the text paragraphs in Stata help files begin with an indention, 
which makes the help file easier to read (and that's important). To do so, 
place a {bf:{c -(}p 4 4 2{c )-}} directive above the line to indent the text
paragraph and you're good to go. 

***/

/***
Example
=================

    print {bf:bold} text
        . myprogram "print this text in bold", bold

    print {it:italic} text
        . myprogram "print this text in italic", i
***/

/***
Dynamic Graph
=============

+-----------------+       +--------+           +--------------------+
| markdown source |------>| mdddia |------+--->| processed markdown |
+-----------------+       +--------+      |    +--------------------+
                              |           +--->| image files        |
                    +------------------+       +--------------------+
                    | diagram creation |
                    +------------------+
                    | ditaa/dot/rdfdot |
                    +------------------+
					
      Source |       SS           df       MS      Number of obs   =        74
-------------+----------------------------------   F(1, 72)        =     20.26
       Model |   139449474         1   139449474   Prob > F        =    0.0000
    Residual |   495615923        72  6883554.48   R-squared       =    0.2196
-------------+----------------------------------   Adj R-squared   =    0.2087
       Total |   635065396        73  8699525.97   Root MSE        =    2623.7

------------------------------------------------------------------------------
       price |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         mpg |  -238.8943   53.07669    -4.50   0.000    -344.7008   -133.0879
       _cons |   11253.06   1170.813     9.61   0.000     8919.088    13587.03
------------------------------------------------------------------------------
					

***/

*cap prog drop markdoc
markdoc test/helptest.ado, replace export(sthlp) 
