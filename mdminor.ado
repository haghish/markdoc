// documentation is written for markdoc package (github.com/haghish/markdoc) 
// . markdoc mdminor.ado, mini export(sthlp) replace

/***
_v. 1.3_ 

mdminor
======= 

__mdminor__ interprets Markdown syntax and converts it in 
Microrosoft Word's __docx__ format or __pdf__ format

Syntax
------ 

> __mdminor__ _text_ [, _options_]


### Options

| _option_       |  _Description_                                                        |
|:---------------|:----------------------------------------------------------------------|
| export(_str_)  | specifies the file format and can be __docx__ (default) or __pdf__    |
| name(_str_)    | specifies the file name                                               |
| continue       | avoids creating a new file and works on the loaded file in the memory |
| replace        | replaces the existing file                                            |

Examples
--------

create a microsoft word file

        . mdminor "**hello** *world*!", export(docx) name(mydoc) replace

create a pdf file

        . mdminor "**hello** *world*!", export(pdf) name(mydoc) replace

Author
------

E. F. Haghish   
University of Göttingen    
_haghish@med.uni-goesttingen.de_  
[https://github.com/haghish](https://github.com/haghish) 

License
-------

MIT License

- - -

This help file was dynamically produced by 
[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/) 
***/





*cap prog drop mdminor
program define mdminor

	local version = int(`c(stata_version)')
	
	if `version' < 15 {
		display as err "this command is only supported in Stata 15 and above"
		err 1
	}
	if `version' >= 15 {
		local trim ustrltrim
		local version 15
	}
	
	syntax [anything] [, export(str) name(str) continue replace size(numlist max=1) ]
    
	
	version `version'
	
	// ---------------------------------------------------------------------------
	// SYNTAX PROCESSING
	// ---------------------------------------------------------------------------
	if missing("`continue'") & missing("`name'") {
		display as err "file's {bf:name} is not specified"
		err 198
	}
	
	local anything : subinstr local anything "``" "\\||", all
	local anything : subinstr local anything "`" "|\", all
	local anything : subinstr local anything "|\" "`" //fix the first BLOODY occurance 

	
	// specifying the document format
	if missing("`export'") local export docx
	if "`export'" == "docx" | "`export'" == "Docx" | "`export'" == "doc" {
		local command putdocx
	}
	else if "`export'" == "pdf" | "`export'" == "Pdf" | "`export'" == "PDF" {
		local command putpdf
	}
	else {
		display "export(`export') is unrecognized"
		err 198
	}
	
	// creating a new document, if CONTINUE is missing
	// ---------------------------------------------------------------------------
	if missing("`continue'") {
		*cap `command' save mydoc, replace
		`command' begin
		`command' paragraph
	}
	
	local bold    
	local italic
	local font
	local accent
	local linebreak 
	
	tokenize `anything'
	

	// If the first work looks like a numbered or unordered list, add a paragraph!
	local first = substr(`trim'(`"`macval(1)'"'),1,1)
	local ending = substr(`"`macval(anything)'"',-4,2)
	
	capture if `trim'(`"`ending'"') == "" local linebreak 1
	

	if "`first'" == "1" | "`first'" == "2" |  ///
	   "`first'" == "3" | "`first'" == "4" |  ///
	   "`first'" == "5" | "`first'" == "6" |  ///
	   "`first'" == "7" | "`first'" == "8" |  /// 
	   "`first'" == "9"  {
		if substr(`trim'(`"`macval(1)'"'),2,1) == "." | ///
		   substr(`trim'(`"`macval(1)'"'),3,1) == "." | ///
		  substr(`trim'(`"`macval(1)'"'),4,1) == "." |  ///
			substr(`trim'(`"`macval(1)'"'),2,1) == "-" |  ///
			substr(`trim'(`"`macval(1)'"'),3,1) == "-" |  ///
			substr(`trim'(`"`macval(1)'"'),4,1) == "-" {
			`command' text (""), linebreak
			
			//check for indention
			
		}
	}
	if "`first'" == "-" | "`first'" == "+" {
		`command' text (""), linebreak
	}
	
	//If the line begins with * followed by a Space, break the previous paragraph
	//why do I start from the 3rd character? because of the str received from md2doc...
	if substr(`trim'(`"`macval(anything)'"'),3,2) == "* " {
		`command' paragraph 
	}
	
	
	
	while `"`macval(1)'"' != "" {
		
		// check the ending of the style when written with astrix
		// ---------------------------------------------------------------------
		if substr(`"`macval(1)'"',1,3) == "***" {
			local 1 : subinstr local 1 "***" "" 
			local bold "bold"
			local italic "italic"
		}
		else if substr(`"`macval(1)'"',1,2) == "**" {
			local 1 : subinstr local 1 "**" "" 
			local bold "bold"
		}
		else if substr(`"`macval(1)'"',1,1) == "*" {
			local 1 : subinstr local 1 "*" "" 
			local italic "italic"
		}
		
		if substr(`"`macval(1)'"',-3,.) == "***" {
			local 1 : subinstr local 1 "***" "" 
			local endbold 1
			local enditalic 1
		}
		else if substr(`"`macval(1)'"',-2,.) == "**" {
			local 1 : subinstr local 1 "**" "" 
			local endbold 1
		}
		else if substr(`"`macval(1)'"',-1,.) == "*" {
			local 1 : subinstr local 1 "*" "" 
			local enditalic 1
		}
		
		// check the ending of the style when written with underline
		// ---------------------------------------------------------------------
		if substr(`"`macval(1)'"',1,3) == "___" | substr(`"`macval(1)'"',2,4) == "___" {
			local 1 : subinstr local 1 "___" "" 
			local bold "bold"
			local italic "italic"
		}
		else if substr(`"`macval(1)'"',1,2) == "__" | substr(`"`macval(1)'"',2,3) == "__" {
			local 1 : subinstr local 1 "__" "" 
			local bold "bold"
		}
		else if substr(`"`macval(1)'"',1,1) == "_" | substr(`"`macval(1)'"',2,1) == "_" {
			local 1 : subinstr local 1 "_" "" 
			local italic "italic"
		}
		
		// the ending
		if substr(`"`macval(1)'"',-3,.) == "___" | substr(`"`macval(1)'"',-4,3) == "___" {
			local 1 : subinstr local 1 "___" "" 
			local endbold 1
			local enditalic 1
		}
		else if substr(`"`macval(1)'"',-2,.) == "__" | substr(`"`macval(1)'"',-3,2) == "__" {
			local 1 : subinstr local 1 "__" "" 
			local endbold 1
		}
		else if substr(`"`macval(1)'"',-1,.) == "_" | substr(`"`macval(1)'"',-2,1) == "_" {
			local 1 : subinstr local 1 "_" "" 
			local enditalic 1
		}
		
		// check the ending of the style when written with star
		// ---------------------------------------------------------------------
		if substr(`"`macval(1)'"',1,3) == "***" | substr(`"`macval(1)'"',2,4) == "***" {
			local 1 : subinstr local 1 "***" "" 
			local bold "bold"
			local italic "italic"
		}
		else if substr(`"`macval(1)'"',1,2) == "**" | substr(`"`macval(1)'"',2,3) == "**" {
			local 1 : subinstr local 1 "**" "" 
			local bold "bold"
		}
		else if substr(`"`macval(1)'"',1,1) == "*" | substr(`"`macval(1)'"',2,1) == "*" {
			local 1 : subinstr local 1 "*" "" 
			local italic "italic"
		}
		
		// the ending
		if substr(`"`macval(1)'"',-3,.) == "***" | substr(`"`macval(1)'"',-4,3) == "***" {
			local 1 : subinstr local 1 "***" "" 
			local endbold 1
			local enditalic 1
		}
		else if substr(`"`macval(1)'"',-2,.) == "**" | substr(`"`macval(1)'"',-3,2) == "**" {
			local 1 : subinstr local 1 "**" "" 
			local endbold 1
		}
		else if substr(`"`macval(1)'"',-1,.) == "*" | substr(`"`macval(1)'"',-2,1) == "*" {
			local 1 : subinstr local 1 "*" "" 
			local enditalic 1
		}
		
		// monospace fonts
		// -----------------------------------------------------
		else if substr(`"`macval(1)'"',1,2) == "|\" {
			local 1 : subinstr local 1 "|\" "" 
			local font "courier"
		}
		else if substr(`"`macval(1)'"',2,3) == "|\" {
			local 1 : subinstr local 1 "|\" "" 
			local font "courier"
		}
		if substr(`"`macval(1)'"',-2,.) == "|\" {
			local 1 : subinstr local 1 "|\" "" 
			local endmono 1
		}
		else if substr(`"`macval(1)'"',-3,2) == "|\" {
			local 1 : subinstr local 1 "|\" "" 
			local endmono 1
		}
		
		// grave accent
		// -----------------------------------------------------
		else if substr(`"`macval(1)'"',1,4) == "\\||" {
			local 1 : subinstr local 1 "\\||" "" 
			local addaccent 1
		}
		else if substr(`"`macval(1)'"',2,5) == "\\||" {
			local 1 : subinstr local 1 "\\||" "" 
			local addaccent 1
		}
		if substr(`"`macval(1)'"',-4,.) == "\\||" {
			local 1 : subinstr local 1 "\\||" "" 
			local endaccent 1
		}
		else if substr(`"`macval(1)'"',-5,4) == "\\||" {
			local 1 : subinstr local 1 "\\||" "" 
			local endaccent 1
		}
		
		*di as err `"`macval(1)' enditalic:`enditalic'   endbold:`endbold'"' _n
		
		if !missing("`addaccent'") {
			`command' text ("'"), font(`font')
			local addaccent ""
		}
		
		
		`command' text (`"`macval(1)' "'), `bold' `italic' font("`font'", `size')
		
		if !missing("`enditalic'") {
			local italic ""
			local enditalic ""
		}
		if !missing("`endbold'") {
			local bold ""
			local endbold ""
		}
		if !missing("`endmono'") {
			local font ""
			local endmono ""
		}
		if !missing("`endaccent'") {
			`command' text ("'"), font(`font')
			local endaccent ""
		}
		
		macro shift
	}
	
	// Adding line break
	if !missing("`linebreak'") {
		`command' text (""), linebreak
	}
	
	if missing("`continue'") {
		`command' save `name', `replace'
	}
	

end
