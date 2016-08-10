capture erase example.smcl
capture erase example.md 

// -----------------------------------------------------------------------------
// Stata commands & comments
// =============================================================================
qui log using example, replace smcl
sysuse auto, clear
	// this is a comment
	   *also this is a comment
regress price mpg
forval num = 1/1 {
	// this is a comment
	   *also this is a comment
	   
	 /*
	 this is a comment
  */
  
  /****
	Crazy comments?
 */	
  
}

qui log c 
markdoc example, replace exp()
