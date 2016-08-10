capture erase example.smcl
capture erase example.md 
capture erase example.docx

// -----------------------------------------------------------------------------
// Docx Document Exportation
// =============================================================================
qui log using example, replace smcl

	txt "## Testing Mata" _n ///
	"This is how it works!"
	
	/***
	How about some more text? 2
	==========================
	
	some more?
	----------
	
	### How about Heading 3?
	***/

sysuse auto, clear
regress price mpg
qui log c 
cap erase example.docx
markdoc example, replace exp(docx) toc nonumber style(stata)
