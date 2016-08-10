/*** DO NOT EDIT THIS LINE -----------------------------------------------------

Version: 0.0.0


Intro Description
=================

packagename -- A new module for ... 


Author(s) section
=================

Author name ...
Author affiliation ...
to add more authors, leave an empty line between authors' information

Second author ...
For more information visit {browse "http://www.haghish.com/markdoc":MarkDoc homepage}


Syntax
=================

{opt exam:ple} {depvar} [{indepvars}] {ifin} using 
[{it:{help filename:filename}}]
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt rep:lace}}replace this example{p_end}
{synopt :{opt app:end}}work further on this help file{p_end}
{synopt :{opt addmore}}you can add more description for the options; Moreover, 
       the text you write can be placed in multiple lines {p_end}
{synopt :{opt learn:smcl}}you won't make a loss learning
{help smcl:SMCL Language} {p_end}
{synoptline}
----------------------------------------------------- DO NOT EDIT THIS LINE ***/

* Note: If you like to leave the "Intro Description" or "Author(s) section
* empty, erase the text but KEEP THE HEADINGS



cd "/Users/haghish/Dropbox/STATA/MY PROGRAMS/MarkDoc/MarkDoc 3.6.7"

/***

\section{Reading statistical packages}

:Literate programming was adopted by statisticians for documenting the process of data analysis and generating dynamic analysis reports \cite{ Literate_programming_using_noweb, 1994_Literate_programming_simplified, Literate_Statistical_Programming.Concepts_and_Tools} and several literate programming packages have been developed particularly for statistical languages to meet the special features required for analysis reports \cite{weaver, markdoc, xie2013knitr, xieknit, leisch2002sweave, allaire2015rmarkdown, statweave}. 

>While statisticians strongly support literate programming for data analysis, when it comes to programming statistical packages, the best they have come up with is documenting individual functions and objects using literate programming packages such as Roxygen2 \cite{roxygen2:In-source_documentation_for_R} in R or MarkDoc \cite{markdoc} in Stata. However, as the number of script files and the structural complexity of the package (nested files or functions) increase, the object documentation will provide minor information about the overall structure and logic of the package. 

Any R package includes a number of R script files and each may include one or more functions. Furthermore, each of these functions may call other functions written in different script files within the package as well. Thus, an R package with a few files and functions, may have a very complex nested structure. Furthermore, R packages may include script files written in other programming languages, such as C or C++ which further increases the complexity of the package. 

My argument is that open source programming languages such as R that do not require header files, should be carefully documented at both micro-level and macro-level to improve the readability of the package. The micro-level documentation is already advocated by literate programming packages. However, macro-level documentation -- inferring on the overall architecture of the package and function dependency -- is surprisingly ignored. To treat R packages truly as work of literature that should be read by humans and not just the compiler, as Knuth proposed, we should bear in mind that instead of instructing a ``computer what to do'', we shall ``concentrate rather on explaining to human beings what we want a computer to do'' \cite{knuth1984literate, knuth1992book}. 

Yet, there has been no software for macro-level documentation of R packages. In the current article, I introduce CodeMap, an application written for Macintosh operating system, that discovers the file and function dependency tree of an R package, and visualize them in an interactively. 

***/


markdoc example.do, export(sthlp) markup() replace linesize(120) texmaster				///
printer("/usr/texbin/pdflatex")

/***
Example
=================

    explain what it does
        . example command

    second explanation
        . example command
***/



