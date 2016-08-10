capture erase example.smcl
capture erase example.md 

// -----------------------------------------------------------------------------
// Special Markups
// =============================================================================
qui log using example, replace smcl
		/**/ sysuse auto, clear	
		/**/ sysuse auto, clear	
		/**/ sysuse auto, clear	
		/**/ sysuse auto, clear	
		
	   /***/ sysuse auto, clear
	   /***/ sysuse auto, clear
	   /***/ sysuse auto, clear
	   
/***
Using "ON" and "OFF" to hide loop code
======================

Make sure to add INDENTS before the markers to make sure MarkDoc is robust to indents
***/
	   
       //OFF	   
forval num = 1/1 {
	// this is a comment
	   *also this is a comment
	display "try"
}
    //ON

                 /***
           MarkDoc allows you to __IMPORT__ external files (Markdown, HTML, LaTeX) 
   In the dynamic document. Here I test for that! MarkDoc should be resistent to 
 INDENT.
          ***/	

	//IMPORT ./Markdown/import.md
	
forval num = 1/1 {
	// this is a comment
	   *also this is a comment
	display "try"
}

/***
Loops cannot be hidden
======================
***/
	// ??? THIS DOES NOT WORK ;)
			/**/ forval num = 1/1 {
	// this is a comment
	   *also this is a comment
	display "try"
}	

qui log c 
markdoc example, replace exp()
