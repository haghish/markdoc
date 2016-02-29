/*

					   Developed by E. F. Haghish (2014)
			  Center for Medical Biometry and Medical Informatics
						University of Freiburg, Germany
						
						  haghish@imbi.uni-freiburg.de
						 
						 http://www.haghish.com/markdoc
								   
                       * MarkDoc comes with no warranty *

	
	
	MarkDoc Package
	===============
	
	MarkDoc is a dynmic document/slide/help file/program documentation producer 
	for Stata. MarkDoc can produce "Editable" documents in several formats such 
	as Microsoft Word, Open Office and Office Libre, HTML, PDF, Markdown, txt, 
	and more. It can also produce SMCL and STHLP files by converting Markdown, 
	for program documentation in ado and Mata files. 
	
	Package Content
	---------------
	
	This package includes several files. The current file is the "main" file  
	which defines the syntax of the package and most of the process. The other  
	ado files define additional programs for downloading the required software  
	and running the package. 
	
	Engine
	------
	
	MarkDoc has several interconnected engines for processing SMCL log file or 
	a Stata script file (do, ado, mata). The trick is that after some 
	"corrections and preparations" the file, whether SMCL or a programming file 
	which is also likely to have SMCL markup, should be translated to text. 
	With further work on the text file, the document is prepared in the 
	"Markdown", "HTML", "LaTeX", or "STHLP" format. These formats are processed 
	differently. If the markup language is Markdown, it is passed to Pandoc to 
	handle document conversion. 
	
	http://www.haghish.com/markdoc
	
	You can contribute on https://github.com/haghish/MarkDoc
	
	
	MarkDoc Versions
	----------------
	1.0.0	   July,  2014 
	3.6.7  February,  2016
*/


program markdoc
	
	// -------------------------------------------------------------------------
	// NOTE:
	// Stata 14 introduces ustrltrim() function for removing Unicode whitespace 
	// characters and blanks. The previous trim() function cannot remove unicode 
	// whitespace. The program is updated to function for all versions of Stata, 
	// but yet, there is a slight chance of "unreliable" behavior from MarkDoc 
	// in older versions of Stata, if the string has a unicode whitespace. This 
	// can be fixed by finding a solution to avoid "ustrltrim()". Yet, most of 
	// the torture tests have been positive. 
	// =========================================================================
	local version = int(`c(stata_version)')
	if `version' <= 13 {
		local trim trim
		local version 11
	}
	if `version' > 13 {
		local trim ustrltrim
		local version 14
	}
	version `version'
	
		
	syntax [anything(name=smclfile id="The smcl file name is")]  				/// 
	[, 				 ///
	replace 	 	 /// replaces the exported file
	MARKup(name)  	 /// specifies the markup language used in the document
	Export(name) 	 /// specifies the exported format
	INSTALl 	 	 /// Installs the required software automatically
	Test 		 	 /// tests the required software to make sure they're running correctly 
	PANdoc(str)  	 /// specifies the path to Pandoc software on the machine
	PRINTer(str)     /// the path to the PDF printer on the machine
	NOnumber 	 	 /// avoids command number in the document
	TEXmaster 	 	 /// creates a "Main" LaTeX file which is executable 
	statax			 /// Activate the syntax highlighter
	TEMPlate(str) 	 /// template docx, CSS, ODT, or LaTeX heading
	TITle(str)   	 /// specifies the title of the document (for styling)
	AUthor(str)  	 /// specifies the author of mthe document (for styling)
	AFFiliation(str) /// specifies author affiliation (for styling)
	ADDress(str) 	 /// specifies author contact information (for styling)
	Date			 /// Add the current date to the document
	SUMmary(str)     /// writing the summary or abstract of the report
	STYle(name)      /// specifies the style of the document
	linesize(numlist max=1 int >=80 <=255) /// line size of the document and translator
	MATHjax 		 /// Interprets mathematics using MathJax
	toc				 /// Creates table of content
	verbose			 /// extended logging to console
	///SETpath(str)  /// the path to the PDF printer on the machine
	///Printer(name) /// the printer name (for PDF only) 
	///TABle	     /// changes the formats of the table and creates publication ready tables (UNDER DEVELOPMENT AND UNDOCUMENTED)
	///RUNhead(str)  /// running head for the document (for styling) 
	///PDFlatex(str) ///this command is discontinued in version 3.0 and replaced by setpath()
	///Font(name)	 /// specifies the document font (ONLY HTML)
	]

	
	****************************************************************************
	*Check for Default paths
	****************************************************************************
	capture findfile weave.ado
	if _rc != 0 {
		if !missing("`install'") {
			ssc install weaver
		}
		else {
			capture findfile statax.ado
			if _rc != 0 {
				display as err "Weaver & Statax packages are required: " _n 	///
				"{c 149} {ul:{stata ssc install weaver:ssc install weaver}}" _n ///
				"{c 149} {ul:{stata ssc install statax:ssc install Statax}}"  	///
				_n(2)
				error 601
			}
			
			if _rc == 0 {
				display as err "Weaver package is required: "					///
				"{ul:{stata ssc install weaver:ssc install weaver}}" _n(2)
				error 601
			}
		}	
	}

	capture findfile statax.ado
	if _rc != 0 {
		if !missing("`install'") {
			ssc install statax
		}
		else {
			display as err "Statax package is required: "						///
			"{ul:{stata ssc install statax:ssc install statax}}" _n(2)
			error 601
		}	
	}
	
	capture weaversetup							  //it might not be yet created
	
	****************************************************************************
	*DO NOT PRINT ANYTHING ON THE LOG
	****************************************************************************
	quietly log query    
	if `"`r(filename)'"' != "" {
		if `"`r(status)'"' == "on" {
			local status `"`r(status)'"'		// status of the log
			qui log off
		}	
	}
	
	****************************************************************************
	*DEFAULTS
	****************************************************************************
	//Auto-correcting possible typos
	if "`markup'" == "HTML" local markup html
	if "`markup'" == "LATEX" local markup latex
	if "`markup'" == "Markdown" local markup markdown
	if "`export'" == "PDF" local export pdf
	if "`export'" == "HTML" local export html
	if "`export'" == "LATEX" | "`export'" == "latex" local export tex
	if "`export'" == "SMCL" local export smcl
	if "`export'" == "STHLP" local export sthlp
	
	//Markup Language
	//===============
	
	//check the markup language and the exported document format. If the 
	//format is not specified, alter the default if the "markup" is specified


	
// ??? -------------------------------------------------------------------------	
// PROGRAM IT IN A WAY THAT HTML AND LATEX CAN ALSO BE CONVERTED TO OTHER FORMAT	
	if "`markup'" == "html" {
		if "`export'" != "html" & "`export'" != "pdf" & !missing("`export'") {
			di as err "{p}The {bf:html} markup can only export {bf:html} " ///
		"and {bf:pdf} documents"
		error 100
		}
		if missing("`export'") local export html
	}
	
	if "`markup'" == "latex" {
		if "`export'" != "tex" & "`export'" != "pdf" & !missing("`export'")  {
			di as err "{p}The {bf:latex} markup can only export {bf:tex} " ///
		"and {bf:pdf} documents"
		error 100
		}
		if missing("`export'") local export tex
	}
// -----------------------------------------------------------------------------


	// The printer is used for creating PDF documents in MarkDoc. In general,
	// there are 2 printers available which are "wkhtmltopdf" & "pdflatex."
	// The default is "wkhtmltopdf" 
	if "`export'" == "pdf" &  "`markup'" ~= "latex" {
		global printername "wkhtmltopdf" 		//printer for HTML and Markdown
		
		if missing("`printer'") & !missing("$pathWkhtmltopdf") {
			local printer "$pathWkhtmltopdf"
		}
	}
	
	********************************************************************
	* pdfLaTeX
	*
	* This section does not install pdfLaTeX. But it attempts to find it 
	* on the users' operating system
	********************************************************************
	if "`export'" == "pdf" &  "`markup'" == "latex" & missing("`printer'") 		///
	| "`export'" == "slide"	& missing("`printer'") {
		
		global printername "pdflatex" 			
		
		// look for weaversetup.ado
		if !missing("$pathPdflatex") {
			local printer "$pathPdflatex"
		}
		
		//be nice and search for it on their machines! 
		else {
			
			// WINDOWS 32bit
			// =============
			// ???
			
			// WINDOWS 64bit
			// =============
			if "`c(os)'" == "Windows"  {
		
				cap quietly findfile pdflatex.exe, 								///
				path("C:\Program Files\MiKTeX 2.9\miktex\bin\x64\")
				if "`r(fn)'" ~= "" {
					local printer "C:\Program Files\MiKTeX 2.9\miktex\bin\x64\pdflatex.exe"
				}
			}
			
			// MACINTOSH 
			// =========
			if "`c(os)'" == "MacOSX" {
				cap quietly findfile pdflatex, path("/usr/texbin/")
				if "`r(fn)'" ~= "" {
					local printer "/usr/texbin/pdflatex"
				}
			}
			
			// Unix
			// ====
			// ???
		}
		
		if missing("`printer'") {
			di as txt "{p}(The {bf:printer} option is not defined, but " 		///
			"MarkDoc attempts to access pdfLaTeX automatically)" _n				

			display "(warning! pdfLaTeX not found...)"
			//error 100
	
		}
	}
	
	// STYLE
	// =====
	// MarkDoc applies a number of styles for HTML, PDF, and LaTeX documents
	// The default style is "simple." Below the name of available styles is 
	// specified for each output format. The available styles are "simple"
	// and "stata." The default style is "simple" 
	if "`style'"  == "" local style "simple"
	if "`export'" == "pdf" & "`style'" == "" local style "stata" 
		
	// Line size
	if missing("`linesize'") {
		if "`c(linesize)'" <= "82"  {
			local clinesize "`c(linesize)'"
			qui set linesize 90
		}
	}
	else {
		local clinesize "`c(linesize)'"
		qui set linesize `linesize'
	}
		
	************************************************************************
	*CHECK FOR REQUIRED SOFTWARE
	************************************************************************
	//If PDF format is specified and pdf path is not empty, make sure file exists
	if "`printer'" ~= "" {
		confirm file "`printer'"
	}

	if !missing("`pandoc'") {
		confirm file "`pandoc'"
		global pandoc "`pandoc'"
	}
	
	if missing("`pandoc'") & !missing("$pathPandoc") {
		global pandoc "$pathPandoc" 
	}
	
	*This command is defined in markdockcheck.ado and checkes the required software
	markdoccheck , `install' `test' export(`export') style(`style') 			///
	markup(`markup') pandoc("`pandoc'") printer("`printer'")
		
	************************************************************************
	*TEST MARKDOC
	************************************************************************
	if "`test'" == "test" {
		di _n(2)
		di as txt "{hline}" _n
		di as txt "{p}{ul: {bf:Running Example Do-file}}" _n
		di as txt "{p}Running example.do from " 								///
		`"{browse "http://www.haghish.com/packages/markdoc/example.do":http://www.haghish.com/packages/markdoc/example.do}. "' ///
		"Make sure you are {bf:connected to internet} and you " 				///
		"have permision to write and remove files in the current " 				///
		"working directory. " _n 
				
		do "http://www.haghish.com/packages/markdoc/example.do"
		
		di _n(2)
		di as txt "{hline}" _n
		di as txt "{p}{ul: {bf:Running MarkDoc Test}}" _n
		di as txt "{p}The example do-file is successfully executed. Next, " 								///
		"MarkDoc attempts to compile a HTML and PDF document" _n
		
		markdoc example, export(html) statax linesize(120) replace 				///
		title(Testing MarkDoc Package) author(E. F. Haghish) 					///
		affiliation(Medical Biometry and Medical Informatics, University of Freiburg) ///
		address(haghish@imbi.uni-freiburg.de) style(stata) pandoc("`pandoc'")	///
		printer("`printer'") `verbose'
		
		markdoc example, export(pdf) statax linesize(120) replace 				///
		title(Testing MarkDoc Package) author(E. F. Haghish) 					///
		affiliation(Center for Medical Biometry and Medical Informatics, University of Freiburg) ///
		address(haghish@imbi.uni-freiburg.de) style(stata) pandoc("`pandoc'")	///
		printer("`printer'") `verbose'
		
		
		cap quietly findfile "example.html"
		if "`r(fn)'" != "" {
			cap quietly findfile "example.pdf"
			if "`r(fn)'" != "" {
				display as txt "{p}{bf: MarkDoc works properly. " 				///
				"May The Source Be With You! ;)}" _n
			}
		}
		
		di as txt "{hline}" _n	
	}
					
	************************************************************************
	*SYNTAX PROCESSING
	************************************************************************
		
	// Syntax Highlighter
	// ==================
	if "`export'" != "html" & "`export'" != "pdf" & !missing("`statax'") {
		display as txt "{p}(The {bf:statax} option is only used " 				///
	     "when exporting to {bf:html} format)" _n
		 local statax 							//Erase the macro
	}
	
	// PDF PROCESSING
	// ==============
	// Create a local for processing the PDF. Then change the export to HTML
	// and later, change it to PDF using the "pdfhtml" local
	if "`export'" == "pdf" & "`markup'" ~= "latex" {
		local pdfhtml "pdfhtml" 
		local export "html"
	}
	
	if "`export'" == "pdf" & "`markup'" == "latex" {
		local pdftex "pdftex" 
		tempfile tex2pdf
		//local export "tex"
	}
	
	/*
	if !missing("`pdfhtml'") | !missing("`pdftex'") {
		if !missing("`printer'") {
			display as txt "{p}(The {bf:printer} option is only used " 			///
			"when exporting to {bf:pdf} format)" _n
			//error 198
		}
	}
	*/
				
	//The texmaster option should only be specified when exporting to LaTeX format
	//if "`texmaster'" ~= "" & "`export'" ~= "tex" {
	//	di as err "{p}The {ul:{bf:texmaster}} option should only be " 			///
	//	"specified while exporting to {bf:tex} format. " _n
	//	error 198
	//}
		
	//Styles should be "simple" or "stata"
	if "`style'" ~= "" & "`style'" ~= "stata" & "`style'" ~= "simple" 			///
		& "`style'" ~= "empty" {
		di as err "{p}{bf:style} option not recognized."
		error 198
	}
		
	//If there is NO SMCL FILE and INSTALL or TEST options are not given, 
	//RETURN AN ERROR that the SMCL FILE IS NEEDED
		
	if "`smclfile'" == "" & "`test'" == "" & "`install'" == "" {
		
		di as txt _n(2) "{bf:MarkDoc requires...}" _n(2)						///
		"    smcl log-file to produce a dynamic document or PDF slides" _n		///
		"    {cmd:. markdoc {it:smclname}, [options]}" _n(2)					///
		"    do, ado, or mata file to produce dynamic Stata help files" _n		///
		"    {cmd:. markdoc {it:filename}, export(sthlp)}" _n(2)				///
		"    the {bf:test} option to test the required third-party software" _n	///
		"    {cmd:. markdoc, test}" _n(2)										///
		"see {help MarkDoc} for more details"
		exit 198
	}
					
	//Avoid Syntax Error for TEST and INSTALL options, when there is no
	//SMCL file specified in the command. To do so, only run the engine
	//when the SMCL file is provided and the TEST option is NOT GIVEN. 
	//HOWEVER, IF THE USER WISHES TO RUN MARKDOC AND INSTALL IT AT THE SAME
	//TIME, THERE WOULD BE NO CONFLICT AT ALL.

		
	if "`smclfile'" ~= "" & "`test'" == "" & "`export'" != "sthlp" & 			///
	"`export'" != "smcl" {

		local input `smclfile'	
		
		if (index(lower("`input'"),".smcl")) {
			local input : subinstr local input ".smcl" ""
			if "`export'" == "slide" local convert "`input'.pdf"
			else if "`export'" == "dzslide" local convert "`input'.html"
			else if "`export'" == "slidy" local convert "`input'.html"
			else local convert "`input'.`export'"
			local md  "`input'.md"
			local html "_`input'.html"
			local pdf "`input'.pdf"
			local name "`input'"
			local input  "`input'.smcl"
		}
		else if (index(lower("`input'"),".ado")) {
			local input : subinstr local input ".ado" ""
			if "`export'" == "slide" local convert "`input'.pdf"
			else if "`export'" == "dzslide" local convert "`input'.html"
			else if "`export'" == "slidy" local convert "`input'.html"
			else local convert "`input'.`export'"
			local md  "`input'.md"
			local html "_`input'.html"
			local pdf "`input'.pdf"
			local name "`input'"
			local input  "`input'.ado"
			local scriptfile 1						//define a scriptfile
		}
		else if (index(lower("`input'"),".mata")) {
			local input : subinstr local input ".mata" ""
			if "`export'" == "slide" local convert "`input'.pdf"
			else if "`export'" == "dzslide" local convert "`input'.html"
			else if "`export'" == "slidy" local convert "`input'.html"
			else local convert "`input'.`export'"
			local md  "`input'.md"
			local html "_`input'.html"
			local pdf "`input'.pdf"
			local name "`input'"
			local input  "`input'.mata"
			local scriptfile 1						//define a scriptfile
		}
		else if (index(lower("`input'"),".do")) {
			local input : subinstr local input ".do" ""
			if "`export'" == "slide" local convert "`input'.pdf"
			else if "`export'" == "dzslide" local convert "`input'.html"
			else if "`export'" == "slidy" local convert "`input'.html"
			else local convert "`input'.`export'"
			local md  "`input'.md"
			local html "_`input'.html"
			local pdf "`input'.pdf"
			local name "`input'"
			local input  "`input'.do"
			local scriptfile 1						//define a scriptfile
		}
		else if (!index(lower("`input'"),".smcl")) {
			if "`export'" == "slide" local convert "`input'.pdf"
			else if "`export'" == "dzslide" local convert "`input'.html"
			else if "`export'" == "slidy" local convert "`input'.html"
			else local convert "`input'.`export'"
			local md  "`input'.md"
			local html "_`input'.html"
			local pdf "`input'.pdf"
			local name "`input'"
			local input  "`input'.smcl"
		}
		
		*confirm file "`input'"
		cap confirm file "`input'"
		if _rc != 0 {
			cap confirm file "`smclfile'"
			if _rc != 0 {
				di as err "file `smclfile' not found"
			}
			else di as err "file `smclfile' is not a Stata file (.smcl, .do, " 	///
			".ado, .mata)" 					
			exit 198
		}
		
		*Check if the exported document already exists
		capture quietly findfile "`convert'"
		if "`r(fn)'" ~= "" & "`replace'" == "" {
			di as err "{p}{bf:`convert'} file already exists. " 				///
			"Use the {bf:replace} option to replace the existing file." 					
			exit 198
		}
	
	// -----------------------------------------------------------------------------
	// RUN THE ENGINE FOR LOG FILES
	// =============================================================================
	if missing("`scriptfile'") {
	
		************************************************************************	
		*
		* MAIN ENGINE : Log to Document
		* -----------
		*
		* Part 1- Correcting the SMCL file
		* Part 2- Processing the SMCL file
		* Part 3- Converting the SMCL file
		*	A: Convert to TXT
		*	B: Process the TXT file
		* Part 4- Converting TXT to Markdown / HTML / LaTeX
		* Part 5- Exporting dynamic document
		************************************************************************	
		
		
		************************************************************************
		* PART 1. CORRECTING THE SMCL FILE 
		*		  - Removing indents before special notations
		*		  - Loop correction
		*		  - Changing "." to "{com}."
		************************************************************************
		tempfile tmp //DEFINE tmp FOR THE FIRST TIME
		tempname hitch knot 
		qui file open `hitch' using `"`input'"', read
		qui file open `knot' using `"`tmp'"', write replace
		*file write `knot'  _newline 
		file read `hitch' line
	
		// IF THE DOCUMENT IS IN LATEX MARKUP, BEGIN WITH VERBATUM
		// It is not clear if the user wishes to write his own LaTeX document or 
		// just create a tex file. This requires post processing to erase the 
		// unnecessary \begin{verbatum}
		if "`markup'" == "latex" & "`style'" != "empty" {
			file write `knot' "\begin{verbatim}" _n
		}
					
				
		while r(eof) == 0 {	
			local jump
			local jump2
			
			// -----------------------------------------------------------------
			// Change the accents 
			// ================================================================= 
			local line : subinstr local line "`" "{c 96}", all
			local line : subinstr local line "'" "{c 39}", all
			
			// -----------------------------------------------------------------
			// replacing the "dots" with "{com}. "
			// ================================================================= 
			if substr(`"`macval(line)'"',1,1) == "." & `"`macval(line)'"' > "." {	
				local h : di substr(`"`macval(line)'"',2,.) 
				local line `"{com}. `macval(h)'"'
			}
			
			
			// -----------------------------------------------------------------
			// LOOP CORRECTION 
			// ================================================================= 
			if substr(`"`macval(line)'"',1,5) == "{txt}" & 						///
			substr(`"`macval(line)'"',9,6) == "{com}."  {
				local preline `"`macval(line)'"'
				local preline = substr(`"`macval(preline)'"',15,.)
				
				//remove numbering system
				if !missing("`nonumber'") {
					*local line `"{txt}   {com}. `macval(preline)'"'
					local line = substr(`"`macval(line)'"',9,.)
				}
			
				// Text Interpretation
				// -------------------------------------------------------------
				if substr(trim(`"`macval(preline)'"'),1,4) == "/***"   &		///
				 substr(trim(`"`macval(preline)'"'),1,5)   != "/***/"  &		///
				 substr(trim(`"`macval(preline)'"'),1,5)   != "/****" {
					
					file write `knot' _n 
					file read `hitch' line
			
					while substr(`"`macval(line)'"',1,1) == ">" {
						local preline `"`macval(line)'"'
						local preline : subinstr local preline ">" ""
						local preline = trim(`"`macval(preline)'"')
						file write `knot' `">`macval(preline)'"' _n 
						file read `hitch' line
					}
				  	local jump2 1
					local jump  1
				}
				
				// Special notations
				// -------------------------------------------------------------
				if substr(trim(`"`macval(preline)'"'),1,9) == "qui log c" |		///
				substr(trim(`"`macval(preline)'"'),1,11) == "qui log off" |		///
				substr(trim(`"`macval(preline)'"'),1,10) == "qui log on"  |		///
				substr(trim(`"`macval(preline)'"'),1,11) == "qui markdoc" |		///
				substr(trim(`"`macval(preline)'"'),1,8)  == "markdoc " {
					local jump 1
				}
				
				
				// Hiding comments
				// -------------------------------------------------------------
				if substr(trim(`"`macval(preline)'"'),1,2) == "//" |			///
				substr(trim(`"`macval(preline)'"'),1,1) ==    "*" {				
					local jump 1
				}
			}
			

			// -----------------------------------------------------------------
			// Stata & Mata Correction
			// =================================================================
			if substr(`"`macval(line)'"',1,6) == "{com}." |						///		
			substr(`"`macval(line)'"',1,6) == "{com}:" |						///
			substr(`"`macval(line)'"',1,1) == ":" {		
				local preline `"`macval(line)'"'
				local preline : subinstr local preline "{com}." ""
				local preline : subinstr local preline "{com}:" ""
				if substr(`"`macval(line)'"',1,1) == ":" {
					local preline : subinstr local preline ":" ""
				}	
				
				// Text Interpretation
				// -------------------------------------------------------------
				if substr(trim(`"`macval(preline)'"'),1,4) == "/***"   &		///
				 substr(trim(`"`macval(preline)'"'),1,5)   != "/***/"  &		///
				 substr(trim(`"`macval(preline)'"'),1,5)   != "/****" {
					
					file write `knot' _n 
					file read `hitch' line
			
					while substr(`"`macval(line)'"',1,1) == ">" {
						local preline `"`macval(line)'"'
						local preline : subinstr local preline ">" ""
						local preline = trim(`"`macval(preline)'"')
						file write `knot' `">`macval(preline)'"' _n 
						file read `hitch' line
					}
					local jump2 1
					local jump  1
				}
				
				// Special notations
				// -------------------------------------------------------------
				if substr(trim(`"`macval(preline)'"'),1,5) == "/***/" |			///
				substr(trim(`"`macval(preline)'"'),1,4) ==    "/**/"  |			///
				substr(trim(`"`macval(preline)'"'),1,4) ==    "//ON"  |			///
				substr(trim(`"`macval(preline)'"'),1,5) ==    "//OFF" {		
			
					local preline = trim(`"`macval(preline)'"')
					local line `"{com}. `macval(preline)'"'
				}
				
				if substr(trim(`"`macval(preline)'"'),1,9) == "qui log c" |		///
				substr(trim(`"`macval(preline)'"'),1,11) == "qui log off" |		///
				substr(trim(`"`macval(preline)'"'),1,10) == "qui log on"  |		///
				substr(trim(`"`macval(preline)'"'),1,11) == "qui markdoc" |		///
				substr(trim(`"`macval(preline)'"'),1,8)  == "markdoc " {
					local jump 1
				}
				
				// Hiding comments
				// -------------------------------------------------------------
				if substr(trim(`"`macval(preline)'"'),1,2) == "//" &			///
				substr(trim(`"`macval(preline)'"'),1,5) != "//OFF" &			///
				substr(trim(`"`macval(preline)'"'),1,4) !=  "//ON" {				
					local jump 1
				}
				
				if substr(trim(`"`macval(preline)'"'),1,1) ==    "*" {				
					local jump 1
				}
				
				if substr(trim(`"`macval(preline)'"'),1,2) ==  "/*"    & 		///
				substr(trim(`"`macval(preline)'"'),1,4)    !=  "/**/"  &		///
				substr(trim(`"`macval(preline)'"'),1,5)    !=  "/***/" &		///
				substr(trim(`"`macval(preline)'"'),1,4)    !=  "/***"  |		///
				substr(trim(`"`macval(preline)'"'),1,5)    ==  "/****" {
					local preline = trim(`"`macval(preline)'"')
					local line `"{com}. `macval(preline)'"'
				}
			}
					
			
			if missing("`jump'") {
				file write `knot' `"`macval(line)'"' _n 
			}	
			if missing("`jump2'") {
				file read `hitch' line
			}	
		}
								
		file close `knot'
		*copy "`tmp'" 0process1.smcl	, replace		//For debugging
			
		
		
		********************************************************************
		* PART 2- PROCESSING SMCL: 
		*
		*			1) Add empty line after comments followed by a command
		*			2) Add an empty line if {res} is abruptly follow by {com}
		*			3) Add an empty line after long commands (also in braces)
		*		    4) ADDING AN EMPTY LINE BETWEEN COMMAND AND OUTPUT
		*           5) HIDING COMMANDS/COMMENTS for /**/ & "*" MARKER
		*           6) HIDING OUTPUTS for /***/ MARKER
		* 			7) HIDING //OFF - //ON
		*			8) HIDING //COMMAND - //END
		*			9) HIDING //RESULT - //END
		* 			10) HIDING COMMENTS
		* 			11) MANIPULATE COMMENT MARKERS
		* 			12) REMOVING EMPTY LINES
		*           13) REMOVING txt COMMAND
		*           14) REMOVING img COMMAND
		*           15) REMOVING tble COMMAND
		*           16) REMOVING MATA FUNCTION
		********************************************************************
		tempfile tmp1 							//DEFINE tmp1 FOR THE FIST TIME
		tempname hitch knot 
		qui file open `hitch' using "`tmp'", read
		qui file open `knot' using `"`tmp1'"', write replace
		*file write `knot' _newline 
		file read `hitch' line
		while r(eof) == 0 {	
			
			local jump								// RESET JUMP
			local word1 : word 1 of `"`macval(line)'"'
			local pre1 : word 1 of `"`previousline'"'	//Previous line
			
			********************************************************************
			* 1) add empty line after comments followed by a command
			********************************************************************
			if substr(`"`macval(pre1)'"',1,1) == ">" {
				if substr(`"`macval(word1)'"',1,5) == "{com}" {
					file write `knot' _newline
				}
			}
			
			****************************************************************
			* 2) Add an empty line if {res} is abruptly follow by {com}
			****************************************************************
			if substr(`"`macval(pre1)'"',1,5) == "{res}" {
				if substr(`"`macval(word1)'"',1,5) == "{com}" {
					file write `knot' _newline
				}
			}
			
			****************************************************************
			* 3) Add an empty line after long commands (also in braces)
			****************************************************************
			if substr(`"`macval(pre1)'"',1,7) == "{com}. " |				///
			substr(`"`macval(pre1)'"',9,7) == "{com}. " {
				
				//if "`statax'" == "statax" file write `knot' `"><pre class="sh_stata">"' _n
				//local a : di substr(`"`macval(line)'"',1,7) 
				//local b : di substr(`"`macval(line)'"',8,.) 
				//local a : di ///
				//	`"<pre class="sh_stata">"'`"`macval(a)'"'`".  </span>"'
				//	local line `"`macval(a)'"'`"`macval(b)'"'
					
				if substr(`"`macval(pre1)'"',-4,.) == " ///" | 				///
				substr(`"`macval(pre1)'"',-3,.) == " /*" |						///
				substr(`"`macval(pre1)'"',-3,.) == "/* " {

					*When the /* */ sign is used to move to the next line, avoid
					*the * to be interpreted as a Markdown Italic sign
					while substr(`"`macval(word1)'"',1,1) == ">" & r(eof) == 0 {					
						local line : subinstr local line "*/" "\*/"
						local line : di substr(`"`macval(line)'"',2,.)				
						file write `knot' `"`macval(line)'"' _n
						file read `hitch' line
						local word1 : word 1 of `"`macval(line)'"'
						local next next
					}
					
					if "`next'" == "next" {
						file write `knot' _newline		//Add empty line
					}	
				} 
				
				
				
				****************************************************************
				* 4) ADDING AN EMPTY LINE BETWEEN COMMAND AND OUTPUT
				****************************************************************
				if substr(`"`macval(word1)'"',1,1) == ">" {
					while substr(`"`macval(word1)'"',1,1) == ">" & r(eof) == 0 {
						//di as txt "1 : " `"`macval(line)'"'
						file write `knot' `"`macval(line)'"' _n
						file read `hitch' line							
						local word1 : word 1 of `"`macval(line)'"'
					}
					if `"`macval(line)'"' != "" {
						//if "`statax'" == "statax" file write `knot' `"></pre>"' _n
						file write `knot' _n
					}
					//if `"`macval(line)'"' == "" {
					//	if "`statax'" == "statax" file write `knot' `"></pre>"' _n
					//}
				}
				//else if "`statax'" == "statax" file write `knot' `"></pre>"' _n
			}
			
			
			****************************************************************
			* 5) HIDING "/**/" "*" and "//" Comments
			****************************************************************
			if substr(`"`macval(word1)'"',1,8) == "{com}. *" |  				///
			///& substr(`"`macval(word1)'"',1,9) != "{com}. *:" |				///
			substr(`"`macval(word1)'"',1,9) == "{com}. //" |					///
			substr(`"`macval(word1)'"',1,9) == "{com}: //" |					///
			substr(`"`macval(word1)'"',1,4) == ": //" |							///
			substr(`"`macval(word1)'"',1,11) == "{com}. /**/" {	
			
				if substr(`"`macval(word1)'"',1,12) != "{com}. //OFF" & 		///
				substr(`"`macval(word1)'"',1,11) != "{com}. //ON" {
					//Read the next line! and make sure it does not start with  
					//">" Otherwise read another line
					file read `hitch' line
					local word1 : word 1 of `"`macval(line)'"'
								
					// Repeat this action for consequent lines
					while substr(`"`macval(word1)'"',1,8) == "{com}. *"  		///
					| substr(`"`macval(word1)'"',1,9) == "{com}. //" & 	 		///
						r(eof) == 0												///
					| substr(`"`macval(word1)'"',1,1) == ">" & r(eof) == 0		/// 
					| substr(`"`macval(word1)'"',1,4) == ": //" & r(eof) == 0	///
					| substr(`"`macval(word1)'"',1,11) == "{com}. /**/" &		///
					r(eof) == 0 {
						file read `hitch' line
						local word1 : word 1 of `"`macval(line)'"'
					}
				}	
			}
			
			****************************************************************
			* 6) HIDING /***/ results
			****************************************************************
			// when the command begins with /***/ marker, follow all the output
			// and remove them all until the next command {com.}
			if substr(`"`macval(word1)'"',1,12) == "{com}. /***/"  {
				
				
				// Write it down and read the next line to check if the 
				// command continues to next lines					
				//Read the next line! and make sure it does not start with ">" 
				//Otherwise it means this is the rest of the command
				
				
				// Repeat this action for consequent lines
				while substr(`"`macval(word1)'"',1,12) == "{com}. /***/" 		///
				& r(eof) == 0  {
					
					//di as err "FOUND ONE"
					
					local line : subinstr local line `"{com}. /***/"' "{com}.", all
					//di as err `"`macval(line)'"'
					
					file write `knot' `"`macval(line)'"' _n
					file read `hitch' line
					local word1 : word 1 of `"`macval(line)'"'
						
					//If the command continues, continue writing	
					while substr(`"`macval(word1)'"',1,1) == ">" & r(eof) == 0 {
						file write `knot' `"`macval(line)'"' _n
						file read `hitch' line
						local word1 : word 1 of `"`macval(line)'"'
					}
						
					// REMOVE THE OUTPUT
					// =================
					if substr(`"`macval(word1)'"',1,12) != "{com}. /***/"  {
						while substr(`"`macval(word1)'"',1,6) != "{com}." 		///
						& r(eof) == 0 {
							file read `hitch' line
							local word1 : word 1 of `"`macval(line)'"'
						}	
					}
				}	
			}
				
			****************************************************************
			* 7) HIDING //OFF : Remove anything between //OFF and //ON
			****************************************************************
			if substr(`"`macval(word1)'"',1,12) == "{com}. //OFF"  {	
				
				while substr(`"`macval(word1)'"',1,11) != "{com}. //ON" & 		/// 
				r(eof) == 0 {
					file read `hitch' line
					local word1 : word 1 of `"`macval(line)'"'
				}
					
				// Also remove the //ON
				if substr(`"`macval(word1)'"',1,11) == "{com}. //ON" {
					file write `knot' _n
					file read `hitch' line
					local word1 : word 1 of `"`macval(line)'"'
				}
			}
				
			****************************************************************
			* 8) HIDING //COMMAND : Only keep the commands
			* >>>>>>>>>> UNDER DEVELOPMENT <<<<<<<<<<<
			****************************************************************
			
			****************************************************************
			* 9) HIDING //RESULT : Only keep the output
			* >>>>>>>>>> UNDER DEVELOPMENT <<<<<<<<<<<
			****************************************************************
			
			****************************************************************
			* 10) HIDING COMEMNTS : Remove anything between /* and */
			****************************************************************
				
			while substr(`"`macval(word1)'"',1,9) == "{com}. /*"  & 			///
			substr(`"`macval(word1)'"',1,11) != "{com}. /***"     |				///
			substr(`"`macval(word1)'"',1,12) == "{com}. /****" {	
						
				file read `hitch' line
				local word1 : word 1 of `"`macval(line)'"'
							
				while substr(`"`macval(word1)'"',1,1) == ">" & 				///
				r(eof) == 0 {
					file read `hitch' line
					local word1 : word 1 of `"`macval(line)'"'
				}
			}	
			
			
			
			****************************************************************
			* 11) MANIPULATING COMMENT MARKERS : Changing the comment signs
			****************************************************************

			//Remove "***/"
			//=============
			if substr(`"`macval(line)'"',1,5) == ">***/" {
				local line : subinstr local line ">***/" ""	
			}
			

			
			
			****************************************************************
			* 12) REMOVING EMPTY LINES
			****************************************************************
			// removing the lines that only have "{com}. "
			// NOTE: the "{txt}" can add a line between results and next cmd
			if trim(`"`macval(line)'"') == "{com}." | 							///
			trim(`"`macval(line)'"') == "."	|									///
			trim(`"`macval(line)'"') == "{com}:" |								///
			trim(`"`macval(line)'"') == ": " 									///
			/// | `"`macval(line)'"' == "{txt}" 
			{
				local jump jump
			}
								
			
			****************************************************************
			* 13) REMOVING WEAVER COMMANDS
			*     - txt
			*     - img
			*     - tble 
			****************************************************************
			//If the next line does NOT begin with "{txt}>" read 
			// then read another line. Which means the text was long
			if substr(`"`macval(line)'"',1,6) == "{com}." {
				local ln `"`macval(line)'"'
				local ln : subinstr local ln "{com}." ""
				
				if substr(trim(`"`macval(ln)'"'),1,4) == "txt " {
					local txtcommand found			//FOR POST PROCESSING
					file read `hitch' line							
					local word1 : word 1 of `"`macval(line)'"'
					if substr(`"`macval(word1)'"',1,6) != "{txt}>" {
						while substr(`"`macval(word1)'"',1,6) != "{txt}>" 		///
						& substr(`"`macval(word1)'"',1,4) != ">~~~" & 			///
						r(eof) == 0 {
							file read `hitch' line
							local word1 : word 1 of `"`macval(line)'"'
						}
						file write `knot' _n
					}
				}
				
				if substr(trim(`"`macval(ln)'"'),1,4) == "img "  				///
				|  substr(trim(`"`macval(ln)'"'),1,4) == "img," {
					file read `hitch' line
					while substr(`"`macval(line)'"',1,1) == ">" & r(eof) == 0 &	///
					substr(`"`macval(line)'"',1,3) != ">//" {
						file read `hitch' line							
					}
				}
				
				
				if substr(trim(`"`macval(ln)'"'),1,4) == "tbl "  				///
				|  substr(trim(`"`macval(ln)'"'),1,5) == "tble " {
					file read `hitch' line
					while substr(`"`macval(line)'"',1,1) == ">" & r(eof) == 0 &	///
					substr(`"`macval(line)'"',1,3) != ">//" {
						file read `hitch' line							
					}
				}
			}
			
			
			****************************************************************
			* 16) PRESERVING mata Function
			****************************************************************
			if substr(`"`macval(word1)'"',1,15) == "{com}: function"			///
			| substr(`"`macval(word1)'"',1,10) == ": function"{
				file write `knot' `"`macval(line)'"' _n
				file read `hitch' line										
				
				while substr(`"`macval(line)'"',1,6) != ": end " & 		///
				r(eof) == 0 & `"`macval(line)'"' != ": " & 						///
				`"`macval(line)'"' != "" {	
					if substr(`"`macval(line)'"',1,1) == ">" & ///
					substr(`"`macval(line)'"',1,3) != ">//" {		
						local line : subinstr local line ">" " "
					}
					if substr(`"`macval(line)'"',1,3) == ">//" {
						local line : subinstr local line ">//" "    //"
					}
					file write `knot' `"`macval(line)'"' _n
					file read `hitch' line							
					local word1 : word 1 of `"`macval(line)'"'
				}
			
			
					
				/*
				if "`statax'" == "statax" {
					file write `knot' `"><pre class="sh_stata">"'
					file write `knot' `"`macval(line)'"' _n
					file read `hitch' line							
					local word1 : word 1 of `"`macval(line)'"'				
					while substr(`"`macval(word1)'"',1,6) != ": end " & 		///
					r(eof) == 0 {
						if substr(`"`macval(word1)'"',1,1) == ">" & 			///
						substr(`"`macval(word1)'"',1,3) != ">//" {
							local line : subinstr local line ">" " "
						}
						if substr(`"`macval(word1)'"',1,3) == ">//" {
							local line : subinstr local line ">//" " //"
						}						
						file write `knot' `"`macval(line)'"' _n
						file read `hitch' line							
						local word1 : word 1 of `"`macval(line)'"'
					}
					file write `knot' "></pre>"
				}
				*/
			}
			
			//COPY THE CURRENT LINE. It is used in the next round
			local previousline `"`macval(line)'"' 
				
				
			
			if "`jump'" == "" {	
				file write `knot' `"`macval(line)'"' _n 
			}
			file read `hitch' line
				
		}

		file close `knot'		
		// copy "`tmp1'" 0process2.smcl	, replace			//For debugging
			
		
		
	
		
		
		
		********************************************************************
		*CREATING CODE BLOCK WITH txt [code] COMMAND
		*
		* If the txt [code] command is used consequently, remove empty space
		* between the code lines. This code chunk only gets executed if the 
		* txt command was applied. 
		********************************************************************
		
		if "`txtcommand'" == "found" {
			tempfile tmp
			quietly  copy `"`tmp1'"' `"`tmp'"', replace
			tempfile tmp1
			tempname hitch knot 
			qui file open `hitch' using `"`tmp'"', read
			qui file open `knot' using `"`tmp1'"', write replace
			*file write `knot'  _newline 
			file read `hitch' line
			while r(eof) == 0 {
				if substr(`"`macval(word1)'"',1,4) == ">~~~" {
					local linecopy `"`macval(line)'"'
					file read `hitch' line	
					if `"`macval(line)'"' == "" {
						local linecopy2 `"`macval(line)'"'
						file read `hitch' line
						local word1 : word 1 of `"`macval(line)'"'
						if substr(`"`macval(word1)'"',1,4) == ">~~~" {
							file read `hitch' line							
							local word1 : word 1 of `"`macval(line)'"'
						}
						else file write `knot' `"`macval(linecopy)'"' _n(2) 	
					}
					else file write `knot' `"`macval(linecopy)'"' _n
				}
				file write `knot' `"`macval(line)'"' _n
				file read `hitch' line							
				local word1 : word 1 of `"`macval(line)'"'
			}

			file close `knot'
			file close `hitch'	
			
			//copy "`tmp1'" 0process2B.smcl	, replace
		}
			

			
		********************************************************************
		*PROCESSING SMCL: 1) APPENDING LONG LINES IN COMMANDS AND BRACES
		*                 2) ADDING AN EMPTY LINE BETWEEN COMMAND AND OUTPUT
		*
		*   >>>>>>>>>> UNDER DEVELOPMENT <<<<<<<<<<
		********************************************************************
		

		********************************************************************
		*Statax WEAVER EXPORT: ADD <pre class="sh_stata">
		********************************************************************
		if "`statax'" == "statax" & "`export'" == "html" | 						///
			"`statax'" == "statax" & "`export'" == "pdf" {
			tempfile tmp
			quietly  copy `"`tmp1'"' `"`tmp'"', replace
			tempfile tmp1
			tempname hitch knot 
			qui file open `hitch' using `"`tmp'"', read
			qui file open `knot' using `"`tmp1'"', write replace
			file write `knot'  _newline 
			file read `hitch' line		
			while r(eof) == 0 {
				local word1 : word 1 of `"`macval(line)'"'	
				while substr(`"`macval(word1)'"',1,7) == "{com}. " {
				
					//PROCESS THE PROGRAMS DIFFERENTLY
					//================================
					if substr(`"`macval(word1)'"',1,12) == "{com}. prog " | 	///
					substr(`"`macval(word1)'"',1,13) == "{com}. progr " | 		///
					substr(`"`macval(word1)'"',1,14) == "{com}. progra " | 		///
					substr(`"`macval(word1)'"',1,15) == "{com}. program " | 	///
					{
							
						file write `knot' `"><pre class="sh_stata">  "'
						file write `knot' `"`macval(line)'"' _n
						file read `hitch' line							
						local word1 : word 1 of `"`macval(line)'"'
						while substr(`"`macval(word1)'"',-5,.) ~= ". end" 		///
						& r(eof) == 0 {
								
							//BREAK FOR COMMENTS
							//------------------
							if substr(`"`macval(word1)'"',1,1) == ">" {	
								file write `knot' `"</pre>"' _n
								while substr(`"`macval(word1)'"',1,1) == ">" 	///
								& r(eof) == 0 {
									file write `knot' `"`macval(line)'"' _n
									file read `hitch' line							
									local word1 : word 1 of `"`macval(line)'"'
								}
						
								//Jump the empty lines
								while substr(`"`macval(word1)'"',1,.) == "" 	///
								& r(eof) == 0 {
									file read `hitch' line							
									local word1 : word 1 of `"`macval(line)'"'
								}
						
								file write `knot' `"><pre class="sh_stata">  "' _n
							}	
								
							file write `knot' `"`macval(line)'"' _n
							file read `hitch' line							
							local word1 : word 1 of `"`macval(line)'"'						
						}
							
						if substr(`"`macval(word1)'"',-5,.) == ". end" {
							file write `knot' `"`macval(line)'"' _n
							file read `hitch' line							
							local word1 : word 1 of `"`macval(line)'"'
						}
							
						file write `knot' `"</pre>"' _n
							
						/*
						if substr(`"`macval(word1)'"',1,5) == "{txt}" |	///
						substr(`"`macval(word1)'"',1,7) == "{com}. " {
							file write `knot' _n			// add new line
								
							while substr(`"`macval(word1)'"',1,5) == "{txt}" | ///
							substr(`"`macval(word1)'"',1,7) == "{com}. "	{
								file write `knot' `"`macval(line)'"' _n
								file read `hitch' line							
								local word1 : word 1 of `"`macval(line)'"'
							}
							file write `knot' `"></pre>"' _n
						}
						else file write `knot' `"</pre>"' _n
						*/
					}
						
				
					//PROCESS THE MATA DIFFERENTLY
					//================================
					if substr(`"`macval(word1)'"',1,11) == "{com}. mata" {		
						file write `knot' `"><pre class="sh_stata">  "'
						file write `knot' `"`macval(line)'"' _n
						file read `hitch' line							
						local word1 : word 1 of `"`macval(line)'"'			
						while substr(`"`macval(word1)'"',-12,.) ~= 				///
						"{txt}{hline}" & r(eof) == 0 {
								
							//BREAK FOR COMMENTS
							//------------------
							if substr(`"`macval(word1)'"',1,1) == ">" {	
								file write `knot' `"</pre>"' _n
								while substr(`"`macval(word1)'"',1,1) == ">" 	///
								& r(eof) == 0 {
									file write `knot' `"`macval(line)'"' _n
									file read `hitch' line							
									local word1 : word 1 of `"`macval(line)'"'
								}
									
								//Jump the empty lines
								while substr(`"`macval(word1)'"',1,.) == "" 	///
								& r(eof) == 0 {
									file read `hitch' line							
									local word1 : word 1 of `"`macval(line)'"'
								}		
								file write `knot' `"><pre class="sh_stata">  "' _n
							}
								
								
							//SEPARATE OUTPUT
							//---------------
								
							if substr(`"`macval(word1)'"',1,5) == "{res}" {				
								file write `knot' `"</pre>"' _n		
								file write `knot' `"><pre class="output">  "' _n		
								file write `knot' `"`macval(line)'"' _n
								file read `hitch' line							
								local word1 : word 1 of `"`macval(line)'"'
								while substr(`"`macval(word1)'"',1,6) != 		///
								"{com}:" & r(eof) == 0 {
									file write `knot' `"`macval(line)'"' _n
									file read `hitch' line							
									local word1 : word 1 of `"`macval(line)'"'
								}
								file write `knot' `"</pre>"' _n
								file write `knot' `"><pre class="sh_stata">  "' _n				
							}
								
							file write `knot' `"`macval(line)'"' _n
							file read `hitch' line							
							local word1 : word 1 of `"`macval(line)'"'						
						}
							
						if substr(`"`macval(word1)'"',-12,.) == "{txt}{hline}" {
							file write `knot' `"`macval(line)'"' _n
							file read `hitch' line							
							local word1 : word 1 of `"`macval(line)'"'
						}	
							
						file write `knot' `"</pre>"' _n
					}
						
					// PROCESSING COMMANDS
					// ===================
					if substr(`"`macval(word1)'"',1,7) == "{com}. " & 			///
					substr(`"`macval(word1)'"',1,12) != "{com}. prog " & 		///
					substr(`"`macval(word1)'"',1,13) != "{com}. progr " & 		///
					substr(`"`macval(word1)'"',1,14) != "{com}. progra " & 		///
					substr(`"`macval(word1)'"',1,15) != "{com}. program " & 	///
					{
						file write `knot' `"><pre class="sh_stata">  "'
						file write `knot' `"`macval(line)'"' // don't add new line
						file read `hitch' line							
						local word1 : word 1 of `"`macval(line)'"'
							
						if substr(`"`macval(word1)'"',1,1) == ">" {
							file write `knot' _n			// add new line
							while substr(`"`macval(word1)'"',1,1) == ">" 		///
							& r(eof) == 0 {
								file write `knot' `"`macval(line)'"' _n
								file read `hitch' line							
								local word1 : word 1 of `"`macval(line)'"'
							}
							file write `knot' `"></pre>"' _n
						}
						else file write `knot' `"</pre>"' _n
					}
					 
					//local a : di substr(`"`macval(line)'"',1,7) 
					//local b : di substr(`"`macval(line)'"',8,.) 
					//local a : di ///
					//	`"<pre class="sh_stata">"'`"`macval(a)'"'`".  </span>"'
					//	local line `"`macval(a)'"'`"`macval(b)'"'
				}

				file write `knot' `"`macval(line)'"' _n
				file read `hitch' line		
			}

			file close `knot'
			file close `hitch'
		
			//copy "`tmp1'" 0process5B.smcl	, replace	
		}
			

		********************************************************************
		*TABLE OPTION: CREATING PUBLICATION READY TABLES
		* >>>>>>>>>> UNDER DEVELOPMENT <<<<<<<<<<
		********************************************************************
	}		





		// ---------------------------------------------------------------------
		// THE SCRIPT FILE ENGINE
		// =====================================================================		
		if !missing("`scriptfile'") {	
			tempfile tmp3
			global localfile "`tmp3'"
			markup `smclfile', export("`export'") `replace' localfile("$localfile")
		}	
		

		
		********************************************************************
		*PART 3A- TRANSLATING SMCL TO TXT
		********************************************************************
		tempfile tmp
		
		if  missing("`scriptfile'") {
			quietly  copy `"`tmp1'"' `"`tmp'"', replace
		}	
	
		*Save the current setting of the translator
		qui translator query smcl2txt
		
		*Save the default linesize of the translator
		local savelinesize `r(linesize)'
		local savemargin `r(lmargin)'
		translator set smcl2txt linesize `c(linesize)'
		
		if  missing("`scriptfile'") translator set smcl2txt lmargin 6
		if !missing("`scriptfile'") translator set smcl2txt lmargin 0

		if "`nonumber'" == "nonumber" {
			if "`r(cmdnumber)'" == "on" {
				local savecmdnumber on
				translator set smcl2txt cmdnumber off
			}
		}
				
		if "`r(logo)'" == "on" {
			local savelogo on
			translator set smcl2txt logo off
		}		
	
		*Translating the document to TXT		
		tempfile tmp1
		
		if  missing("`scriptfile'") {
			qui translate "`tmp'" "`tmp1'", trans(smcl2txt) replace
		}	
		if !missing("`scriptfile'") {
			qui translate "$localfile" "`tmp1'", trans(smcl2txt) replace
			capture macro drop localfile
		}	
		
		*reset the users' default setting of the translator
		if "`savecmdnumber'" == "on" translator set smcl2txt cmdnumber on
		if "`savelogo'" == "on" translator set smcl2txt logo on
		
		*RESTORE THE DEFAULT LINESIZE OF THE TRANSLATOR
		translator set smcl2txt linesize `savelinesize'
		translator set smcl2txt lmargin  `savemargin'
		*copy "`tmp1'" 0process7.txt	, replace	 //for debugging
		
		
		********************************************************************
		* PART 3B- PROCESSING TXT
		*
		*	1) removing empty \begin{verbatum}
		*	2) APPENDING LONG LINES IN COMMANDS AND BRACES
		********************************************************************
		tempfile tmp
		quietly  copy `"`tmp1'"' `"`tmp'"', replace
		tempfile tmp1
		tempname hitch knot 
		qui file open `hitch' using `"`tmp'"', read 
		qui cap file open `knot' using "`tmp1'", write replace
		*file write `knot'  _newline
		file read `hitch' line	
		
		//REMOVE THE EMPTY LINES IN THE HEADER
		*while missing(ustrltrim(`"`macval(line)'"')) & r(eof) == 0 {
		while missing(trim(`"`macval(line)'"')) & r(eof) == 0 {
			file read `hitch' line
		}
							
		
		// ---------------------------------------------------------------------
		// 1- Correcting the LaTeX file by removing empty \begin{verbatum}
		// ---------------------------------------------------------------------
		if "`markup'" == "latex" & missing("`scriptfile'") {
		
			while trim(`"`line'"') == "" & r(eof) == 0   {			
				file read `hitch' line	
			}
			
			if trim(`"`macval(line)'"') == "\begin{verbatim}" {
				file read `hitch' line
				while trim(`"`line'"') == "" & r(eof) == 0   {			
					file read `hitch' line	
				}
				if substr(trim(`"`macval(line)'"'),1,2) != ">" {
					file write `knot' "      \begin{verbatim}" _n
				}
			}
		}
		
		//Add the title page in Markdown
		if "`export'" ~= "tex" & "`export'" ~= "pdf" & "`export'" ~= "html" {
			if "`markup'" == "markdown" | "`markup'" == "" {		
				tempfile tmp1
				tempname hitch knot 
				qui file open `hitch' using "`tmp'", read 
				qui cap file open `knot' using "`tmp1'", write replace
				*file write `knot'  _newline
				file read `hitch' line	
				
				//REMOVE THE EMPTY LINES IN THE HEADER
				*while missing(ustrltrim(`"`macval(line)'"')) & r(eof) == 0 {
				while missing(trim(`"`macval(line)'"')) & r(eof) == 0 {
					file read `hitch' line
				}
		
				if "`export'" == "docx" | "`export'" == "odt" {
					file write `knot' 											///
					"---" _n													///
					`"title: "`title'""' _n 									
					
					if "`export'" == "docx" {
						if !missing("`author'") & missing("`affiliation'") {
							file write `knot' `"author: "`author'""' _n
						}
						if missing("`author'") & !missing("`affiliation'") {
							file write `knot' `"author: "`affiliation'""' _n
						}
						if !missing("`author'") & !missing("`affiliation'") {
							file write `knot' `"subtitle: "`author'""' _n  		///
							`"author: "`affiliation'""' _n
						}
						if !missing("`summary'") file write `knot' 				///
						"abstract: `summary'" _n
					}
					
					if "`export'" != "docx" & !missing("`author'") {
						file write `knot'`"author: "`author'""' _n				
					}
					
					if !missing("`date'") file write `knot' 					///
					`"date: "`c(current_date)'""' _n				

					file write `knot' "---" _n 
				}
				
				
				if "`export'" != "docx" & "`export'" != "odt" {
				
					if "`title'" ~= "" file write `knot'  						///
					"  `title'" _n 												///
					"=======" _n(2)

					if "`author'" ~= "" file write `knot'  "`author'   " _n(2) 
					if "`affiliation'" ~= "" file write `knot'  				///
					"`affiliation'    " _n(2) 
					if "`date'" ~= "" file write `knot'  						///
					"`c(current_date)'    " _n(2)  
				}
				
				if "`export'" != "docx" {
					if "`summary'" ~= "" file write `knot'  "`summary'    " _n(2)
				}
				
				if "`address'" ~= "" file write `knot'  "_`address'_    " _n(2) 
			}
		}
		
		while r(eof) == 0 {
			
			// -----------------------------------------------------------------
			// Change back the accents 
			// ================================================================= 
			local line : subinstr local line "{c 96}" "`" , all
			local line : subinstr local line "{c 39}" "'" , all
			
			*local word1 : word 1 of `"`macval(line)'"'
			
			
			// -----------------------------------------------------------------
			// APPENDING COMMAND LINES AND BRACES
			//
			// >>>>>>>>>> UNDER DEVELOPMENT <<<<<<<<<<
			// =================================================================

			// OUTPUTS 
			while substr(`"`macval(line)'"',1,6) == "      " & 				/// 
			substr(`"`macval(line)'"',10,1) ~= "." & 							///
			`"`macval(line)'"' ~= "      " & 									///
			substr(`"`macval(line)'"',1,7) != "      >" {
			
				local host `"`macval(line)'"'
				file read `hitch' line
				
				while substr(`"`macval(line)'"',1,8) == "      > " {
					local line : subinstr local line "      > " "", all
					local host `"`macval(host)'"'`"`macval(line)'"'		
					file read `hitch' line
				}
				capture file write `knot' `"	`macval(host)'"' _n //increase dent
			}
			
			
			if substr(`"`macval(line)'"',1,7) == "      >" {
				local line : subinstr local line "      > " "", all
				local line : subinstr local line "      >" "", all	
			}
				
			if substr(`"`macval(line)'"',1,7) == "      *" {
				local line : subinstr local line "      * " "", all
				local line : subinstr local line "      *" "", all	
			}
						
			if substr(`"`macval(line)'"',1,8) == "       >" {
				local line : subinstr local line "       > " "", all
				local line : subinstr local line "       >" "", all	
			}			
				
			if substr(`"`macval(line)'"',1,8) == "       *" {
				local line : subinstr local line "       * " "", all	
				local line : subinstr local line "       *" "", all	
			}
									
			//TABLES FOR MARKDOWN
			//===================				
			if substr(`"`macval(line)'"',1,8) == "      < " {
				local line : subinstr local line "      < " "", all
			}
			
			if substr(`"`macval(line)'"',1,5) == "     " {
				file write `knot' `"	`macval(line)'"' _n
			}
			else file write `knot' `"`macval(line)'"' _n
			file read `hitch' line
		}
				
		file close `knot'
		file close `hitch'
		*copy "`tmp1'" 0process8.txt	, replace
			
		
		
		
		
		********************************************************************
		* PART 3C- Finalizing LaTeX document
		*
		*	1) auto inserting \begin{verbatum} & \end{verbatum}
		*		- detect whether Verbatum is active
		*		- deactivate and reactivate it when necessary
		********************************************************************
		if "`markup'" == "latex" & "`style'" != "empty" {
			tempfile tmp
			quietly  copy `"`tmp1'"' `"`tmp'"', replace
			tempfile tmp1
			tempname hitch knot 
			qui file open `hitch' using `"`tmp'"', read 
			qui cap file open `knot' using "`tmp1'", write replace
			*file write `knot'  _newline
			file read `hitch' line	
			
			while r(eof) == 0 {
				local verbatim 
				local preline
				
				if trim(`"`macval(line)'"') == "\begin{verbatim}" {
					local v "on"
					local verbatim "Found"						
				}	
				if trim(`"`macval(line)'"') == "\end{verbatim}" local v "off"
				
				
				if "`verbatim'" == "Found" {
					local preline `"`macval(line)'"'
				
					cap file read `hitch' line
					while trim(`"`macval(line)'"') == "" & r(eof) == 0 {				
						file read `hitch' line
					}
					
					//if the file was empty
					if r(eof) != 0 local v "off"
					
					//jump \end{verbatim}
					if trim(`"`macval(line)'"') == "\end{verbatim}" {
						cap file read `hitch' line
						local v "off"
					}
					
					else {
						if substr(`"`macval(line)'"',1,2) == "	"  &			///
						!missing(`"`macval(line)'"') {
							
							// keep the verbatim
							file write `knot' `"`macval(preline)'"' _n
						}
					}
				}
				
				
				if "`v'" == "on" {					
					if substr(`"`macval(line)'"',1,2) != "	"  &				///
					!missing(`"`macval(line)'"') {
						
						if missing("`verbatim'") file write `knot' 				///
						"      \end{verbatim}" _n(2)
						
						local v "off"
					}
				}
				
				if "`v'" == "off" {
					if substr(`"`macval(line)'"',1,2) == "	" & 				///
					trim(`"`macval(line)'"') != "" {
						file write `knot' _n "      \begin{verbatim}" _n
						local v "on"
					}
				}
				
				

				
				
				file write `knot' `"`macval(line)'"' _n
				file read `hitch' line
			}
			
			if "`v'" == "on" {	
				file write `knot' _n "      \end{verbatim}" _n
			}
		
			macro drop v 
			
			file close `knot'
			file close `hitch'
			
		* copy "`tmp1'" 3C.txt	, replace
		}	
		
		

		
	
		
		
			
		********************************************************************
		*PART 4- CREATE MARKDOWN FILE
		********************************************************************	
		tempfile tmp //for further processing
		
		
		if missing("`export'") {
			if "`markup'" == "markdown" | "`markup'" == ""  {
				cap shell "$pandoc" "`tmp1'" -o "`md'"
				quietly  copy `"`md'"' `"`tmp'"', replace
				*copy "`tmp1'" 0process11.md	, replace
			}
		}
		
		if !missing("`export'") {
			qui copy `"`tmp1'"' `"`tmp'"', replace
			qui copy `"`tmp1'"' `"`md'"', replace
			*copy "`tmp1'" 0process11.md	, replace
		}	
					
		if "`markup'" ==  "html"   {
			if "`verbose'" == "verbose" di `"Running "$pandoc" "`tmp1'" -o "`tmp'""'
			cap shell "$pandoc" "`tmp1'" -o "`tmp'"
			quietly  copy `"`tmp'"' `"`convert'"', replace
			//copy "`tmp'" 0troubleshoot.html	, replace
		}		
		
		if "`markup'" == "latex" & "`export'" == "tex" {
			cap quietly copy "`tmp1'" "`convert'", replace
		}
		
		if "`markup'" == "latex" & "`export'" == "pdf" {
			cap quietly copy "`tmp1'" "`tex2pdf'", replace
		}
		
				
		********************************************************************
		*	STYLING THE HTML FILE
		********************************************************************			
		if "`export'" == "html"  {
		
			// The HTML file already has gone through Pandoc 
			//quietly  copy `"`tmp1'"' `"`tmp'"', replace
			tempfile tmp1
			tempname hitch knot 
			qui file open `hitch' using `"`tmp'"', read 
			qui cap file open `knot' using "`tmp1'", write replace

			file write `knot' "<!doctype html>" _n								///
			"<html>" _n															/// 
			"<head>" _n(3) 														
			
			if !missing("`mathjax'") {
				file write `knot' `"<script type="text/javascript" async "' _n 	///
				`"src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?"'		///
				`"config=TeX-MML-AM_CHTML">"' _n								///
				`"</script>"' _n(3)
			}
			
			
			file write `knot' "<!-- SYNTAX HIGHLIGHTING CLASSES  -->" _n(2) 	///
			`"<style type="text/css">"' _n	
			
			
			file write `knot' ".author {display:block;text-align:center;"		///
			"font-size:16px;margin-bottom:3px;}" _newline
			file write `knot' ".date {display:block;text-align:center;"			///
			"font-size:12px;margin-bottom:3px;}" _newline
			file write `knot' ".center, #center {" _newline ///
			_skip(4) "display: block;" _newline ///
			_skip(4) "margin-left: auto;" _newline ///
			_skip(4) "margin-right: auto;" _newline ///
			_skip(4) "-webkit-box-shadow: 0px 0px 2px rgba( 0, 0, 0, 0.5 );" _n ///
			_skip(4) "-moz-box-shadow: 0px 0px 2px rgba( 0, 0, 0, 0.5 );" _n ///
			_skip(4) "box-shadow: 0px 0px 2px rgba( 0, 0, 0, 0.5 );" _n(2) ///
			_skip(4) "padding: 0px;" _newline ///
			_skip(4) "border-width: 0px;" _newline ///
			_skip(4) "border-style: solid;" _newline ///
			_skip(4) "cursor:-webkit-zoom-in;" _newline ///
			_skip(4) "cursor:-moz-zoom-in;" _newline ///
			_skip(4) "}" _newline(2) ///
			"pagebreak {" _newline ///
			_skip(8) "page-break-before: always;" _newline ///
			_skip(8) "}" _newline(2) ///
			".pagebreak, #pagebreak {" _newline ///
			_skip(8) "page-break-before: always;" _newline ///
			_skip(8) "}" _newline(2) 
		
			file write `knot' "td > p {padding:0; margin:0;}" _newline
				
			// TABLES STYLE
			// ============
			file write `knot' _n(4) ///
			"header {" _newline ///
			_skip(8) "font-size:28px;" _newline ///
			_skip(8) "padding-bottom:5px; " _newline ///
			_skip(8) "margin:0;" _newline ///
			_skip(8) "padding-top:150px; " _newline ///
			_skip(8) "font-family: `font';" _newline ///
			_skip(8) "background-color:white; " _newline ///
			_skip(8) "text-align:center;" _newline ///
			_skip(8) "display:block;" _newline ///
			_skip(8) "}" _newline(2) ///
			"table {" _n ///
			_skip(8) "border-collapse: collapse;" _n ///
			_skip(8)"border-bottom:1px solid black;" _n ///
			_skip(8)"padding:5px;" _n ///
			_skip(8)"margin-top:5px;" _n(2) ///
			"}" _n ///
			".tble {" _n ///
			_skip(8)"display:block;" _n ///
			_skip(8)"margin-top: 10px;" _n ///
			_skip(8)"margin-bottom: 0px;" _n ///
			_skip(8)"margin-bottom: 0px;" _n ///
			"}" _n(2) ///
			".tblecenter {" _n ///
			_skip(8)"display:block;" _n ///
			_skip(8)"margin-top: 10px;" _n ///
			_skip(8)"margin-bottom: 0px;" _n ///
			_skip(8)"margin-bottom: 0px;" _n ///
			_skip(8)"text-align:center;" _n ///
			"}" _n(2) ///
			"span.tblecenter + table, span.tble + table, span.tble + img {" _n 	///
			_skip(8)"margin-top: 2px;" _n ///
			"}" _n(2)
		
			
			//Margin left will KEEP the table in the left and won't center it
			/*
			if "`style'" == "" | "`style'" == "simple" {
				file write `knot' "margin-left:0px;" _n
			}
			
			if "`style'" == "stata" {
				file write `knot' "margin-left:0px;" _n
			}
			*/
			
			file write `knot' "th {" _n ///
			"border-bottom:1px solid black;" _n ///
			"border-top:1px solid black;" _n ///
			"padding-right:20px;" _n ///
			"}" _n(2) ///
			"td {" _n ///
			"padding-right:20px;" _n ///
			"}" _n(2)

				file write `knot' "</style>" _n(4)
		
				
		
			// Stata (DEFAULT) STYLE
			//======================	
			if "`style'" == "stata" {
		
				file write `knot' _n(2) "<!-- Stata Style  -->" _newline(2) ///
				`"<style type="text/css">"' _newline ///
				"body {" _newline(2) ///
				_skip(8) "margin:10px 30px 10px 30px;" _newline /// 
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "}" _newline(2) ///
				"@page {" _newline ///
				_skip(8) "size: auto;" _newline ///
				_skip(8) "margin: 10mm 20px 15mm 20px;" _newline ///
				_skip(8) "color:#828282;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				`" @top-left "' ///
				`"{ content: "`runhead'" ; font-size:11px; margin-top:5px; } "' _n /// 
				"@bottom {" _newline ///
				_skip(8) `"content: "Page " counter(page); font-size:14px; "' _n ///
				_skip(8) "}" _newline ///
				_skip(8) "}" _newline(2) ///		
				"@page:first {" _newline ///
				"@top-left {" _newline ///
				_skip(8) "content: normal" _newline ///
				_skip(8) "}" _newline ///
				"@bottom {" _newline ///
				_skip(8) "content: normal" _newline ///
				_skip(8) "}" _newline ///
				_skip(8) "}" _newline(2) ///		
				"header {" _newline ///
				_skip(8) "font-size:28px;" _newline ///
				_skip(8) "padding-bottom:5px; " _newline ///
				_skip(8) "margin:0;" _newline ///
				_skip(8) "padding-top:150px; " _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "background-color:white; " _newline ///
				_skip(8) "text-align:center;" _newline ///
				_skip(8) "display:block;" _newline ///
				_skip(8) "}" _newline(2) ///
				"ul {"	_skip(8) "list-style:circle;" _newline ///
				_skip(8) "margin-top:0;" _newline ///
				_skip(8) "margin-bottom:0;" _newline ///
				_skip(8) "}" _newline(2) ///
				"div ul a {" _newline ///
				_skip(8) "color:black;" _newline ///
				_skip(8) "text-decoration:none;" _newline ///
				_skip(8) "}" _newline(2) ///
				"div ul {" _newline ///
				_skip(8) "list-style: none;" _newline ///
				_skip(8) "margin: 0px 0 10px -15px;" _newline ///
				_skip(8) "padding-left:15px;" _newline ///
				_skip(8) "}" _newline(2) /// 
				"div ul li {" _newline ///
				_skip(8) "font-weight:bold;" _newline ///
				_skip(8) "margin-top:20px;" _newline ///
				_skip(8) "}" _newline(2) ///	
				"div ul li ul li {" _newline ///
				_skip(8) "font-weight: normal;" _newline ///
				_skip(8) "margin-left:20px;" _newline ///
				_skip(8) "margin-top:5px;" _newline ///
				_skip(8) "}" _newline(2) ///
				"div ul li ul li ul li {" _newline ///
				_skip(8) "font-weight: normal;" _newline ///
				_skip(8) "font-style:none;" _newline ///
				_skip(8) "margin-top:5px;" _newline ///
				_skip(8) "}" _newline(2) ///
				"div ul li ul li ul li ul li {" _newline ///
				_skip(8) "font-weight: normal;" _newline ///
				_skip(8) "font-style:italic;" _newline ///
				_skip(8) "margin-top:5px;" _newline ///
				_skip(8) "}" _newline(2) ///		
				"img {" _newline ///
				_skip(8) "margin: 5px 0 5px 0;" _newline ///
				_skip(8) "padding: 0px;" _newline ///
				_skip(8) "cursor:-webkit-zoom-in;" _newline ///
				_skip(8) "cursor:-moz-zoom-in;" _newline ///
				_skip(8) "display:inline-block;" _newline ///
				_skip(8) "text-align: left;" _newline ///
				_skip(8) "clear: both;" _newline ///
				_skip(8) "}" _newline(2) ///		
				"h1, h1 > a, h1 > a:link {" _newline ///
				_skip(8) "margin:24px 0px 2px 0px;" _newline ///
				_skip(8) "padding: 0;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "color:#17365D;" _newline ///
				_skip(8) "font-size: 22px;" _newline ///
				_skip(8) "}" _newline(2) ///
				"h1 > a:hover, h1 > a:hover{" _newline ///
				"color:#345A8A;" _newline ///
				"} " _newline(2) ///
				"h2, h2 > a, h2 > a, h2 > a:link {" _newline ///
				_skip(8) "margin:14px 0px 2px 0px;" _newline ///
				_skip(8) "padding: 0;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "color:#345A8A;" _newline ///
				_skip(8) "font-size: 18px;" _newline ///
				_skip(8) "font-weight:bold;" _newline ///
				_skip(8) "}" _newline(2) ///	
				"h3, h3 > a,h3 > a, h3 > a:link,h3 > a:link {" _newline ///
				_skip(8) "margin:14px 0px 0px 0px;" _newline ///
				_skip(8) "padding: 0;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "color:#4F81BD;" _newline ///
				_skip(8) "font-size: 14px;" _newline ///
				_skip(8) "font-weight:bold;" _newline ///
				_skip(8) "}" _newline(2) ///
				"h4 {" _newline ///
				_skip(8) "margin:10px 0px 0px 0px;" _newline ///
				_skip(8) "padding: 0;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "font-size: 14px;" _newline ///
				_skip(8) "color:#4F81BD;" _newline ///
				_skip(8) "font-weight:bold;" _newline ///
				_skip(8) "font-style:italic;" _newline ///
				_skip(8) "}" _newline(2) ///
				"h5  {" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "font-size: 14px;" _newline ///
				_skip(8) "font-weight:normal;" _newline ///
				_skip(8) "color:#4F81BD;" _newline ///
				_skip(8) "}" _newline(2) ///				
				"h6  {"  _newline ///
				_skip(8) "font-size:14px;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "font-weight:normal;" _newline ///
				_skip(8) "font-style:italic;" _newline ///
				_skip(8) "color:#4F81BD;" _newline ///
				_skip(8) "}" _newline(2) ///
				"p {" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "font-weight:normal;" _newline ///
				_skip(8) "font-size:14px;" _newline ///
				_skip(8) "line-height:14px;" _n ///
				_skip(8) "line-height: 16px;" _newline ///
				_skip(8) "text-align:justify;" _n  ///
				_skip(8) "text-align: left;" _newline ///
				_skip(8) "text-justify:inter-word;" _n ///
				_skip(8) "margin:0 0 14px 0;" _n ///
				_skip(8) "}" _newline(2) ///				
				".code {" _newline ///
				_skip(8) "white-space:pre;" _newline ///
				_skip(8) "color: black;" _newline ///
				_skip(8) "padding:5px;" _n   /// 
				_skip(8) "display:block;" _newline ///
				_skip(8) "font-size:12px;" _newline ///
			    _skip(8) "line-height:14px;" _newline ///
				_skip(8) "background-color:#E1E6F0;" _newline ///
				_skip(8) `"font-family:"Lucida Console", Monaco, monospace, "Courier New", Courier, monospace;"' _newline ///
				_skip(8) "font-weight:normal;" _n  ///
				_skip(8) "text-shadow:#FFF;" _newline ///
				_skip(8) "border:thin;" _newline ///
				_skip(8) "border-color: #345A8A; " _newline ///
				_skip(8) "border-style: solid;" _newline ///
				_skip(8) "unicode-bidi: embed;" _newline ///
				_skip(8) "margin:20px 0 0px 0;" _n   ///
				_skip(8) "}" _newline(2) ///		
				".output {" _newline ///
				_skip(8) "white-space:pre;" _newline ///
				_skip(8) "display:block;" _n  ///
				_skip(8) `"font-family:monospace,"Lucida Console", Monaco, "Courier New", Courier, monospace;"' _newline ///
				_skip(8) "font-size:12px; " _newline ///
				_skip(8) "line-height: 12px;" _newline ///
				_skip(8) "margin:0 0 14px 0;" _n  ///
				_skip(8) "border:thin; " _newline ///
				_skip(8) "unicode-bidi: embed;" _newline ///
				_skip(8) "border-color: #345A8A; " _newline ///
				///_skip(8) "border-style: solid; " _newline ///
				_skip(8) "padding:14px 5px 0 5px;" _n  ///
				///_skip(8) "border-top-style:none;" _newline /// 
				_skip(8) "background-color:transparent;" _n ///
				_skip(8) "}" _newline(2) 
		
				//if "$printername" == "prince" | "$printername" == "princexml" {
				//	file write `knot' "@media print {" _n ///
				//	_skip(8) ".code {line-height:8px;padding:6px;}" _n ///	
				//	_skip(8) "}" _n(2) 	
				//}
				file write `knot' "</style>" _newline(4)	
			}	
				

		if !missing("`statax'") {
			file write `knot' `"<script type="text/javascript" src='http://haghish.com/statax/Statax.js'></script>"' _n
		}
		
		if !missing("`template'") {	
			file write `knot' `"<link rel="stylesheet" type="text/css" href="`template'">"' _n
		}
		
		
		file write `knot' "</head>" _n ///

			*writing the header
			if "`title'" ~= "" {
				file write `knot' `"<header>`title'</header>"' _n
			}
		
			file write `knot' "<body>" _n 
				
			if "`author'" ~= "" {
				file write `knot' `"<span class="author">`author'</span>"' _n
			}		
				
			if "`affiliation'" ~= "" {
				file write `knot' `"<span class="author">`affiliation'</span>"' _n
			}
		
			if "`address'" ~= "" {
				file write `knot' `"<span class="author">`address'</span>"' _n
			}	
				
			if "`date'" ~= "" {
				file write `knot' `"<span class="date">`c(current_date)'</span>"' _n
			}	
				
			if "`summary'" ~= "" {
				file write `knot' 												///
				`"<p style="padding-right:15%; "' 								///
				`"padding-left:15%;padding-top:100px;"'							///
				`"text-align: justify;text-justify:"'							///
				`"inter-word;">`summary'</p><br />"' _n
			}	
				
			/* adding the date in the fitst page */
			//if "`date'" == "date" {
			//		file write `knot' ///
			//		`"<span style="font-size: 12px;text-align:center;"' ///
			//		`"display:block; padding: 0 0 30px 0;">"' ///
			//		`"<span id="spanDate"></span></span>"' _n(2)
			//		}
				
				
			
			//Copy the rest of the document
			
			file write `knot'  _newline
			file read `hitch' line	
				
			while r(eof) == 0 {
					
				local word1 : word 1 of `"`macval(line)'"'
					
				// replace <pre><code>
				//local line : subinstr local line "<pre><code>" "<result>", all
				//local line : subinstr local line "</pre></code>" "</result>", all
					
				file write `knot' `"`macval(line)'"' _n  
				file read `hitch' line
			}
					
					
							
			file write `knot' "</body>" _n 
			file write `knot' "</html>" _n
				
			file close `knot'
			file close `hitch'
			*cap quietly copy "`tmp1'" "analysis.txt", replace			
		
	}
			
			
		********************************************************************
		*	REPLACE THE HTML FILE
		********************************************************************	
		if "`export'" == "html" & "`style'" ~= "" {
			if "`markup'" == "markdown" | "`markup'" == ""  {
				quietly  copy `"`tmp1'"' `"`md'"', replace
							
				// If the export was "pdf", then copy the file to "`html'"
				if "`pdfhtml'" == "pdfhtml" {
					tempfile out
					tempfile in
					quietly copy "`md'" "`in'"
					if "`verbose'" == "verbose" di `"Running "$pandoc" "`in'" -o "`out'""'
					shell "$pandoc" "`in'" -o "`out'"
					quietly  copy "`out'" `"`html'"', replace
					quietly  copy "`out'" `"`convert'"', replace
					//copy "`convert'" "0pdfhtml.html", replace
				}
			}
					
			if "`markup'" ==  "html"   {
				quietly  copy `"`tmp1'"' `"`convert'"', replace
				
				// If the export was "pdf", then copy the file to "`html'"
				if "`pdfhtml'" == "pdfhtml" {
					quietly  copy `"`tmp1'"' `"`html'"', replace
				}	
			}	
		}
			

		
		
		
		********************************************************************
		*EXPORT MARKDOWN FILE TO OTHER FORMATS
		********************************************************************
		if "`export'" ~= "" {
			
			// DEFINE LATEX ENGINE PATH
			// ------------------------
			if !missing("`printer'") {
				local latexEngine --latex-engine="`printer'"
			}
					
			// PDF Processing
			// ==============
			// for PDF processing, we changed the content of "`export'" 
			// macro from "pdf" to "html" and now that the HTML process
			// is done, it is time to turn it back to HTML. 
			if "`pdfhtml'" == "pdfhtml" {
				
				if !missing("`toc'") {
					local toc  toc  --page-offset 0 --toc-text-size-shrink 1.0	
				}
				
				local export "pdf"
				local convert "`pdf'" 
							
				****************************************************
				* Print the HTML file to pdf
				****************************************************
							
				// MICROSOFT WINDOWS PDF PRINTER DEFAULT PATHS 
				// ===========================================
				if "`c(os)'"=="Windows" {
	
					// wkhtmltopdf
					if "$printername" == "wkhtmltopdf" | "$printername" == "" {
						
						
						// Use temporary files to prevent problems with UNC directories on
						// Windows
						// (See: https://support.microsoft.com/en-us/kb/156276)
						
						tempfile in
						tempfile out
						// The in file needs to have .html suffix. Erase any existing temp file
						cap erase "`in'.html"
						quietly copy "`html'" "`in'.html"

						if "`verbose'" == "verbose" di `"Running "$setpath" --footer-center [page] --footer-font-size 10 --margin-right 30mm --margin-left 30mm --margin-top 35mm --no-stop-slow-scripts --javascript-delay 1000 --enable-javascript `toc' --debug-javascript "`in'" "`out'"'
	
						shell "$setpath" 										///
						--footer-center [page] --footer-font-size 10 			///
						--margin-right 30mm 									///
						--margin-left 30mm 										///
						--margin-top 35mm										///
						--no-stop-slow-scripts --javascript-delay 1000 			///
						--enable-javascript  									///
						`toc'													///
						--debug-javascript 										///
						"`in'.html" "`out'"
						
						quietly erase "`in'.html"
						quietly copy "`out'" "`convert'", replace
					}		
				}	
							
				// MACINTOSH PDF PRINTER DEFAULT PATHS
				// ===================================
				if "`c(os)'" == "MacOSX" {

					// wkhtmltopdf
					if "$printername" == "wkhtmltopdf" | "$printername" == "" {
					
						if "`verbose'" == "verbose" di `"Running "$setpath" --footer-center [page] --footer-font-size 10 --margin-right 30mm --margin-left 30mm --margin-top 35mm --no-stop-slow-scripts --javascript-delay 1000 --enable-javascript `toc' --debug-javascript  "`html'" "`convert'""'
					
						shell "$setpath" 										///
						--footer-center [page] --footer-font-size 10 			///
						--margin-right 30mm 									///
						--margin-left 30mm 										///
						--margin-top 35mm										///
						--no-stop-slow-scripts --javascript-delay 1000 			///
						--enable-javascript  									///
						`toc'													///
						--debug-javascript 										///
						"`html'" "`convert'"
					}				
				}
							
							
				// UNIX PDF PRINTER DEFAULT PATHS
				// ==============================
				if "`c(os)'"=="Unix" {
							
					// wkhtmltopdf
					if "$printername" == "wkhtmltopdf" | "$printername" == "" {
					
						if "`verbose'" == "verbose" di `"Running "$setpath"  --footer-center [page] --footer-font-size 10 --margin-right 30mm --margin-left 30mm --margin-top 35mm --no-stop-slow-scripts --javascript-delay 1000 --enable-javascript `toc' --debug-javascript "`html'" "`convert'""'
						
						shell "$setpath" 										///
						--footer-center [page] --footer-font-size 10 			///
						--margin-right 30mm 									///
						--margin-left 30mm 										///
						--margin-top 35mm										///
						--no-stop-slow-scripts --javascript-delay 1000 			///
						--enable-javascript  									///
						`toc'													///
						--debug-javascript 										///
						"`html'" "`convert'"					
					}	
				}				
			}	
			
			****************************************************
			* DEALING WITH THE CONVERT FILE
			****************************************************
		
			//di _n(2)
			if "`markup'" == "markdown" & "`pdfhtml'" == "" | 					///
			"`markup'" == "" & "`pdfhtml'" == "" {
				
				if !missing("`toc'") local toc "--toc"
				
				if !missing("`template'") {
					if "`export'" == "docx" local reference -S --reference-docx=`template'
					if "`export'" == "odt"  local reference -S --reference-odt==`template'
					if "`export'" == "epub" local reference -S --epub-stylesheet==`template'
				}
				
				if missing("`template'") & "`export'" == "docx" {
					if "`style'" == "stata" {
						capture findfile markdoc_stata.docx
					}	
					if "`style'" == "simple" {
						capture findfile markdoc_simple.docx
					}
					
					if !missing("`r(fn)'") {
						local d : pwd
						cap qui cd "`c(sysdir_plus)'/m"
						local tempPath : pwd
						local template "`tempPath'/markdoc_`style'.docx"					
						cap qui cd "`d'"
						if "`c(os)'" == "Windows" {
							local template : subinstr local template "/" "\", all
						}
						local reference -S --reference-docx="`template'"
					}		
				}
				
				if "`export'" == "slide" {
					
					// LaTeX Beamer Default
					if missing("`template'") {
						tempfile template
						tempname knot 
						qui cap file open `knot' using "`template'", write replace
						file write `knot' "\makeatletter" _n
						file write `knot' "\def\verbatim@font{\ttfamily\tiny}" _n
						file write `knot' "\makeatother" _n
						file close `knot'
					}

					// Use temporary files to prevent problems with UNC directories on
					// Windows
					// (See: https://support.microsoft.com/en-us/kb/156276)
						
					tempfile in
					tempfile out
					quietly copy "`md'" "`in'"
			
					if "`verbose'" == "verbose" di `"Running "$pandoc" `toc' -t beamer "`in'" `latexEngine' --include-in-header="`template'" -o "`out'""'

					shell "$pandoc" `toc' -t beamer "`in'" `latexEngine' 		///
					--include-in-header="`template'" -o "`out'"

					quietly copy "`out'" "`convert'", replace
				
					*shell "$pandoc" -t beamer "`md'" -V theme:Boadilla -V 		///
					*colortheme:lily `fontsize' -o "`convert'"		
				}				
				else {

					local mathjax --mathjax
					
					if "`export'" == "dzslide" local mathjax -s --mathjax -i -t dzslides
					if "`export'" == "slidy" local mathjax -s --mathjax -i -t slidy

					tempfile in
					tempfile out
					quietly copy "`md'" "`in'"

					if "`verbose'" == "verbose" di `"Running "$pandoc" `mathjax' `toc' `reference' "`in'" -o "`out'""'

					shell "$pandoc" `mathjax' `toc' 		///
					`reference' "`in'" -o "`out'"		
					
					
					quietly copy "`out'" "`convert'", replace

				}	
			}
			
			
			****************************************************
			*CREATING THE TEXMASTER FILR
			****************************************************
			//When exporting to LaTeX, the document is not ready 
			//	to be compiled by LaTeX compilers because it 
			//	only includes tex and markup and the required  
			//	packages and document details are not specified. 
			//	This option adds these formatting commands to 
			//  make the document runable. I already have 
			//  checked that texmaster should be used with "tex"
			
			
			if !missing("`texmaster'") | missing("`texmaster'") & 				///
			!missing("`template'") & "`markup'" == "latex" 						///
			& "`export'" != "slide" {
				tempfile tmp
				tempfile tmp1
					
				if missing("`tex2pdf'") quietly copy "`convert'" `"`tmp'"', replace
				else quietly copy "`tex2pdf'" `"`tmp'"', replace
				qui cap erase "`convert'"
					
				tempname hitch knot 
				qui file open `hitch' using "`tmp'", read 
				qui cap file open `knot' using "`tmp1'", write replace
				file write `knot'  _newline
				file read `hitch' line	
					
				**************
				* SIMPLE STYLE
				**************			
				if !missing("`texmaster'") & "`style'" == "simple" {
					file write `knot' 											///
					"\documentclass{article}" _n								///
					"\usepackage{geometry} " _n									///
					"\usepackage{booktabs}         %for tables" _n				///
					"%\geometry{letterpaper} " _n								///
					"\usepackage{graphicx}" _n									///
					"\usepackage{amssymb}" _n									///
					"\usepackage{hyperref}         %use hyperlink" _n			///
					"\usepackage{epstopdf}" _n 									///
					"\DeclareGraphicsRule{.tif}{png}{.png}"						///
					"{`convert #1 `dirname #1`/`basename #1 .tif`.png}" _n		///		
					"\makeatletter" _n											///
					"\def\verbatim@font{\ttfamily\scriptsize}" _n				///
					"\makeatother" _n									
					
					// Append external template file
					if !missing("`template'") {
						confirm file "`template'"
						tempname latexstyle
						file open `latexstyle' using "`template'", read
						file read `latexstyle' line
						while r(eof)==0 & substr(trim(`"`macval(line)'"'),1,16) != 	///
						"\begin{document}"{
							cap file write `knot' `"`macval(line)'"' _n
							cap file read `latexstyle' line
						}
						file close `latexstyle'
					}	
					
					file write `knot' "\begin{document}" _n
					
					if !missing("`toc'") {
						file write  `knot' "\clearpage" _n						///
						"\tableofcontents" _n									///
						"\clearpage" _n(2)		
					}
				
					if "`title'" != "" | !missing("`author'") {
						file write `knot' "\title{`title'}" _n
					}
					
					if "`author'" != "" | "`affiliation'" 						///
					!= "" |  "`address'" != "" {
							
						file write `knot' "\author{"
						if "`author'" != "" {
							file write `knot' "`author' " 
						}	
						if "`affiliation'" != "" {
							file write `knot' "\\ \small{`affiliation'} " 
						}
						if "`address'" != "" {
							file write `knot' "\\ \small{\textit{`address'}} " 
						}				
						file write `knot' "} " _n		
					}	
									
					if "`title'" != "" | "`author'" != "" {
						if "`title'" == "" local title "\hphantom"
						file write `knot' "\maketitle" _n	
					}	
						
					if "`summary'" ~= "" {
						file write `knot' "\begin{abstract}" _n
						file write `knot' "`summary'" _n
						file write `knot' "\end{abstract}" _n(2)
					}					
					file write `knot' "" _n
					file write `knot' "" _n				
				}
								
				*************
				* STATA STYLE
				*************
				if !missing("`texmaster'") & "`style'" == "stata" {
					//change style for affiliation and address
					if "`affiliation'" ~= "" local affiliation "\\\`affiliation'" //one additional "\" 
					if "`address'"     ~= "" local address "\\\`address'"
					if "`date'" ~= "" local date "\\\`c(current_date)'"
						
					file write `knot' 											///
					"\documentclass{article}" _n								///
					"\usepackage[article,notstatapress]{sj}" _n					///
					"\usepackage{epsfig}" _n									///
					"\usepackage{stata}" _n										///
					"\usepackage{booktabs}         %for tables" _n				///
					"\usepackage{hyperref}         %use hyperlink" _n 			///
					"\usepackage{shadow}" _n									///
					"\usepackage{natbib}" _n									///
					"\usepackage{chapterbib}" _n								///
					"\bibpunct{(}{)}{;}{a}{}{,}" _n(2)
					
					// Append external template file
					if !missing("`template'") {
						confirm file "`template'"
						tempname latexstyle
						file open `latexstyle' using "`template'", read
						file read `latexstyle' line
						while r(eof)==0 & substr(trim(`"`macval(line)'"'),1,16) != 	///
						"\begin{document}"{
							cap file write `knot' `"`macval(line)'"' _n
							cap file read `latexstyle' line
						}
						file close `latexstyle'
					}	
					
					file write `knot' "\begin{document}" _n
					if !missing("`toc'") {
						file write  `knot' "\clearpage" _n						///
						"\tableofcontents" _n									///
						"\clearpage" _n(2)		
					}
					file write `knot' "\inserttype[st0001]{article}" _n
					file write `knot' "\author{Short article author list}{`author' `affiliation' `address' `date' \and}" _n
					file write `knot' "\title[Short toc article title]{`title'}" _n
					//if "`date'" ~= "" file write `knot' "\date{\today}" _n
					file write `knot' "\maketitle" _n(2)
						
					if "`summary'" ~= "" {
						file write `knot' "\begin{abstract}" _n					///
						"`summary'" _n											///
						"%\keywords{\inserttag, command name(s), "				///
						"keyword(s)} %Add keywords" _n							///
						"\end{abstract}" _n(2)
					}
				}
								
				
				// Append external template file
				if missing("`texmaster'") & !missing("`template'") {
					confirm file "`template'"
					tempname latexstyle
					file open `latexstyle' using "`template'", read
					file read `latexstyle' line
					while r(eof)==0 & substr(trim(`"`macval(line)'"'),1,16) != 	///
					"\begin{document}"{
						cap file write `knot' `"`macval(line)'"' _n
						cap file read `latexstyle' line
					}
					file close `latexstyle'
				}
				
				// -------------------------------------------------------------
				// CORRECT STATA STYLE by replacing stlog instead of verbatim
				// =============================================================
				while r(eof) == 0 {
					if "`style'" == "stata" {
						if substr(trim(`"`macval(line)'"'),1,16) == 			///
						"\begin{verbatim}" {
							local line : subinstr local line 					///
							"\begin{verbatim}" "\begin{stlog}"
						}
						if substr(trim(`"`macval(line)'"'),1,14) == 			///
						"\end{verbatim}" {
							local line : subinstr local line 					///
							"\end{verbatim}" "\end{stlog}"
						}
					}
					file write `knot' `"`macval(line)'"' _n  
					file read `hitch' line
				}
								
				//END THE DOCUMENT
				if !missing("`texmaster'") & "`style'" == "stata" {
					file write `knot' "\bibliographystyle{sj}" _n				///
					"\bibliography{sj}" _n										///
					"%\begin{aboutauthors}" _n									///
					"%% Write some background "									///
					"information about the author(s)." _n						///
					"%\end{aboutauthors}" _n
				}	
					
					
				file write `knot'  _n "\end{document}" _n(4)				
				file close `hitch'
				file close `knot'
				
				
				
				
				
					
				//REPLACE THE FILE
				if missing("`tex2pdf'") quietly copy `"`tmp1'"' "`convert'", replace
				else quietly copy `"`tmp1'"' "`tex2pdf'", replace	
			}
				
			****************************************************
			*CREATING THE PDF FROM TEX
			****************************************************	
			
			if !missing("`pdftex'") & "`export'" != "slide" {
				if "`printer'" != "" {
					if "`verbose'" == "verbose" di `"Running "`printer'" -jobname "`name'" "`tex2pdf'""'
					capture shell "`printer'" -jobname "`name'" "`tex2pdf'" 
				}
				else {
					if "`verbose'" == "verbose" di `"Running "$printername" -jobname "`name'" "`tex2pdf'""'
					shell "$printername" -jobname "`name'" "`tex2pdf'"	
				}
			}
			
			
			****************************************************
			*PRINTING THE OUTPUT NOTIFICATION
			****************************************************
			cap confirm file "`convert'"
			
			if ! _rc {
				di as txt "{p}(MarkDoc created "`"{bf:{browse "`convert'"}})"' _n
				if "`export'" ~= "md" cap qui erase "`md'"
			}
			else display as err "MarkDoc could not produce `convert'" _n
		}
		
		if "`export'" == "" {

			cap confirm file "`md'"
			if ! _rc {
				//di _n(2)
				//di as txt "   __  __            _    ____             " 
				//di as txt "  |  \/  | __ _ _ __| | _|  _ \  ___   ___ " 
				//di as txt "  | |\/| |/ _' | '__| |/ / | | |/ _ \ / __|" 
				//di as txt "  | |  | | (_| | |  |   <| |_| | (_) | (__ " 
				//di as txt "  |_|  |_|\__,_|_|  |_|\_\____/ \___/ \___| "		///
				//`"created  {bf:{browse "`md'"}} "' _n
				di as txt "{p}(MarkDoc created "`"{bf:{browse "`md'"}})"' _n
			}
		
			*IF THERE WAS NO PANDOC AND NO MARKDOWN FILE...
			else di as err "MarkDoc could not access Pandoc..." _n		
		}
			
		*change the md files to markdown
		if "`export'" == "md" local export markdown
		
		// INSTALLING LATEX STYLES
		// =======================
		
		// When exporting to LaTeX, if "stata" style is specified, MarkDoc 
		// copies Statapress files to the working directory to allow executing
		// the LaTeX files. 
		
		if "`export'" == "tex" & "`style'" == "stata" {
			
			// SEARCHING FOR LATEX STYLE DIFFERS BASED ON OS 
			
			if "`c(os)'" != "Windows" cap quietly findfile supplementary, 		///
			path("`c(sysdir_plus)'Weaver")
			
			if "`c(os)'" == "Windows" cap quietly findfile sj.sty, 				///
			path("`c(sysdir_plus)'Weaver\supplementary\stata")
				
			if "`r(fn)'" ~= "" {
						
				// Create a list of files that should be copied 	
				local listname doit.bat doit.sh pagedims.sty sj.bib 			///
				sj.bst sj.sty sj.version stata.sty statapress.cls 				///
				tl.eps tl.pdf tr.eps tr.pdf

				foreach lname in `listname' {
					cap qui findfile `lname'
					if "`r(fn)'" == "" {			
						cap qui copy "`c(sysdir_plus)'Weaver/supplementary/stata/`lname'" ///
						"`lname'", replace					
					}
				}
			}
		}
		
		//erase the temporary HTML when exporting pdf
		if "`pdfhtml'" == "pdfhtml" {
			cap quietly erase `"`html'"' 
		}	
		
		macro drop pandoc
		macro drop setpath 							//Path of the pdf printer
		macro drop printername
		macro drop printerpath

		if !missing("`clinesize'") {
			qui set linesize `clinesize'
		}
	}
	
	if "`smclfile'" ~= "" & "`test'" == "" & "`export'" == "sthlp" | 			///
	"`smclfile'" ~= "" & "`test'" == "" & "`export'" == "smcl" {
		
		sthlp `smclfile', export("`export'") template("`template'")				///
		`replace' `date' title("`title'") summary("`summary'") 					///
		author("`author'") affiliation("`affiliation'") address("`address'")  
	}	
	
	
	// Drop the global macros
	// -------------------------------------------------------------------------
	// this kills the live-preview. NOT A GOOD IDEA
	// if missing("$weaver") macro drop currentFigure
	
	// check for MarkDoc updates
	markdocversion
	
	
	****************************************************************************
	*REOPEN THE LOG
	****************************************************************************
	quietly log query    
	if !missing("`status'")  {
		qui log on	
	}
		
end

