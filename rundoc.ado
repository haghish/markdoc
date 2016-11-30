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
	
	
	tempfile tmp
	tempname hitch knot
*	tempfile documentation 
*	tempname  doc obj
	qui file open `knot' using "`tmp'", write replace
	qui file open `hitch' using "`input'.do", read 
	qui file read `hitch' line
	
	//preserve the code
*	tempfile rescue 

	
	while r(eof) == 0 {
		
		while `"`macval(line)'"' != "/***" & r(eof) == 0 {
			file write `knot' `"`macval(line)'"' _n
			file read `hitch' line
		}

		
		// -------------------------------------------------------------------
		// If there is no documentation just append the documentation
		// ===================================================================
		if `"`macval(line)'"' == "/***" {
			tempfile documentation
			tempname doc
			qui file open `doc' using "`documentation'", write replace
			file write `doc' "/***" _n 
			
			tempfile display
			tempname disp
			qui file open `disp' using "`display'", write replace
			file write `disp' `"/**/ di as txt "> " ///"' _n
			
			local activate //RESET 
			file read `hitch' line
		
			while `"`macval(line)'"' != "***/" & r(eof) == 0 {
				if !missing("`found'") file write `disp' " _n ///" _n 
				
				local found //RESET
				
				while strpos(`"`macval(line)'"', "!>") > 0  {
					local activate 1
					if missing("`found'") file write `disp' " _n ///" _n 
					*else file write `disp' " ///" _n
					
					local start = strpos(`"`macval(line)'"', "<!") 
					local end = strpos(`"`macval(line)'"', "!>") 
					local l = `end' - `start'
					local part = substr(`"`macval(line)'"', 1, `start'-1)
					
					// SECURE PART
					// --------------------------------------------------------
					local part : subinstr local part " `" " \\`", all
					local part : subinstr local part " $" " \\$", all
					local part : subinstr local part " \\$$" " $$", all
					
					
					if missing("`found'") file write `disp' "`" `""> `macval(part)'""' "'"			//write text parts
					else file write `disp' "`" `""`macval(part)'""' "'"
					local val =  substr(`"`macval(line)'"', `start'+2, `l'-2)
					*file write `disp' `" %10.2f `macval(val)'"'   	
					file write `disp' `" `macval(val)'"'   
					local line = substr(`"`macval(line)'"', `end'+2, .)
					
					local found 1
				}
				if !missing("`found'")  {
					if trim(`"`macval(line)'"') != "" {
						// SECURE PART
						// --------------------------------------------------------
						local line : subinstr local line " `" " \\`", all
						local line : subinstr local line " $" " \\$", all
						local line : subinstr local line " \\$$" " $$", all
						file write `disp' `" "`macval(line)'""' 
					}	
					*else file write `disp' `" "' 
				}	
				if missing("`found'") {
					
					// SECURE PART
					// --------------------------------------------------------
					local line : subinstr local line " `" " \\`", all
					local line : subinstr local line " $" " \\$", all
					local line : subinstr local line " \\$$" " $$", all

					
					
					file write `disp' "`" `""> `macval(line)'""' "'" " _n ///" _n
				}	
				if missing("`activate'") {					
					file write `doc' `"`macval(line)'"' _n 
				}	
						
				file read `hitch' line
			}
			if `"`macval(line)'"' == "***/" file write `doc' "***/" _n 
			
			
			file close `doc'
			file close `disp'
			tempname add
			if missing("`activate'") {
				file open `add' using "`documentation'", read
				file read `add' docline
				while r(eof) == 0 {
					file write `knot' `"`macval(docline)'"' _n
					file read `add' docline
				}
				file close `add'
				cap erase "`documentation'"
			}
			else {
				file open `add' using "`display'", read
				file read `add' docline
				while r(eof) == 0 {
					file write `knot' `"`macval(docline)'"' _n
					file read `add' docline
				}
				file close `add'
				cap erase "`display'"
			}
			
			file read `hitch' line	
		}
		
		
	}
	
	file close `knot'
	*copy "`tmp'" "___code.txt", replace
	noisily do "`tmp'"
	
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


