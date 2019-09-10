// THIS PROGRAM NEEDS CLEANING! YOU'RE WELCOME TO FORK IT

/*

					   Developed by E. F. Haghish (2014)
			  Center for Medical Biometry and Medical Informatics
						University of Freiburg, Germany
						
						  haghish@imbi.uni-freiburg.de
								   
                       * MarkDoc comes with no warranty *

	
	
	sthlp program
	===============
	
	This program is a part of MarkDoc package and generates dynamic Stata help 
	files within source code, in ".sthlp" file format. 
*/


/***
_v. 2.1._

sthlp
=====

converts Markdown to STHLP format to create Stata help files

Syntax
------

> __sthlp__ _filename_ [, _replace_ _debug_ ]

### Options

| Option       | Description                                        |
|--------------|----------------------------------------------------|
| _replace_    | replaces the existing file                         |
| _debug_      | runs __sthlp__ in debug mode                       |
| _helplayout_ | appends the help file template to a script file    |
| _datalayout_ | appends or creates the data documentation template |

Example
-------

extract the Markdown notation from a do-file and build a help file

     . sthlp filename.ado , replace 

append the help layout to an ado-file

     . sthlp filename.ado, helplayout

generate a data documentation template for __auto.dta__

     . sysuse auto, clear
     . sthlp filename.do , replace datalayout

Author
------

E. F. Haghish  
_haghish@med.uni-goesttingen.de_  
[https://github.com/haghish/echo](https://github.com/haghish/echo)  

License
-------

MIT License

- - -

This help file was dynamically produced by 
[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/) 

***/



*cap prog drop sthlp
program define sthlp

	// NOTE:
	// Stata 14 introduces ustrltrim() function for removing Unicode whitespace 
	// characters and blanks. The previous trim() function cannot remove unicode 
	// whitespace. The program is updated to function for all versions of Stata, 
	// but yet, there is a slight chance of "unreliable" behavior from MarkDoc 
	// in older versions of Stata, if the string has a unicode whitespace...
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
	
	
    syntax anything(name=script id="The script file name is")					/// 
	[, 				 ///
	replace 	 	 /// replaces the current sthlp file, if it already exists
	TEMPlate(str)	 /// If template(empty), avoid appending the template
	Export(name) 	 /// specifies the exported format 
	TITle(str)   	 /// specifies the title of the document (for styling)
	AUthor(str)  	 /// specifies the author of mthe document (for styling)
	AFFiliation(str) /// specifies author affiliation (for styling)
	ADDress(str) 	 /// specifies author contact information (for styling)
	Date			 /// Add the document generation date to the document
	SUMmary(str)     /// writing the summary or abstract of the report
	VERsion(str)     /// add version to dynamic help file
	build		 	 /// creates the toc and pkg files
	markup(str)		 /// specify markup language used for documentation
	helplayout		 /// appends the help layout
	debug          ///
	]
	
	
	// -------------------------------------------------------------------------
	// Syntax Processing
	// =========================================================================
	if !missing("`build'") di as err "{bf:build} option is no longer supported"
	
	if missing("`export'") local export sthlp
	
	local input `script'
		
	if (index(lower("`input'"),".ado")) {
		local name : subinstr local input ".ado" ""
		local convert "`name'.`export'"
		local extension ado
	}
	else if (index(lower("`input'"),".mata")) {
		local name : subinstr local input ".mata" ""
		local convert  "`name'.`export'"
		local extension mata
	} 
	else if (index(lower("`input'"),".do")) {
		local name : subinstr local input ".do" ""
		local convert  "`name'.`export'"
		local extension do
	}
	else if (index(lower("`input'"),".md")) {
		local name : subinstr local input ".md" ""
		local convert  "`name'.`export'"
		local extension md
	} 
	
	// assume it's an ADO file
	capture confirm file "`script'.ado"
	if _rc == 0 {
		local name : subinstr local input ".ado" ""
		local convert "`name'.`export'"
		local script `script'.ado
		local extension ado
	}
	
	if missing("`extension'") {
		di as err "{p}file extension not recognized; MarkDoc can generate "		///
		"dynamic Stata help files from {bf:do}, {bf:ado}, and {bf:mata} files" _n
		exit 198
	}
	
	// check the markup language used for documenting the help files
	if "`markup'" != "markdown" & "`markup'" != "markdown+smcl" &               ///
	   "`markup'" != "smcl" & "`markup'" != "" {
		di as err "{p}`markup' is not a supported markup format"
		exit 198
	}
	
	confirm file "`script'"
	
	// If the template is not "empty", then make sure other locals are ""
	if !missing("`helplayout'") {
		local author 
		local affiliation
		local address
		local title
		local summary
	}
	

	************************************************************************	
	*
	* MAIN ENGINE 
	* -----------
	*
	* Part 1- Adding the template
	* Part 2- Processing the template
	* Part 3- Converting to STHLP or SMCL file
	************************************************************************
	
	
	// -------------------------------------------------------------------------
	// Part 1: Adding the template 
	// =========================================================================
	tempfile tmp 
	tempname hitch knot 
	qui file open `hitch' using `"`script'"', read
	qui file open `knot' using `"`tmp'"', write replace
	file read `hitch' line

	if !missing("`helplayout'") {

		if "`markup'" == "markdown" | "`markup'" == ""  {
			file write `knot' 														        ///
			"/***" _n 																            ///
			"_version 1.0_ " _n(2)                            ///
			"XXX" _n                                            ///
			"===== " _n(2)                                       ///
			"explain the XXX command briefly..." _n /// 
      ///"You can use simplified syntax to make text" _n       ///
      ///"_italic_, __bold__, **emphasized**, or" _n           ///
      ///"add [hyperlink](http://www.haghish.com/markdoc)" _n  ///
			"" _n                                                 ///
			"Syntax" _n                                           ///
			"------ " _n(2)                                       ///
			"> __XXX__ _varlist_ =_exp_ [_if_] [_in_] " _n        ///
			"[_weight_] using _filename_ [, _options_]" _n(2)   	///
			"| _option_          |  _Description_          |" _n 	///
			"|:------------------|:------------------------|" _n 	///
			"| **em**phasize     | explain whatever does   |" _n 	///
			"| **opt**ion(_arg_) | explain whatever does   |" _n 	///
			///"" _n(2)      		                                     ///
			///"__by__ is allowed; see __[[D] by](help by)__  " _n   ///
			///"__fweight__ is allowed; [weight](help weight)  " _n  ///
			"" _n(2) 												                      ///
			"Description" _n 														          ///
			"-----------" _n(2) 													        ///
			"describe __XXX__ in more details ..." _n(2) 					///
			"Options" _n 															            ///
			"-------" _n(2) 														          ///
			"describe the options in details, if the options table is not enough" _n(2) 										///
			///"> Use __>__ for additional paragraphs within "       ///
			///     "and option " _n 			                          ///
			///"description to indent the paragraph." _n(2) 					///
			///"__2nd option__ etc." _n(2) 											    ///
			"Remarks" _n 															            ///
			"-------" _n(2) 													          	///
			"discuss the technical details about __XXX__, if there is any" _n(2) 			///
			"Example(s)" _n															          ///
			"----------" _n(2)												      ///
			"    explain what it does" _n(2)										  ///
			"        . XXX example command" _n(2)										  ///
			"    second explanation" _n(2)											    	///
			"        . XXX example command" _n(2)									   	///
			"Stored results" _n														        ///
			"--------------" _n(2)												      ///
			"describe the Scalars, Matrices, Macros, stored by __XXX__, for example:" _n(2) 	///
			"### Scalars" _n(2) 										                  ///
			"> __r(level)__: explain what the scalar does " _n(2) 					///
			"### Matrices" _n(2) 				                                ///
			"> __r(table)__: explain what it includes" _n(2) 								                      ///
			"Functions" _n(2) 										                ///
			"Acknowledgements" _n 													      ///
			"----------------" _n(2) 												      ///
			"If you have thanks specific to this command, put them here." _n(2) 	///
			"Author" _n 															            ///
			"------" _n(2) 															          ///
			"leave 2 white spaces at the end of each line for line break. "			///
			"For example:" _n(2) 													        ///
			"Your Name   " _n 														        ///
			"Your affiliation    " _n 												    ///
			"Your email address, etc.    " _n(2) 									///
			"License" _n 														              ///
			"-------" _n(2)                                       ///
			"Specify the license of the software" _n(2)           ///
			"References" _n 														          ///
			"----------" _n(2) 														        ///
			"Author Name (year), "	 												      ///
			"[title & external link](https://github.com/haghish/markdoc/)" _n(2) 		///
			"- - -" _n(2)													                ///
			"This help file was dynamically produced by " _n			///
			"[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/) " _n ///
			"***/" _n(4)
		}
		
		if "`markup'" == "markdown+smcl" {
			file write `knot' 														///
			"/***" _n 																///
			"Syntax" _n 															///
			"====== " _n(2)	 														///
			"{p 8 16 2}" _n 														///
			"{cmd: XXX} {varlist} {cmd:=}{it}{help exp}{sf} {ifin} {weight} " _n 	///
			"{help using} {it:filename} [{cmd:,} {it:options}]" _n 					///
			"{p_end}" _n(2) 														///
			"{* the new Stata help format of putting detail before generality}{...}" _n ///
			"{synoptset 20 tabbed}{...}" _n 										///
			"{synopthdr}" _n 														///
			"{synoptline}" _n 														///
			"{syntab:Main}" _n 														///
			"{synopt:{opt min:abbrev}}description of what option{p_end}" _n 		///
			"{synopt:{opt min:abbrev(arg)}}description of another option{p_end}" _n ///
			"{synoptline}" _n 														///
			"{p2colreset}{...}" _n(2) 												///
			"{p 4 6 2}{* if by is allowed, leave the following}" _n 				///
			"{cmd:by} is allowed; see {manhelp by D}.{p_end}" _n 					///
			"{p 4 6 2}{* if weights are allowed, say which ones}" _n 				///
			"{cmd:fweight}s are allowed; see {help weight}." _n(2) 					///
			"Description" _n 														///
			"===========" _n(2) 													///
			"__XXX__ does ... (now put in a one-short-paragraph description " _n 	///
			"of the purpose of the command)" _n(2) 									///
			"Options" _n 															///
			"=======" _n(2) 														///
			"__whatever__ does yak yak" _n(2) 										///
			">Use __>__ for additional paragraphs within and option " _n 			///
			"description to indent the paragraph." _n(2) 							///
			"__2nd option__ etc." _n(2) 											///
			"Remarks" _n 															///
			"=======" _n(2) 														///
			"The remarks are the detailed description of the command and its " _n 	///
			"nuances. Official documented Stata commands don't have much for " _n	///
			"remarks, because the remarks go in the documentation." _n(2) 			///
			"Example(s)" _n															///
			"=================" _n(2)												///
			"    explain what it does" _n											///
			"        . example command" _n(2)										///
			"    second explanation" _n												///
			"        . example command" _n(2)										///
			"Stored results" _n														///
			"=================" _n(2)												///
			"__commandname__ stores the following in __r()__ or __e()__:" _n(2) 	///
			"{synoptset 20 tabbed}{...}" _n 										///
			"{p2col 5 20 24 2: Scalars}{p_end}" _n 									///
			"{synopt:{cmd:r(N)}}number of observations{p_end}" _n(2) 				///
			"{synoptset 20 tabbed}{...}" _n 										///
			"{p2col 5 20 24 2: Macros}{p_end}" _n(2) 								///
			"{synoptset 20 tabbed}{...}" _n 										///
			"{p2col 5 20 24 2: Matrices}{p_end}" _n(2) 								///
			"{synoptset 20 tabbed}{...}" _n 										///
			"{p2col 5 20 24 2: Functions}{p_end}" _n(2) 							///
			"Acknowledgements" _n 													///
			"================" _n(2) 												///
			"If you have thanks specific to this command, put them here." _n(2) 	///
			"Author" _n 															///
			"======" _n(2) 															///
			"Author information here; nothing for official Stata commands" _n 		///
			"leave 2 white spaces in the end of each line for line break. "			///
			"For example:" _n(2) 													///
			"Your Name   " _n 														///
			"Your affiliation    " _n 												///
			"Your email address, etc.    " _n(2) 									///
			"References" _n 														///
			"==========" _n(2) 														///
			"Author Name (2016), "	 												///
			"[title & external link](http://www.haghish.com/markdoc/)" _n(2) 		///
			"- - -" _n(2)													///
			"This help file was dynamically produced by " _n						///
			"[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/) " _n ///
			"***/" _n(4)
		}
		
		
		if "`markup'" == "smcl" {
			file write `knot' 														///
			"/***" _n 																///
			"{marker syntax}{...}" _n 															///
			"{title:Syntax}" _n(2)	 														///
			"{* put the syntax in what follows. Don't forget to use [ ] around optional items}{...}" _n ///
			"{p 8 16 2}" _n 														///
			"{cmd: XXX} {varlist} {cmd:=}{it}{help exp}{sf} {ifin} {weight} " _n 	///
			"{help using} {it:filename} [{cmd:,} {it:options}]" _n 					///
			"{p_end}" _n(2) 														///
			"{* the new Stata help format of putting detail before generality}{...}" _n ///
			"{synoptset 20 tabbed}{...}" _n 										///
			"{synopthdr}" _n 														///
			"{synoptline}" _n 														///
			"{syntab:Main}" _n 														///
			"{synopt:{opt min:abbrev}}description of what option{p_end}" _n 		///
			"{synopt:{opt min:abbrev(arg)}}description of another option{p_end}" _n ///
			"{synoptline}" _n 														///
			"{p2colreset}{...}" _n(2) 												///
			"{p 4 6 2}{* if by is allowed, leave the following}" _n 				///
			"{cmd:by} is allowed; see {manhelp by D}.{p_end}" _n 					///
			"{p 4 6 2}{* if weights are allowed, say which ones}" _n 				///
			"{cmd:fweight}s are allowed; see {help weight}." _n(2) 					///
			"{marker description}{...}" _n 														///
			"{title:Description}" _n(2) 													///
			"{cmd:XXX} does ... (now put in a one-short-paragraph description of the purpose of the command)" _n 	///
			"{p_end}" _n(2) 									///
			"{marker options}{...}" _n 															///
			"{title:Options}" _n(2) 														///
			"{phang}{opt whatever} does yak yak" _n ///
			"{p_end}" _n(2) 										///
			"{pmore}Use -pmore- for additional paragraphs within and option description." _n 			///
			"{p_end}" _n(2) 							///
			"{phang}{opt 2nd option} etc." _n(2) 											///
			"Remarks" _n 															///
			"=======" _n(2) 														///
			"The remarks are the detailed description of the command and its " _n 	///
			"nuances. Official documented Stata commands don't have much for " _n	///
			"remarks, because the remarks go in the documentation." _n(2) 			///
			"Example(s)" _n															///
			"=================" _n(2)												///
			"    explain what it does" _n											///
			"        . example command" _n(2)										///
			"    second explanation" _n												///
			"        . example command" _n(2)										///
			"Stored results" _n														///
			"=================" _n(2)												///
			"__commandname__ stores the following in __r()__ or __e()__:" _n(2) 	///
			"{synoptset 20 tabbed}{...}" _n 										///
			"{p2col 5 20 24 2: Scalars}{p_end}" _n 									///
			"{synopt:{cmd:r(N)}}number of observations{p_end}" _n(2) 				///
			"{synoptset 20 tabbed}{...}" _n 										///
			"{p2col 5 20 24 2: Macros}{p_end}" _n(2) 								///
			"{synoptset 20 tabbed}{...}" _n 										///
			"{p2col 5 20 24 2: Matrices}{p_end}" _n(2) 								///
			"{synoptset 20 tabbed}{...}" _n 										///
			"{p2col 5 20 24 2: Functions}{p_end}" _n(2) 							///
			"Acknowledgements" _n 													///
			"================" _n(2) 												///
			"If you have thanks specific to this command, put them here." _n(2) 	///
			"Author" _n 															///
			"======" _n(2) 															///
			"Author information here; nothing for official Stata commands" _n 		///
			"leave 2 white spaces in the end of each line for line break. "			///
			"For example:" _n(2) 													///
			"Your Name   " _n 														///
			"Your affiliation    " _n 												///
			"Your email address, etc.    " _n(2) 									///
			"References" _n 														///
			"==========" _n(2) 														///
			"Author Name (2016), "	 												///
			"[title & external link](http://www.haghish.com/markdoc/)" _n(2) 		///
			"- - -" _n(2)													///
			"This help file was dynamically produced by " _n						///
			"[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/) " _n ///
			"***/" _n(4)
		}
		
		
		file write `knot' `"`macval(line)'"' _n 
		
		while r(eof) == 0 {
			file read `hitch' line
			file write `knot' `"`macval(line)'"' _n 
		}
		
		file close `hitch'
		file close `knot'
		capture copy "`tmp'" "`script'", replace public
		
		if _rc != 0 {
			local k 1
			local oldname
			while missing("`oldname'") {
				capture confirm file "`name'_`k'.`extension'"
				if _rc != 0 {
					capture copy "`tmp'" "`name'_`k'.`extension'", replace public
					local oldname `script'
					local script "`name'_`k'.`extension'"
				}
				local k `++k'
			}
			
			di as txt "{p}It seems your operating system does not allow "		///
			"{help MarkDoc} to replace your script file. This probably means "  ///
			"that you are a Microsoft Windows user. MarkDoc created " 			///
			"{browse `script'} instead, so you can work further on this file "	///
			"or replace it yourself. The original error was:" _n
		
			di as err  "{p 4 4 2}"												///
			"file `oldname' cannot be modified or erased; likely cause "		///
			"is read-only directory or file {help r(608)}" _n	
		}
	}

	
	// -------------------------------------------------------------------------
	// Part 2: Reading the documentation!
	// =========================================================================
	tempfile tmp 
	tempname hitch knot 
	qui file open `hitch' using `"`script'"', read
	qui file open `knot' using `"`tmp'"', write replace
	file write `knot'  "{smcl}" _n 
	file read `hitch' line
	
	// -------------------------------------------------------------------------
	// Part 3: Processing the source and applying Markdown
	// =========================================================================
	while r(eof) == 0 {	
		
		local pass	// reset
		
		// if you find the "/***" sign proceed. Also proceed if the file is Markdown		
		if "`extension'" == "md" {
			local pass 1
		}
		capture if substr(`trim'(`"`macval(line)'"'),1,4) == "/***" {
			local pass 1
			file read `hitch' line
		}
		
		
		// if NOT MISSING `pass'
		// =====================================================
		if !missing("`pass'") {
			
			//remove white space in old-fashion way!
			cap local m : display "`line'"
			if _rc == 0 & missing(trim("`m'")) {
				local line ""
			}
			
			//fix the problem of graveaccent in the end of the line
			capture if substr("`macval(line)'",-1,.) == "`" local graveaccent 1
			else local graveaccent ""
			if "`graveaccent'" == "1" {
					local line `"`macval(line)' "' 
					local graveaccent ""
			}
			
			//procede when a line is found
			//Interpret 2 lines at the time, for Markdown headings
			while r(eof) == 0 & trim(`"`macval(line)'"') != "***/" {
				
				local preline `"`macval(line)'"'
				
				if !missing(`trim'(`"`macval(line)'"')) & 					///
				substr(`"`macval(line)'"',1,4) != "    " {
					qui md2smcl `"`macval(line)'"'
					local preline `"`r(md)'"'
				}	
				
				file read `hitch' line
				
				//fix the problem of graveaccent in the end of the line
				capture if substr("`macval(line)'",-1,.) == "`" local graveaccent 1
				else local graveaccent ""
				if "`graveaccent'" == "1" {
						local line `"`macval(line)' "' 
						local graveaccent ""
				}
				
				// -------------------------------------------------------------
				// If heading syntax is found, create the heading
				//
				// NOTE: MAKE SURE "---" IS NOT A TABLE. MAKE SURE "|" IS NOT USED
				// -------------------------------------------------------------

				// code paragraph
				// --------------
				if substr(`trim'(`"`macval(line)'"'),1,3) == "~~~" {
						file write `knot' _n "{asis}" _n 
						file read `hitch' line
						while r(eof) == 0 & substr(`trim'(`"`macval(line)'"'),1,3) != "~~~" {
							local line : subinstr local line "	" "{space 4}", all // convert tab to spaces
							file write `knot' `"     `macval(line)'"' _n 
							file read `hitch' line
						}
						file write `knot' "{smcl}" _n 
						file read `hitch' line
				}
				// Heading
				// -------
				else if substr(`trim'(`"`macval(line)'"'),1,3) == "===" |		///
					substr(`trim'(`"`macval(line)'"'),1,3) == "---" & 				///
					strpos(`"`macval(line)'"', "|") == 0 {
						file write `knot' _n `"{title:`macval(preline)'}"' _n 
						file read `hitch' line
				}
				
				// -------------------------------------------------------------
				// If heading is not found, process the chunk
				// -------------------------------------------------------------
				else {
					
					// check for Markdown paragraph syntax 
					// ---------------------------------------------------------
					if substr(`trim'(`"`macval(preline)'"'),1,4) != "***/" {
						
						//Check for Paragraph code
						if substr(`trim'(`"`macval(preline)'"'),1,1) == ">" {
							
							if substr(`trim'(`"`macval(preline)'"'),1,1) == ">" {
								file write `knot' "{p 8 8 2}" _n
								local preline : subinstr local preline ">" "" 
							}			
						}
						
						file write `knot' `"`macval(preline)'"' _n
					}
					
					if substr(`trim'(`"`macval(line)'"'),1,4) != "***/"  {
						local preline `"`macval(line)'"'
						
						//remove white space in old-fashion way!
						cap local m : display "`line'"
						if _rc == 0 & missing(trim("`m'")) {
							local line ""
						}
					}	
				}			
			}
			file read `hitch' line
		}

		file read `hitch' line
		
	}
	file close `knot'
	
	
	tempfile tmp1
	quietly copy "`tmp'" "`tmp1'", replace
	if !missing("`debug'") copy "`tmp'" tmp1.txt, replace
	
	

	
	
	
	// -----------------------------------------------------------------
	// Create lines and headers
	// ================================================================= 
	tempname hitch knot 
	qui file open `hitch' using `"`tmp1'"', read
	qui file open `knot' using `"`tmp'"', write replace
	file read `hitch' line
	local preline 0
	while r(eof) == 0 {	
		
		//Check for Paragraph code AUTOMATICALLY
		if missing(`trim'(`"`macval(preline)'"')) & 		///
		substr(`"`macval(preline)'"',1,4) != "    " {
			
			if substr(`"`macval(line)'"',1,1) != " " {
				if substr(`trim'(`"`macval(line)'"'),1,4) == "{bf:" ///
				| substr(`trim'(`"`macval(line)'"'),1,8) == "{browse " ///
				| substr(`trim'(`"`macval(line)'"'),1,4) == "{it:" ///
				| substr(`trim'(`"`macval(line)'"'),1,4) == "{ul:" { 
					file write `knot' "{p 4 4 2}" _n
				}
				else if substr(`trim'(`"`macval(line)'"'),1,1) != "{" 			///
				& !missing(`trim'(`"`macval(line)'"')) 							///
				& substr(`trim'(`"`macval(line)'"'),1,1) != "|" 				///
				& substr(`trim'(`"`macval(line)'"'),1,1) != "+" {
					file write `knot' "{p 4 4 2}" _n
				}
			}					
		}

		foreach l in line {
							
			// Create Markdown Horizontal line
			// -----------------------------------------------------
			if substr(`trim'(`"`macval(`l')'"'),1,5) == "- - -" ///
			& `trim'(`"`macval(`l')'"') == "- - -" {
				local `l' : subinstr local `l' "- - -" "    {hline}" 
			}
			
			// Secondary syntax for headers
			// -----------------------------------------------------
			cap if substr(`trim'(`"`macval(`l')'"'),1,2) == "# " {
				local `l' : subinstr local `l' "# " "", all
				local `l'  "{title:`l'}"
			}
			else if substr(`trim'(`"`macval(`l')'"'),1,3) == "## " {
				local `l' : subinstr local `l' "## " "", all
				local `l'  "{title:`l'}"
			}
			
			
							
			//conver ascii lines to a straight line
			/*
			local i 90
			while `i' > 1 {
				local j : display _dup(`i') "-"
				local j2 : display _dup(`i') "="
				local `l' : subinstr local `l' "`j'" "{hline `i'}", all
				if substr(`trim'(`"`macval(line)'"'),1,5) != "===" {
					local `l' : subinstr local `l' "`j2'" "{hline `i'}", all
				}
				local i `--i'
			}
			*/
			
			local preline `"`macval(line)'"'				
		}		
							
		file write `knot' `"`macval(line)'"' _n
		file read `hitch' line
	}
	//ADD ADDITIONAL LINE
	file write `knot' _n
	file close `knot'
	
	// ALWAYS CREATE THE TEMPFILE BEFORE REPLACING AN EXISTING ONE
	tempfile tmp1
	quietly copy "`tmp'" "`tmp1'", replace	
	if !missing("`debug'") copy "`tmp'" tmp2.txt, replace
	
	// -----------------------------------------------------------------
	// Create tables
	// ================================================================= 
	tempfile tmp
	tempname hitch knot 
	qui file open `hitch' using `"`tmp1'"', read
	qui file open `knot' using `"`tmp'"', write replace
	file read `hitch' line
	local preline 0
	while r(eof) == 0 {	
		
		if substr(`trim'(`"`macval(line)'"'),1,1) == "|" {
			// Markdown tables
			// -----------------------------------------------------
			if substr(`trim'(`"`macval(line)'"'),1,5) == "|----"  | ///
				 substr(`trim'(`"`macval(line)'"'),1,5) == "|:---"  | ///
				 substr(`trim'(`"`macval(line)'"'),1,6) == "| ----" | ///
				 substr(`trim'(`"`macval(line)'"'),1,6) == "| :---" {
				 

				 local firstline 1
				 
				 //get the number of columns, and their width (except the last one)
				local columns = subinstr(`"`macval(line)'"', "-", "", .)
				local columns = subinstr(`"`macval(columns)'"', ":", "", .)
				local columns = subinstr(`"`macval(columns)'"', " ", "", .)
				local columns = length(`trim'("`columns'")) - 1
				local activecol = `columns' - 1
				local tablewidth = length(`trim'(`"`macval(line)'"')) - `columns' - 1
				
				if !missing("`debug'") display "`columns' columns were found"
				
				//Write the header row
				// {it:Option} {col 17} {it:Description}
				
				local i = 0
				tokenize `"`macval(line)'"', parse("|")
				local col = 0
				local total = 0
				while `"`macval(1)'"' != "" {
					if `"`macval(1)'"' != "|" {
						local i = `i' + 1
						local total = length(`"`macval(1)'"')  + `total'
						local width`i' =  `total'
						
					}
					macro shift
				}	
				
				// deside the width of the table
				 
				 
				
				local i = 0
				tokenize `"`macval(preline)'"', parse("|")
				while `"`macval(1)'"' != "" {
					if `"`macval(1)'"' != "|" {
						
						// remove white space from the table
						capture local TRIM = trim(`"`macval(1)'"')
						if _rc == 0 local 1 `TRIM'
						local TRIM //RESET
						
						if "`i'" == "0" {
							file write `knot'  `"{col 5}`macval(1)'"' 
						}
						else {
							local j : di `width`i'' + 5
							file write `knot' `"{col `j'}`macval(1)'"' 
						}
						local i = `i' + 1
					}
					macro shift
				}

				if !missing("`width`i''") {
					file write `knot' _n

					if `tablewidth' >= 80 file write `knot' "{space 4}{hline}" _n
					else file write `knot' "{space 4}{hline `tablewidth'}" _n
				}
				else if !missing("`firstline'") {
					if `tablewidth' >= 80 file write `knot' "{space 4}{hline}" _n
					else file write `knot' "{space 4}{hline `tablewidth'}" _n
				}
			}
			else if !missing("`firstline'") {
				while r(eof) == 0 & length(`trim'(`"`macval(line)'"')) > 1 {
					local i = 0
					tokenize `"`macval(line)'"', parse("|")
					while `"`macval(1)'"' != "" {
						if `"`macval(1)'"' != "|" {
							
							// remove white space from the table
							capture local TRIM = trim(`"`macval(1)'"')
							if _rc == 0 local 1 `TRIM'
							local TRIM //RESET
							
							if "`i'" == "0" {
								file write `knot'  `"{col 5}`macval(1)'"' 
							}
							else {
								local j : di `width`i'' + 5
								file write `knot' `"{col `j'}`macval(1)'"' 
							}
							local i = `i' + 1
						}
						macro shift
					}
					if !missing("`width`i''") {
						file write `knot' _n
						*file write `knot' "{space 4}{hline}"
					}
					file read `hitch' line
				}
				
				if `tablewidth' >= 80 {
					file write `knot' "{space 4}{hline}" _n
				}
				else file write `knot' "{space 4}{hline `tablewidth'}" _n
				
				local firstline //reset
			}
		}
		
		else {
			file write `knot' `"`macval(line)'"' _n
		}
		
		local preline `"`macval(line)'"'	
		file read `hitch' line
	}
	
	//ADD ADDITIONAL LINE
	file write `knot' _n
	file close `knot'
	
	// ALWAYS CREATE THE TEMPFILE BEFORE REPLACING AN EXISTING ONE
	tempfile tmp1
	quietly copy "`tmp'" "`tmp1'", replace	
	
	
	quietly copy "`tmp'" "`convert'", `replace'	
	//quietly copy "`tmp'" "$localfile", `replace'	
	capture macro drop localfile
	
	// -----------------------------------------------------------------
	// Print the output 
	// ================================================================= 
	confirm file "`convert'"
	if _rc == 0 {
		di as txt "{p}(MarkDoc created "`"{bf:{browse "`convert'"}})"' _n
	}
	else display as err "MarkDoc could not produce `convert'" _n
		
end


