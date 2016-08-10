capture erase example.smcl
capture erase example.md 

// -----------------------------------------------------------------------------
// Weaver Commands
// =============================================================================
qui log using example, replace smcl
	txt "this command can be literally anywhere" _n 	///
		"======================================" 
	txt "this command can be literally anywhere" _n 	///
		"======================================
	txt "this command can be literally anywhere" _n 	///
		"======================================"
	
	sysuse auto, clear
	hist price 
	graph export graph.png, as(png) width(300) replace 
	
	img using graph.png, title("This is the title")
	img , title("AUTOMATICALL LOADED")
	
	tble (Title 1, variables, something \ 1 , 2 , 3)
	tble (Title 1, variables, something \ 1 , 2 , 3)
	tble (Title 1, variables, something \ 1 , 2 , 3)
	
qui log c 
markdoc example, replace exp() 
