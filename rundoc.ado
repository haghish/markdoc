// CREATES A LOG AND CALLS MARKDOC! 
  
*cap prog drop rundoc
program define rundoc

	syntax [anything(name=dofile id="The do file name is")]  				/// 
	[, 				 ///
	replace 	 	 /// replaces the exported file
	MARKup(name)  	 /// specifies the markup language used in the document
	Export(name) 	 /// specifies the exported format
	INSTALl 	 	 /// Installs the required software automatically
	Test 		 	 /// tests the required software to make sure they're running correctly 
	PANdoc(str)  	 /// specifies the path to Pandoc software on the machine
	PRINTer(str)     /// the path to the PDF printer on the machine
	TEXmaster 	 	 /// creates a "Main" LaTeX file which is executable 
	master 	 	 	 /// creates a "Main" LaTeX & HTML layout 
	statax			 /// Activate the syntax highlighter
	TEMPlate(str) 	 /// template docx, CSS, ODT, or LaTeX heading
	TITle(str)   	 /// specifies the title of the document (for styling)
	AUthor(str)  	 /// specifies the author of mthe document (for styling)
	AFFiliation(str) /// specifies author affiliation (for styling)
	ADDress(str) 	 /// specifies author contact information (for styling)
	Date			 /// Add the current date to the document
	SUMmary(str)     /// writing the summary or abstract of the report
	VERsion(str)     /// add version to dynamic help file
	linesize(numlist max=1 int >=80 <=255) /// line size of the document and translator
	toc				 /// Creates table of content
	NOIsily			 /// Debugging Pandoc, pdfLaTeX, and wkhtmltopdf
	debug			 /// Debugging Pandoc, pdfLaTeX, and wkhtmltopdf
	ASCIItable		 /// convert ASCII tables to SMCL in dynamic help files
	NUMbered	 	 /// number Stata commands
	MATHjax 		 /// Interprets mathematics using MathJax
	STYle(name)      /// specifies the style of the document
	/// Slide options
	/// ========================================================================
	btheme(str) 	 ///
	bcolor(str) 	 ///
	bfont(str)  	 ///
	bfontsize(str)   ///
	bcodesize(str)	 ///
	bwidth(str)	 	 ///
	bheight(str)	 ///
	///SETpath(str)  /// the path to the PDF printer on the machine
	///Printer(name) /// the printer name (for PDF only) 
	///TABle	     /// changes the formats of the table and creates publication ready tables (UNDER DEVELOPMENT AND UNDOCUMENTED)
	///RUNhead(str)  /// running head for the document (for styling) 
	///PDFlatex(str) ///this command is discontinued in version 3.0 and replaced by setpath()
	///Font(name)	 /// specifies the document font (ONLY HTML)
	///
	]
	
	
	capture quietly display `dofile'
	if _rc == 0 {
		local input `dofile'
	}
	else {
		local input "`dofile'"
	}

	// -------------------------------------------------------------------------
	// 1- 
	// 2- create a log file with a name
	// 3- execute the do-file
	// 4- close the log, restore the snapshot, erase the snapshot
	// 5- convert the log file and erase it
	// =========================================================================
	
	quietly snapshot save
	local number `r(snapshot)'
	
	quietly clear
	
	capture log close rundoc
	quietly log using "`input'.smcl", replace smcl name(rundoc)
	
	
	tempfile  documentation objects
	tempname hitch knot doc obj
	qui file open `hitch' using "`input'.do", read 
	qui file read `hitch' line
	while r(eof) == 0 {
		
	
		// save the code in a file
		// -------------------------------------------------------------------
		tempfile tmp
		qui file open `knot' using "`tmp'", write replace
		while `"`macval(line)'"' != "/***" & r(eof) == 0 {
			file write `knot' `"`macval(line)'"' _n
			file read `hitch' line
		}
		

		
		// make a list of the objects from documentation
		// -------------------------------------------------------------------
		if `"`macval(line)'"' == "/***" {
			qui file open `obj' using "`objects'", write replace
			qui file open `doc' using "`documentation'", write replace
			file write `doc' "/***" _n
			file read `hitch' line
			file write `doc' `"`macval(line)'"' _n
			
			// repeat this for successive documentation chunks ????
			// ---------------------------------------------------------------

			while `"`macval(line)'"' != "***/" & r(eof) == 0 {
				while strpos(`"`macval(line)'"', "!>") > 0  {
					local start = strpos(`"`macval(line)'"', "<!") 
					local end = strpos(`"`macval(line)'"', "!>") 
					local l = `end' - `start'
					local macro = substr(`"`macval(line)'"', `start', `l')
					local val =  substr(`"`macval(line)'"', `start'+2, `l'-2)
					file write `obj' `"`macval(val)'"' _n
					local line = substr(`"`macval(line)'"', `end'+2, .)
				}
				file read `hitch' line
				file write `doc' `"`macval(line)'"' _n
			}
			file write `doc' "***/" _n
			
			
			file close `doc'
			file close `obj'
			
			// evaluate the objects
			// ---------------------------------------------------------------
*qui copy "`objects'" "____.txt", replace public	
			tempfile results2
			
			file write `knot' "//OFF" _n 																	///
			"tempfile results" _n 																			///
			"tempname resread reswrite " _n																	///
			`"file open "' "`" "reswrite" "'" `" using ""' "`" "results" "'" `"", write replace"' 	_n		///
			`"file open "' "`" "resread" "'" `" using ""' "`objects'" `"", read"'	_n				    	///
///`"copy "`objects'" "___.txt", replace public"'	_n		/// FOR TESTING THE LIST		    	///			
			`"file read "' "`" "resread" "'" `" line"'	_n			                                        ///
			"while r(eof) == 0 {" _n 																		///
			`"  file write  "' "`" "reswrite" "'" `" "'  "`" `"""' "`" `"macval(line)"' "'" `"  ""' "'" _n  ///
			`"  local test : display real("' `"""' "`" "line" "'" `"""' `")"' _n							///	
			"  if " `"""' "`" "test" "'" `"""' " != " `"".""' "{" _n									    ///
			`"      file write  "' "`" "reswrite" "' "  `"""' "`" "test" "'" `"""' _n 						///
			"  }" _n 																						///
			"  else {" _n 																					///
			"    local test2 //RESET" _n																	///
			"    local test3 //RESET" _n																	///
			"    capture local test2 : display " "`" "line" "'" _n 											///
			"    capture local test3 : display int(" "`" "test2" "'" ")" _n(2) 								/// 
				 ///INTEGER
			"    if !missing(" `"""' "`" "test2" "'" `"""' ") & " `"""' "`" "test3" "'" `"""' " == " `"""' "`" "test2" "'" `"""' " {" _n 	///
			"        capture local m : display " "`" "line" "'" _n 											///
			"        if _rc == 0 {" _n 																		///
			`"           file write  "' "`" "reswrite" "' "  `"""' "`" "m" "'" `"""' _n 					///
			"        }" _n																					///
			"    }" _n 																						///
				 /// REAL
			"    else if !missing(" `"""' "`" "test3" "'" `"""' ")" " & " `"""'"`""test3""'"`"""' " != " `"""' "`" "test2" "'" `"""' " {" _n ///
			"        capture local m : display %10.2f " "`" "line" "'" _n 									///
			"        if _rc == 0 {" _n 																		///
			`"           file write  "' "`" "reswrite" "' "  `"""' "`" "m" "'" `"""' _n 					///
			"        }" _n 																					///
			"        else {" _n 																			///
			"        capture local m :  display " `"""' "`" "line" "'" `"""' _n 							///
			"         file write  " "`" "reswrite" "' "  `"""' "`" "m" "'" `"""' _n 						///
			"        }" _n 																					///
			"    }" _n 																						///
			"    else if !missing(" `"""' "`" "test2" "'" `"""' ")" " & " "missing(" `"""' "`" "test3" "'" `"""' ") {" _n 					///
			"        capture local m : display %10.2f " "`" "line" "'" _n 									///
			"        if _rc == 0 {" _n 																		///
			`"           file write  "' "`" "reswrite" "' "  `"""' "`" "m" "'" `"""' _n 					///
			"        }" _n 																					///
			"    }" _n 																						///
			/// STRING SCALARS
			"    if missing(" `"""' "`" "test2" "'" `"""' ")  {" _n 																				///
			"        capture local m : display  " `"""' "`" "line" "'" `"""'  _n 							///
			`"        file write  "' "`" "reswrite" "' "  `"""' "`" "m" "'" `"""' _n 						///
			///"        }" _n 																				///
			"    }" _n 																						///
			/// ELSE 
			///"    else {" _n 																				///
			///`"        file write  "' "`" "reswrite" "' "  `"""' "`" "line" "'" `"""' _n 					///
			///"     }" _n 																					///
			"}" _n 																							///
			"  file read ""`" "resread" "'" " line" _n 														///
			"  file write  ""`" "reswrite" "'" "   _n" _n 													///
			"}" _n 																							///
			"file close ""`" "resread" "'" " " _n 															///
			"file close  ""`" "reswrite" "'" " " _n 														///
			"quietly copy " "`" "results" "'" " `results2', public replace" _n 								///
///"quietly copy " "`" "results" "'" " ___res.txt, public replace" _n 								///
			"//ON" _n
			
			file close `knot'
			
			
			// get the code
			// ---------------------------------------------------------------
			capture noisily do "`tmp'"
*copy "`tmp'" "___code.txt", replace
			
			// create a dataset
			// ---------------------------------------------------------------
			preserve
			
			tempname objlist
			clear
			qui set obs 1
			qui gen obj = ""
			qui gen val = ""
			qui file open `objlist' using "`results2'", read
			file read `objlist' line2
			local nn 1
			while r(eof) == 0 {
				tokenize `"`macval(line2)'"'
				if !missing(`"`macval(1)'"') {
					qui replace obj = `"`macval(1)'"' in `nn' 
					macro shift
					qui replace val = `"`*'"' in `nn' 
					local nn `++nn'
					qui set obs `nn'
				}
				file read `objlist' line2
			}	
			file close `objlist'
			
			//drop the duplications
			cap qui duplicates drop obj, force
			
			// changing the text
			// ---------------------------------------------------------------
			tempfile correction
			tempname corread corwrite 
			qui file open `corwrite' using "`correction'", write replace
			qui file open `corread' using "`documentation'", read
			file read `corread' line2
			while `"`macval(line2)'"' != "***/" & r(eof) == 0 {
				while strpos(`"`macval(line2)'"', "!>") > 3 {
					local start = strpos(`"`macval(line2)'"', "<!") 
					local end = strpos(`"`macval(line2)'"', "!>") 
					local l = `end' - `start'
					local macro = substr(`"`macval(line2)'"', `start', `l')
					local val =  substr(`"`macval(line2)'"', `start'+2, `l'-2)
					if `"`macval(val)'"' != "" {
						forval i = 1(1)`c(N)' {
							if `"`macval(val)'"' == obj[`i'] {
								local rep : di val[`i']
								local line2 : subinstr local line2 `"<!`macval(val)'!>"' "`rep'"
							}
						}
					}					
				}
				file write `corwrite' `"`macval(line2)'"' _n
				file read `corread' line2
				
			}
			file write `corwrite' "***/" _n
			file close `corwrite'
			
			// run the documentation
			// ---------------------------------------------------------------
			capture noisily do "`correction'"
	
			restore
			
			*capture erase "____.txt"
			*capture erase "____results.txt"
			
			file read `hitch' line
			
		}
		
		// -------------------------------------------------------------------
		// If there is no documentation just run the source code
		// ===================================================================
		else {
			file close `knot'
			capture noisily do "`tmp'"
		}
	}
	cap file close `hitch'
	
	*capture noisily do "`input'"
	qui log off rundoc
	
	snapshot restore `number'
	capture snapshot erase `number'
	
	
	markdoc "`input'.smcl",														///
	`replace' 																	///
	markup(`markup') 															///
	export(`export') 															///
	`install' 																	///
	`test' 																		///	
	pandoc("`pandoc'")															///
	printer("`printer'")														///
	`master'																	///
	`statax'																	///
	template(`template')														///
	title("`title'")															///
	author("`author'")															///
	affiliation("`affiliation'")												///
	address("`address'")														///
	`date'  																	///
	summary("`summary'")														///
	version("`version'")														///
	style("`style'")															///
	linesize(`linesize')														///
	`toc'																		///
	`noisily'																	///
	`debug'																		///
	`asciitable'																///
	`numbered'																	///
	`mathjax'																	///
	btheme(`btheme')															///
	bcolor(`bcolor')															///
	bfont(`bfont')																///
	bfontsize(`bfontsize')   													///
	bcodesize(`bcodesize')	 													///
	bwidth(`bwidth')	 														///
	bheight(`bheight')															
	
	capture qui log close rundoc
	capture quietly erase "`input'.smcl"
	
end

/*
cap log c
cap erase simple20.html
markdoc "simple20.do" , export(md) replace 
