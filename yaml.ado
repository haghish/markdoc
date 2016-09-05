

*cap prog drop yaml
program define yaml

	syntax [anything]  				/// 
	[, 				 ///
	replace 	 	 /// replaces the exported file
	theme(str)  	 /// specifies the markup language used in the document
	color(str) 	 	 /// specifies the exported format
	font(str)  		 /// specifies the path to Pandoc software on the machine
	fontsize(str)    /// the path to the PDF printer on the machine
	template(str) 	 /// template docx, CSS, ODT, or LaTeX heading
	TITle(str)   	 /// specifies the title of the document (for styling)
	AUthor(str)  	 /// specifies the author of mthe document (for styling)
	Date(str)		 /// Add the current date to the document
	]
	
	// -------------------------------------------------------------------------
	// 1- 
	// 2- create a log file with a name
	// 3- execute the do-file
	// 4- close the log, restore the snapshot, erase the snapshot
	// 5- convert the log file and erase it
	// =========================================================================
	
	if missing("`fontsize'") local fontsize 12pt
	tempfile yaml
	tempname knot
	qui file open `knot' using `"`yaml'"', write replace
	
	file write `knot' "---" _n 													
	if !missing("`title'") file write `knot' `"title: `title'"' _n														
	if !missing("`author'") file write `knot' "author: `author'" _n														
	if !missing("`date'") file write `knot' "date: `date'"	_n															
	if !missing("`fontsize'") file write `knot' "fontsize: `fontsize'pt" _n(2)				
	
	file write `knot' "output:" _n												///
	"  beamer_presentation:" _n													///
	`"    theme: "`theme'""' _n													///
    `"    colortheme: "`color'""' _n											///
    `"    fonttheme: "`font'""' _n(2)											
	
	if !missing("`template'") {
		file write `knot' `"    includes:"' _n									///
		`"      in_header: `template'"' _n										
	}
	
	file write `knot' "---" _n(2)
	file close `knot'
	copy `"`yaml'"' `anything', `replace'

end

/*
yaml, name("myfile.txt") replace theme(Boadilla) color(lily) font(structurebold) ///
template(body.tex) fontsize(14pt) date(anything!) author(me) title(myfirstyaml) 

