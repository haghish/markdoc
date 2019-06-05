// documentation is written for markdoc package (github.com/haghish/markdoc) 
// . markdoc mdconvert.ado, mini export(sthlp) replace

/***
_v. 1.3_ 

mdconvert
=========

__mdconvert__ converts [Markdown](https://daringfireball.net/projects/markdown/) to
Microsoft Word __docx__ or __pdf__ within Stata

Syntax
------ 

> __mdconvert__ using _filename_ [, _options_]

### Options

| _option_             |  _Description_                                     | 
|:---------------------|:---------------------------------------------------| 
| **rep**lace          | names of the exported file                         | 
| name                 | bold face text                                     | 
| **e**xport(name)     | document format which can be __docx__ or __pdf__   | 
| **t**itle(str)       | title of the document                              | 
| **au**thor(str)      | author of the document                             | 
| **aff**iliation(str) | author affiliation                                 | 
| **add**ress(str)     | author address or email                            | 
| **sum**mary(str)     | abstract or summary of the document                | 

Description
-----------

__mdconvert__ is an alternative to [Pandoc](https://pandoc.org/) for converting 
Markdown documents to __docx__ and __pdf__ within Stata 15. This package was 
developed to support [markdoc](https://github.com/haghish/markdoc) package and 
allow generating dynamic documents independent of Pandoc or 
[wkhtmltopdf](https://wkhtmltopdf.org/) for generating Microsoft Word and 
PDF documents respectively. 

Limitations
-----------

Generating docx and pdf files in Stata 15 is done using the __putdocx__ and 
__putpdf__ commands. Compared to Pandoc, these commands are still very limited
and do not fully cover the Markdown syntax. For example, they do not allow:

1. horizontal line
2. Hyperlink
3. Nested lists
4. Mathematical notations

Examples
--------

convert Markdown file to docx

        . mdconvert using "markdown.md", name(mydoc) export(docx) replace

convert Markdown file to pdf

        . mdconvert using "markdown.md", name(mydoc) export(pdf) replace

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



*cap prog drop mdconvert
program define mdconvert

	local version = int(`c(stata_version)')
	
	if `version' < 15 {
		display as err "this command is only supported in Stata 15 and above"
		err 1
	}
	if `version' >= 15 {
		local trim ustrltrim
		local version 15
	}
	
	
  syntax using/    ///
	[, 				       ///
	REPlace 	 	     /// replaces the current sthlp file, if it already exists
	name(str)	       /// name of the document
	Export(name) 	   /// specifies the exported format 
	TITle(str)   	   /// specifies the title of the document (for styling)
	AUthor(str)  	   /// specifies the author of mthe document (for styling)
	AFFiliation(str) /// specifies author affiliation (for styling)
	ADDress(str) 	   /// specifies author contact information (for styling)
	Date			       /// Add the document generation date to the document
	SUMmary(str)     /// writing the summary or abstract of the report
	]
	
	
	// -------------------------------------------------------------------------
	// Syntax Processing
	// =========================================================================
	confirm file "`using'"
	
	if missing("`export'") local export docx
	
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
	
	local tablenum = 0
	
	

	
	************************************************************************	
	*
	* MAIN ENGINE 
	* -----------
	*
	* Part 1- Initiating the document and creating the title page
	* Part 2- Processing the Markdown file
	* Part 3- 
	************************************************************************
	
	// -------------------------------------------------------------------------
	// Part 1: Initiating the document and create the title page
	// =========================================================================
	
	// make sure the file was NOT OPEN, because mdconvert is a file translator
	capture `command' clear
	`command' begin
	
	if !missing("`title'") {
		if "`export'" == "docx" {
			`command' paragraph, style("Title")
		}
		else {
			`command' paragraph, font("", 26, navy) 
		}
		`command' text ("`title'")
	}
	
	

	if !missing("`author'") {
		if "`export'" == "docx" {
			`command' paragraph, style("Subtitle")
		}
		else {
			`command' paragraph, font("", 12, lightskyblue) 
		}
			
		
		if !missing("`title'") `command' text (""),  linebreak
		`command' text ("`author', "), font("", 8, gray) linebreak
	}
	
	if !missing("`affiliation'") {
		*`command' paragraph, style("Subtitle")
		`command' text ("`affiliation'"), font("", 8, gray) linebreak
	}
	
	if !missing("`address'") {
		*`command' paragraph, style("Subtitle")
		`command' text ("`address'"), font("", 8, "")
	}
	
	if !missing("`summary'") {
		`command' paragraph
		`command' text (""), linebreak
		`command' text ("`summary'"), italic font("", 10, gray)
	}

	if !missing("`summary'") {
		 
		`command' paragraph
		`command' pagebreak
	}
	


	// -------------------------------------------------------------------------
	// Part 2: Reading the source file 
	// =========================================================================
	tempfile tmp 
	tempname hitch knot 
	qui file open `hitch' using `"`using'"', read
	file read `hitch' line
	
	local PARAGRAPH       //store the current paragraph
	local JUMP
	
	local i  1
	local i2 0
	

	// -------------------------------------------------------------------------
	// Part 3: Processing the source and applying Markdown
	// =========================================================================
	while r(eof) == 0 {	
		
		local preline `"`macval(line)'"'
		file read `hitch' line
		
		//fix the problem of graveaccent in the end of the line
		capture if substr("`macval(line)'",-1,.) == "`" local graveaccent 1
		else local graveaccent ""
		if "`graveaccent'" == "1" {
				local line `"`macval(line)' "' 
				local graveaccent ""
		}

		if "`PARAGRAPH'" == "CODE" & `trim'(`"`macval(preline)'"') == "" & ///
			substr(`"`macval(line)'"',1,4) == "    " {
			*`command' paragraph, indent(left, 0) shading(whitesmoke)
			`command' text (""), linebreak
			local JUMP 1
		}
		
		// reset PARAGRAPH style
		if missing("`JUMP'") & `trim'(`"`macval(preline)'"') == "" & ///
		   substr(`"`macval(preline)'"',1,4) != "    "  {
			local PARAGRAPH 
		}
		
		*display as txt `"`macval(preline)'"'
		
		// -------------------------------------------------------------
		// Headings type 1
		// -------------------------------------------------------------
		if missing("`JUMP'") & substr(`"`macval(line)'"',1,3) == "===" {
			if "`export'" == "docx" {
				`command' paragraph, style("Heading1")
			}
			else {
				`command' paragraph, font("", 14, royalblue) 
			}
			
			mdminor `"`macval(preline)'"', continue export(`export') 
			file read `hitch' line 
			if `trim'(`"`macval(line)'"') == "" {
				file read `hitch' line
			}
			local PARAGRAPH "HEADING1"
			local JUMP 1
		}
		
		//??? CAN BE PROBLEMATIC WITH TABLES?
		if missing("`JUMP'") & substr(`"`macval(line)'"',1,3) == "---" {
			if "`export'" == "docx" {
				`command' paragraph, style("Heading2")
			}
			else {
				`command' paragraph, font("", 13, dodgerblue) 
			}
			mdminor `"`macval(preline)'"', continue export(`export') 
			file read `hitch' line
			if `trim'(`"`macval(line)'"') == "" {
				file read `hitch' line
			}
			local PARAGRAPH "HEADING2"
			local JUMP 1
		}
		
		
		// -------------------------------------------------------------
		// Headings type 2
		// -------------------------------------------------------------
		if missing("`JUMP'") & substr(`trim'(`"`macval(preline)'"'),1,7) == "###### " {
			local preline : subinstr local preline "###### " ""
			if "`export'" == "docx" {
				`command' paragraph, style("Heading6")
			}
			else {
				`command' paragraph, font("", 11, black) 
			}
			mdminor `"`macval(preline)'"', continue export(`export') 
			local PARAGRAPH "HEADING6"
			local JUMP 1
		}
		if missing("`JUMP'") & substr(`trim'(`"`macval(preline)'"'),1,6) == "##### " {
			local preline : subinstr local preline "##### " ""
			if "`export'" == "docx" {
				`command' paragraph, style("Heading5")
			}
			else {
				`command' paragraph, font("", 11, lightsteelblue) 
			}
			mdminor `"`macval(preline)'"', continue export(`export') 
			local PARAGRAPH "HEADING5"
			local JUMP 1
		}
		if missing("`JUMP'") & substr(`trim'(`"`macval(preline)'"'),1,5) == "#### " {
			local preline : subinstr local preline "#### " ""
			if "`export'" == "docx" {
				`command' paragraph, style("Heading4")
			}
			else {
				`command' paragraph, font("", 11, skyblue) 
			}
			mdminor `"`macval(preline)'"', continue export(`export') 
			local PARAGRAPH "HEADING4"
			local JUMP 1
		}
		if missing("`JUMP'") & substr(`trim'(`"`macval(preline)'"'),1,4) == "### " {
			local preline : subinstr local preline "### " ""
			if "`export'" == "docx" {
				`command' paragraph, style("Heading3")
			}
			else {
				`command' paragraph, font("", 11, lightskyblue) 
			}
			mdminor `"`macval(preline)'"', continue export(`export') 
			local PARAGRAPH "HEADING3"
			local JUMP 1
		}
		if missing("`JUMP'") & substr(`trim'(`"`macval(preline)'"'),1,3) == "## " {
			local preline : subinstr local preline "## " ""
			if "`export'" == "docx" {
				`command' paragraph, style("Heading2")
			}
			else {
				`command' paragraph, font("", 13, dodgerblue) 
			}
			mdminor `"`macval(preline)'"', continue export(`export') 
			local PARAGRAPH "HEADING2"
			local JUMP 1
		}
		if missing("`JUMP'") & substr(`trim'(`"`macval(preline)'"'),1,2) == "# " {
			local preline : subinstr local preline "# " ""
			if "`export'" == "docx" {
				`command' paragraph, style("Heading1")
			}
			else {
				`command' paragraph, font("", 14, royalblue) 
			}
			mdminor `"`macval(preline)'"', continue export(`export') 
			local PARAGRAPH "HEADING1"
			local JUMP 1
		}
		
		// -------------------------------------------------------------------------
		// Image
		// -------------------------------------------------------------------------
		if substr(`trim'(`"`macval(preline)'"'),1,2) == "![" & ///
		   substr(`"`macval(preline)'"',1,4) != "    " {
			if strpos(`"`macval(preline)'"', "](") != 0 {
				local a = strpos(`"`macval(preline)'"', "](")
				local preline : subinstr local preline "](" ""
				local caption = substr(`"`macval(preline)'"',3,`a'-3) 
				local image   = substr(`"`macval(preline)'"',`a',.) 
				local b = length(`"`macval(image)'"')
				local image = substr(`"`macval(image)'"',1,`b'-1)
				
				`command' paragraph
				`command' text (""), linebreak
				`command' image `image'
				`command' paragraph //, halign(center)
				mdminor `"`macval(caption)'"', continue export(`export')
				`command' text (""), linebreak
				local PARAGRAPH "IMAGE"
				local JUMP 1
			}	
		}
		
		// -------------------------------------------------------------------------
		// Table  (needs much more work, currently only the default tbl is recognized)
		// -------------------------------------------------------------------------
		if substr(`"`macval(line)'"',1,5) == ":----"  |  ///
		   substr(`"`macval(line)'"',1,5) == "|----"  |  ///
			 substr(`"`macval(line)'"',1,6) == "|:----" |  ///
			 substr(`"`macval(line)'"',1,6) == "| ----" |  ///
			 substr(`"`macval(line)'"',1,6) == "| :---" | {		
			
			local tablenum = `tablenum'+1
			
			//there should be a nicer way to count occerances of "|" in Stata! suggestions?!
			local columns = subinstr(`"`macval(line)'"', "-", "", .)
			local columns = subinstr(`"`macval(columns)'"', ":", "", .)
			local columns = subinstr(`"`macval(columns)'"', " ", "", .)
			local columns = length(`trim'("`columns'")) + 1
			
			// initiate a table with 2 rows
			if "`export'" == "docx" {
				`command' table table`tablenum' = (1, `columns'), headerrow(1) border(all, "", white) layout(autofitcontents) 
			}
			else {
				`command' table table`tablenum' = (1, `columns') , border(all, "", white)  //   width(4)
			}
			
			// add the first row
			tokenize `"`macval(preline)'"', parse("|")
			local col = 0
			while `"`macval(1)'"' != "" {
				if `"`macval(1)'"' != "|" {
					local col = `col'+1
					
					if substr(`"`macval(1)'"',1,3) == "***" {
						local 1 : subinstr local 1 "***" "" , all
						local bold "bold"
						local italic "italic"
					}
					else if substr(`"`macval(1)'"',1,2) == "**" {
						local 1 : subinstr local 1 "**" "" , all
						local bold "bold"
					}
					else if substr(`"`macval(1)'"',1,1) == "*" {
						local 1 : subinstr local 1 "*" "" , all
						local italic "italic"
					}
					
					if substr(`"`macval(1)'"',1,3) == "___" {
						local 1 : subinstr local 1 "___" "", all
						local bold "bold"
						local italic "italic"
					}
					else if substr(`"`macval(1)'"',1,2) == "__" {
						local 1 : subinstr local 1 "__" "", all
						local bold "bold"
					}
					else if substr(`"`macval(1)'"',1,1) == "_" {
						local 1 : subinstr local 1 "_" "" , all
						local italic "italic"
					}
							
					if "`export'" == "docx" {
						`command' table table`tablenum'(1,`col') = (`"`macval(1)'"'), bold `italic' border(top, "", black, .5) border(bottom, "", black, 1)
					}
					else {
						`command' table table`tablenum'(1,`col') = (`"`macval(1)'"'), bold `italic' border(top, "", black) border(bottom, "", black)
					}
				}
				macro shift
				local bold 
				local italic
			}
			
			// add the next rows
			*file read `hitch' line
			local preline `"`macval(line)'"'
			file read `hitch' line
			local row = 1
			
			if `trim'(`"`macval(line)'"') != "" {
				while `trim'(`"`macval(line)'"') != "" {
					local preline `"`macval(line)'"'
					file read `hitch' line
					if `trim'(`"`macval(line)'"') == "" local endtable 1
					
					`command' table table`tablenum'(`row',.), addrows(1)
					local row = `row'+1
					tokenize `"`macval(preline)'"', parse("|")
					local col = 0
					while `"`macval(1)'"' != "" {
						if `"`macval(1)'"' != "|" {
							
							if substr(`"`macval(1)'"',1,3) == "***" {
								local 1 : subinstr local 1 "***" "" , all
								local bold "bold"
								local italic "italic"
							}
							else if substr(`"`macval(1)'"',1,2) == "**" {
								local 1 : subinstr local 1 "**" "" , all
								local bold "bold"
							}
							else if substr(`"`macval(1)'"',1,1) == "*" {
								local 1 : subinstr local 1 "*" "" , all
								local italic "italic"
							}
							
							if substr(`"`macval(1)'"',1,3) == "___" {
								local 1 : subinstr local 1 "___" "", all
								local bold "bold"
								local italic "italic"
							}
							else if substr(`"`macval(1)'"',1,2) == "__" {
								local 1 : subinstr local 1 "__" "", all
								local bold "bold"
							}
							else if substr(`"`macval(1)'"',1,1) == "_" {
								local 1 : subinstr local 1 "_" "" , all
								local italic "italic"
							}
		
							local col = `col'+1
							if missing("`endtable'") `command' table table`tablenum'(`row',`col') = (`"`macval(1)'"'), `bold' `italic'
							else {
								if "`export'" == "docx" {
									`command' table table`tablenum'(`row',`col') = (`"`macval(1)'"') , border(bottom, "", black, 1) `bold' `italic'
								}
								else {
									`command' table table`tablenum'(`row',`col') = (`"`macval(1)'"') , border(bottom, "", black) `bold' `italic'
								}
							}	
						}
						macro shift
						local bold 
						local italic
					}
					
				}
			}
			else {
				`command' table table`tablenum'(`row',.), addrows(1)
					local row = `row'+1
					tokenize `"`macval(preline)'"', parse("|")
					local col = 0
					while `"`macval(1)'"' != "" {
						if `"`macval(1)'"' != "|" {
							local col = `col'+1
							`command' table table`tablenum'(`row',`col') = (`"`macval(1)'"') //, border(insideV, , white)
						}
						macro shift
					}
			}
			
			// update the table width
			local endtable //RESET
			local JUMP 1
		}
		
		// -------------------------------------------------------------
		// codeblock
		// -------------------------------------------------------------
		if missing("`JUMP'") & substr(`trim'(`"`macval(preline)'"'),1,3) == "~~~" {
			if "`export'" == "docx" {
				`command' paragraph, indent(left, 0) font("courier", 6, "") shading(whitesmoke) //spacing(before, .1)
			}
			else {
				`command' paragraph, indent(left, 0) font("courier", 6, "")
			}
			
			`command' text (""), font("courier", 7, black) linebreak
			`command' text (`"`macval(line)'"'), font("courier", 6, black)
			`command' text (""), linebreak
			
			while missing("`break'") {	
				file read `hitch' line
				if substr(`trim'(`"`macval(line)'"'),1,3) == "~~~" {
				  file read `hitch' line
					local break = 1
					local JUMP 1
				}
				else {
					`command' text (`"`macval(line)'"'), font("courier", 6, black)
					`command' text (""), linebreak
				}
			}
		}
		
		// -------------------------------------------------------------
		// Indent
		// -------------------------------------------------------------
		if missing("`JUMP'") & substr(`trim'(`"`macval(preline)'"'),1,5) == "> > >" {
			local preline : subinstr local preline "> > >" ""
			`command' paragraph, indent(left, 1.5)
			mdminor `"`macval(preline)'"', continue export(`export')
			local PARAGRAPH "INDENT"
			local JUMP 1
		}
		if missing("`JUMP'") & substr(`trim'(`"`macval(preline)'"'),1,3) == "> >" {
			local preline : subinstr local preline "> >" ""
			`command' paragraph, indent(left, 1)
			mdminor `"`macval(preline)'"', continue export(`export')
			local PARAGRAPH "INDENT"
			local JUMP 1
		}
		if missing("`JUMP'") & substr(`trim'(`"`macval(preline)'"'),1,1) == ">" {
			local preline : subinstr local preline ">" ""
			`command' paragraph, indent(left, .5)
			mdminor `"`macval(preline)'"', continue export(`export')
			local PARAGRAPH "INDENT"
			local JUMP 1
		}
		
		// Create Markdown Horizontal line
		// -----------------------------------------------------
		*if substr(`"`macval(`l')'"',1,5) == "- - -" {
		if missing("`JUMP'") {
			if `"`macval(preline)'"' == "- - -" | ///
				 `"`macval(preline)'"' == "---"   | ///
				 `"`macval(preline)'"' == "***" {
				if `trim'(`"`macval(line)'"') == "" {
					local tablenum = `tablenum'+1
					*`command' text (""), linebreak(2)  //hr still unsupported by Stata 15 
					if "`export'" == "docx" {
						`command' table table`tablenum' = (1, 1), border(all, single, white) 
					}
					else {
						`command' table table`tablenum' = (1, 1), border(all, single, white) spacing(before,0)
					}
					
					`command' table table`tablenum'(1,1) = ("") , border(bottom, "", gainsboro) font("", 1, black) //margin(top,0) margin(bottom,0) 
					local PARAGRAPH 
				}
				local JUMP 1
			}
		}
		
		//Check for Paragraph code AUTOMATICALLY
		// -------------------------------------------------------------------------
		if missing("`JUMP'") &                            ///
		   substr(`"`macval(preline)'"',1,4) == "    " &  ///  
		   substr(`"`macval(preline)'"',1,5) != "    -" & ///  //nested lists with space
			 substr(`"`macval(preline)'"',1,5) != "    +" {
			if "`PARAGRAPH'" != "CODE" {
				if "`export'" == "docx" {
					`command' paragraph, indent(left, 0) font("courier", 6, "") shading(whitesmoke) //spacing(before, .1)
				}
				else {
					`command' paragraph, indent(left, 0) font("courier", 6, "")
				}
				`command' text (""), linebreak
			}
			
			if substr(`trim'(`"`macval(preline)'"'),1,2) == ". " {
				`command' text (`"`macval(preline)'"'), font("courier", 7, navy) bold
			}
			else {
				`command' text (`"`macval(preline)'"'), font("courier", 6, black)
			}
			
			 
			`command' text (""), linebreak
			local PARAGRAPH "CODE"
			local JUMP 1
		}
		
		// Write a paragraph, but make sure it is not a new paragraph
		if missing("`JUMP'") {
			
			if `trim'(`"`macval(preline)'"') != "" {
				if "`PARAGRAPH'" != "PARAGRAPH" {
					`command' paragraph
					local PARAGRAPH "PARAGRAPH"
				}
			
				*display as err `":`macval(preline)'"'
				mdminor `"`macval(preline)'"', continue export(`export')
			}
		}
		
		local JUMP     //RESET
	}
	
	
	// Close the file
	`command' save `name', `replace'

end
