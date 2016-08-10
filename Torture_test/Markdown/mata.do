capture erase example.smcl
capture erase example.md 
capture erase example.docx

// -----------------------------------------------------------------------------
// Mata
// =============================================================================

qui log using example, replace smcl

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
markdoc example, replace exp() nonumber
