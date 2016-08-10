// -----------------------------------------------------------------------------
// Creating Table of Content
// =============================================================================
cap erase example.pdf

qui log using example, replace smcl
        txt \section{This is a text heading}

	/***
	\subsection{How about some more text?} 
	this is some text paragraph. 
	***/

		
qui log c 
markdoc example, replace markup(latex) exp(tex) toc texmaster
