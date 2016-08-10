capture erase example.smcl
capture erase example.md 

// -----------------------------------------------------------------------------
// Markdown notation
// =============================================================================
qui log using example, replace smcl
	/***
	This is a regular heading
	=========================
	
	This is a subheading
	--------------------
	
	### Paragraph 3?
	
	#### Paragraph 4?
	
	##### Paragraph 5?
	
	###### Paragraph 6? 
	
	Text paragraph perhaps?
	
	***/
	
forval num = 1/1 {
	/***
	Text can be included in the loop, but is only printed once
	=========================================================
	
	So DON'T DO IT!
	***/
}

qui log c 
markdoc example, replace exp() 
