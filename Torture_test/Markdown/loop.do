capture erase example.smcl
capture erase example.md 

// -----------------------------------------------------------------------------
// COMPLEX LOOP
// =============================================================================
qui log using example, replace smcl
		
		/**/ sysuse auto, clear	

          /***/ sysuse auto, clear //2
//OFF	
//ON  

if 100 > 12 {
	local m  `n'
		*this is a comment
	display "how about this?"
}
	  
forval num = 1/5 {
	display "yeap!" _n
	/****
	Crazy comments?
 */	
	display "yeap!" _n
	qui log off
	  *this is a comment
	//this is a comment
	qui log on
			/***
			Text can be included in the loop, but is only printed once
			=========================================================
			***/
			
			txt "#### but dynamic text can appear in a loop many times!" _n
}
		//OFF
		
	/***
	Does it word?
	=============
	
	this is some text paragraph. 
    ***/
display "hi"
		//ON
qui log c 
markdoc example, replace exp(docx) nonumber
