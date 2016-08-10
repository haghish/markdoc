capture erase example.smcl
capture erase example.pdf

// -----------------------------------------------------------------------------
// Stata Journal Exportation using Markdown
// =============================================================================
qui log using example, replace smcl
	
	/***
	This is heading 1
	
	***/
	
	txt "## Testing __`txt`__ command" _n ///
	"This is how it works!"

sysuse auto, clear
regress price mpg


qui log c 
markdoc example, replace exp(tex) nonumber texmaster style(stata) toc statax ///
tit("This is the title") author("haghish") date ///
summary("THIS IS S H DASID JI FJ FKJD FDJS FDF OEI DLFK D÷L FSOF OEF POFI DLFK")
