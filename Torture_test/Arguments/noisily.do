// -----------------------------------------------------------------------------
// HTML Document Exportation
// =============================================================================
qui log using example, replace smcl
	
	/***
	This is heading 1
	=================
	
	<h1>This is also HTML written with HTML tag</h1>
	***/
	
	txt "## Testing HTML" _n ///
	"This is how it works!"

sysuse auto, clear
regress price mpg


qui log c 
markdoc example, replace exp(html) num style() toc statax 					///
tit("This is the title") noisily
