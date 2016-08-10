capture erase example.smcl
capture erase example.html

// -----------------------------------------------------------------------------
// PDF Document Exportation
// =============================================================================
qui log using example, replace smcl
	
	/***
	This is heading 1
	=================
	
	![This Is a Figure!](./graph.png)
	
	***/
	
	txt "## Testing __`txt`__ command" _n ///
	"This is how it works!"

sysuse auto, clear
regress price mpg


qui log c 

markdoc example, replace exp(pdf) nonumber style() toc statax tit("This is the title")
