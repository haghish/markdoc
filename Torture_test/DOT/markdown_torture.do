// -----------------------------------------------------------------------------
// empty template
// =============================================================================
qui log using 000, replace smcl
qui log c 
markdoc 000, replace exp() 

// -----------------------------------------------------------------------------
// Markdown notation
// =============================================================================
qui log using 000, replace smcl
	/***
	This is a regular heading
	=========================
	
	This is a subheading
	--------------------
	
	Text paragraph perhaps?
	***/
	
forval num = 1/1 {
	/***
	Text can be included in the loop, but is only printed once
	=========================================================
	***/
}

qui log c 
markdoc 000, replace exp() 


// -----------------------------------------------------------------------------
// Stata commands & comments
// =============================================================================
qui log using 000, replace smcl
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
markdoc 000, replace exp()


// -----------------------------------------------------------------------------
// Special Markups
// =============================================================================
qui log using 000, replace smcl
		/**/ sysuse auto, clear	
		/**/ sysuse auto, clear	
		/**/ sysuse auto, clear	
		/**/ sysuse auto, clear	
		
	   /***/ sysuse auto, clear
	   /***/ sysuse auto, clear
	   /***/ sysuse auto, clear
       //OFF	   
forval num = 1/1 {
	// this is a comment
	   *also this is a comment
	display "try"
}
    //ON
	
	
	// ??? THIS DOES NOT WORK ;)
			/**/ forval num = 1/1 {
	// this is a comment
	   *also this is a comment
	display "try"
}	

qui log c 
markdoc 000, replace exp()


// -----------------------------------------------------------------------------
// Weaver Commands
// =============================================================================
qui log using 000, replace smcl
	txt "this command can be literally anywhere" _n 	///
		"======================================" 
	txt "this command can be literally anywhere" _n 	///
		"======================================
	txt "this command can be literally anywhere" _n 	///
		"======================================	
	img markdoc.ado, title("This is the title")
	img markdoc.ado, title("This is the title")
	img markdoc.ado, title("This is the title")
	
	tble (Title 1, variables, something \ 1 , 2 , 3)
	tble (Title 1, variables, something \ 1 , 2 , 3)
	tble (Title 1, variables, something \ 1 , 2 , 3)
	
qui log c 
markdoc 000, replace exp() 



// -----------------------------------------------------------------------------
// COMPLEX LOOP
// =============================================================================
qui log using 000, replace smcl
		
		/**/ sysuse auto, clear	

          /***/ sysuse auto, clear //2
//OFF	
//ON  

if 100 > 12 {
	local m  `n'
		*this is a comment
	display "how about this?"
}
	  
forval num = 1/1 {
	display "yeap!"
	/****
	Crazy comments?
 */	
	display "yeap!"
	qui log off
	  *this is a comment
	//this is a comment
	qui log on
			/***
			Text canbe included in the loop, but is only printed once
			=========================================================
			***/
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
markdoc 000, replace exp(docx) nonumber






// -----------------------------------------------------------------------------
// Mata
// =============================================================================

qui log using 000, replace smcl

	txt "## Testing Mata"

clear mata	
mata
    /***
	How about some more text? 2
	---------------------------
	***/
	
	// COMMENT
	
function zeros(c)
{
	a = J(c, 1, 0)
	return(a)
	
}

function zeros2(c)
{
a = J(c, 1, 0)
return(a)
}

printf("HELLO WORLD!\n")

	/***
	How about some more text? 3
	---------------------------
	***/
	
	/**/ printf("Hide Command!\n")
	
	/***/ printf("Hide Output!\n")
	
end

qui log c 
markdoc 000, replace exp() nonumber



// -----------------------------------------------------------------------------
// Docx Document Exportation
// =============================================================================
qui log using 000, replace smcl

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
cap erase 000.docx
markdoc 000, replace exp(docx) toc nonumber style(stata)


// -----------------------------------------------------------------------------
// PDF Document Exportation
// =============================================================================
qui log using 000, replace smcl
	
	/***
	This is heading 1
	
	***/
	
	txt "## Testing Mata" _n ///
	"This is how it works!"

sysuse auto, clear
regress price mpg


qui log c 
markdoc 000, replace exp(html) nonumber style() toc statax tit("This is the title")


// -----------------------------------------------------------------------------
// Stata Journal Exportation using Markdown
// =============================================================================
qui log using 000, replace smcl
	
	/***
	This is heading 1
	
	***/
	
	txt "## Testing Mata" _n ///
	"This is how it works!"

sysuse auto, clear
regress price mpg


qui log c 
markdoc 000, replace exp(tex) nonumber texmaster style(stata) toc statax ///
tit("This is the title") author("haghish") date ///
summary("THIS IS S H DASID JI FJ FKJD FDJS FDF OEI DLFK D÷L FSOF OEF POFI DLFK")


// -----------------------------------------------------------------------------
// Literate Visualization Notation
// =============================================================================
qui log using 000, replace smcl
	/***
	Dynamic Software Visualization
	=========================
	
	
	Writing software documentation and visualizing seletive information can 
	boost active learning in students...
	
	Example 1
	--------------------
	***/
	
	/***$$
	digraph { 
  		a -> b; 
	***/ 
	
	/***$
	}
	***/
qui log c 
markdoc 000, replace exp(html)
