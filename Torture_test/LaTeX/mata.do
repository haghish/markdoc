// -----------------------------------------------------------------------------
// With MATA
// =============================================================================
qui log using example, replace smcl
/***
Hi there
***/

txt "\section{This is a text heading}"

sysuse auto, clear
summarize price mpg weight 
if 100 > 12 {
	local m  `n'
}
	/***
	\subsection{How about some more text?} 
	this is some text paragraph. 
	***/
clear mata	
mata
    /***
	\section{How about Mata?} 
	This should also work in mata 
	***/

function zeros(c)
{
	a = J(c, 1, 0)
	return(a)
	
}

function zeros2(c)
{
a = J(c, 1, 0)
return(a)
}

	/***
	\section{How about Mata?} 
	This should also work in mata 
	***/
	
	printf("HELLO WORLD!\n")
	
end

qui log c 
markdoc example, replace markup(latex) export(tex) texmaster


