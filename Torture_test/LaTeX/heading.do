// -----------------------------------------------------------------------------
// begin heading with TXT
// =============================================================================
qui log using example, replace smcl
	txt "\documentclass{article}" _n											///
	"\usepackage{graphics}" _n													///
	"\begin{document}" _n
    txt "\section{This is a text heading}" _n									

	/***
	\subsection{How about some more text?} 
	this is some text paragraph. 
	
	\includegraphics{graph.png}
	***/
	
	
	
txt "\end{document}" _n
		
qui log c 
markdoc example, replace markup(latex) exp(tex) 
