/*** DO NOT EDIT THIS LINE -----------------------------------------------------
Version: 1.0.0
Title: rundoc
Description: executes a _do-file_ and exports a dynamic document in any format 
supported by __{help markdoc}__ 
----------------------------------------------------- DO NOT EDIT THIS LINE ***/

/***
Syntax
======

produce dynamic {it:document} or {it:presentation slides} from a do-file. If 
filename is specified without an extension, .do is assumed. 

{p 8 16 2}
{cmd: rundoc} {help filename} [{cmd:,} 
{opt pan:doc(str)} {opt print:er(str)} {opt instal:l} {opt replace} 
{opt e:xport(name)} {opt mark:up(name)} {opt num:bered} {opt sty:le(name)} 
{opt template(str)} {opt toc}
{opt linesize(int)} {opt tit:le(str)} {opt au:thor(str)} {opt aff:iliation(str)} {opt add:ress(str)} 
{opt sum:mary(str)} {opt d:ate} {opt tex:master} {opt statax} {opt noi:sily}
{* *! {opt ascii:table}}
]
{p_end}

Description
===========

__rundoc__ executes a dynamic document from a do-file. In contrast to __{help markdoc}__ 
that requires smcl file for generating a dynamic document or presentation slides, 
__rundoc__ does not require you to create a __smcl__ log file and takes the 
do-file as the source and can export a document to all of the document formats 
supported by {help markdoc} which are __pdf__, __docx__, __odt__, __html__, 
__latex__, __slides__, etc.

Options
=======

__rundoc__ takes the same options as {help markdoc}. The only difference is that 
the __export()__ option does not accept __sthlp__ or __smcl__ which are used for 
creating dynamic Stata help files in {help markdoc} package. 

Author
======

__E. F. Haghish__     
Center for Medical Biometry and Medical Informatics     
University of Freiburg, Germany     
_and_        
Department of Mathematics and Computer Science       
University of Southern Denmark     
haghish@imbi.uni-freiburg.de     
      
[MarkDoc Homepage](www.haghish.com/markdoc)         
Package Updates on [Twitter](http://www.twitter.com/Haghish)     

- - -

_This help file was dynamically produced by[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/)_ 
***/




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
	///SETpath(str)  /// the path to the PDF printer on the machine
	///Printer(name) /// the printer name (for PDF only) 
	///TABle	     /// changes the formats of the table and creates publication ready tables (UNDER DEVELOPMENT AND UNDOCUMENTED)
	///RUNhead(str)  /// running head for the document (for styling) 
	///PDFlatex(str) ///this command is discontinued in version 3.0 and replaced by setpath()
	///Font(name)	 /// specifies the document font (ONLY HTML)
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
	`mathjax'																	
																			
	capture quietly erase "`input'.smcl"

end


// generate dynamic help file
// ==========================

*markdoc rundoc.ado, export(sthlp) replace

