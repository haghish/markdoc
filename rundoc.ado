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
	statax			 /// Activate the syntax highlighter
	TEMPlate(str) 	 /// template docx, CSS, ODT, or LaTeX heading
	TITle(str)   	 /// specifies the title of the document (for styling)
	AUthor(str)  	 /// specifies the author of mthe document (for styling)
	AFFiliation(str) /// specifies author affiliation (for styling)
	ADDress(str) 	 /// specifies author contact information (for styling)
	Date			 /// Add the current date to the document
	SUMmary(str)     /// writing the summary or abstract of the report
	VERsion(str)     /// add version to dynamic help file
	STYle(name)      /// specifies the style of the document
	linesize(numlist max=1 int >=80 <=255) /// line size of the document and translator
	toc				 /// Creates table of content
	NOIsily			 /// Debugging Pandoc, pdfLaTeX, and wkhtmltopdf
	ASCIItable		 /// convert ASCII tables to SMCL in dynamic help files
	NUMbered	 	 /// number Stata commands
	MATHjax 		 /// Interprets mathematics using MathJax
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
	capture noisily do "`input'"
	qui log close rundoc
	
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
	`texmaster'																	///
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
																			
	capture quietly erase "`input'.smcl"

end


// generate dynamic help file
// ==========================

*markdoc rundoc.ado, export(sthlp) replace

