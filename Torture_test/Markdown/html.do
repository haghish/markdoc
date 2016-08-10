capture erase example.smcl
capture erase example.md 
capture erase example.docx

// -----------------------------------------------------------------------------
// HTML Document Exportation
// =============================================================================
qui log using example, replace smcl
	
	/***
	This is heading 1
	=================
	
	<h1>This is also HTML written with HTML tag</h1>
	
	![This Is a Figure!](./graph.png)
	***/
	
	txt "## Testing __`txt`__ command" _n ///
	"This is how it works!"
	
	

sysuse auto, clear
regress price mpg


qui log c 
markdoc example, replace exp(html) nonumber style() toc statax tit("This is the title")
