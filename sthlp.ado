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
 
	3.6.8  March,  2016
*/

cap program drop sthlp

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
	ASCIItable		 /// convert ASCII tables to SMCL in dynamic help files
	TITle(str)   	 /// specifies the title of the document (for styling)
	AUthor(str)  	 /// specifies the author of mthe document (for styling)
	AFFiliation(str) /// specifies author affiliation (for styling)
	ADDress(str) 	 /// specifies author contact information (for styling)
	Date			 /// Add the document generation date to the document
	SUMmary(str)     /// writing the summary or abstract of the report
	]
	
	
	// -------------------------------------------------------------------------
	// Syntax Processing
	// =========================================================================
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
	
	confirm file "`script'"
	
	// If the template is not "empty", then make sure other locals are ""
	if "`template'" != "empty" {
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
	
	if "`template'" != "empty" & substr(`trim'(`"`macval(line)'"'),1,26) != 		///
	"/*** DO NOT EDIT THIS LINE" {
		file write `knot' 														///
		"/*** DO NOT EDIT THIS LINE -----------------------------------------------------" _n ///
		"" _n																	///
		"Version: 0.0.0" _n														///
		"" _n(2)																///																
		"Intro Description" _n													///
		"=================" _n(2)												///
		"packagename -- A new module for ... "	_n(3)							/// 
		"Author(s)" _n															///
		"=================" _n(2)												///
		"Author name ..." _n													///
		"Author affiliation ..." _n												///
		"to add more authors, leave an empty line between authors' information" _n(2) ///
		"Second author ..." _n													///
		`"For more information visit {browse "http://www.haghish.com/markdoc":MarkDoc homepage}"' _n(3) ///
		"Syntax" _n																///
		"=================" _n(2)												///
		"{opt exam:ple} {depvar} [{indepvars}] {ifin} using " _n				///
		"[{it:{help filename:filename}}]" _n									///
		"[{cmd:,} {it:options}]" _n(2)											///
		"{synoptset 20 tabbed}{...}" _n											///
		"{synopthdr}" _n														///
		"{synoptline}" _n														///
		"{synopt :{opt rep:lace}}replace this example{p_end}" _n				///
		"{synopt :{opt app:end}}work further on this help file{p_end}" _n 		///
		"{synopt :{opt addmore}}you can add more description for the options; Moreover, " _n ///
		"	the text you write can be placed in multiple lines {p_end}" _n		///
		"{synopt :{opt learn:smcl}}you won't make a loss learning" _n			///
		"{help smcl:SMCL Language} {p_end}" _n 									///
		"{synoptline}" _n														///
		"----------------------------------------------------- DO NOT EDIT THIS LINE ***/" _n(2) ///
		`"* Note: If you like to leave the "Intro Description" or "Author(s) section"' _n ///
		 "* 		empty, erase the text but KEEP THE HEADINGS" _n(4)			
		 
		 
		file write `knot' `"`macval(line)'"' _n 
		
		while r(eof) == 0 {
			file read `hitch' line
			file write `knot' `"`macval(line)'"' _n 
		}

		file write `knot' 														///
		"/***" _n 																///															
		"Example" _n															///
		"=================" _n(2)												///
		"    explain what it does" _n											///
		"        . example command" _n(2)										///
		"    second explanation" _n												///
		"        . example command" _n											///
		"***/" _n(4)
		
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
	// Part 2: Reading the template and the ado-file documentation! 
	// =========================================================================
	tempfile tmp 
	tempname hitch knot 
	qui file open `hitch' using `"`script'"', read
	qui file open `knot' using `"`tmp'"', write replace
	file write `knot'  "{smcl}" _n 
	file read `hitch' line
	
	local i 0
	local i2 0
	
	//Reading the header, if the HEADER EXISTS and the TEMPLATE IS NOT EMPTY
	if substr(`trim'(`"`macval(line)'"'),1,26) == "/*** DO NOT EDIT THIS LINE" 	///
	& "`template'" != "empty" {
		
		while substr(`trim'(`"`macval(line)'"'),55,21) != "DO NOT EDIT THIS LINE" ///
		& r(eof) == 0 & missing("`exitloop'") {
			
			// Version
			if substr(`trim'(`"`macval(line)'"'),1,8) == "Version:" {
				local line : subinstr local line "Version:" ""
				local v = `trim'("`line'")
				local version "version `v'"
			}
			
			//Description
			if substr(`trim'(`"`macval(line)'"'),1,17) == "Intro Description" {
				file read `hitch' line
				if substr(`"`macval(line)'"',1,3) == "===" {
					file read `hitch' line
				}
				
				while missing(`"`macval(line)'"') {
					file read `hitch' line
				}
				
				while substr(`trim'(`"`macval(line)'"'),1,6) 					///
				!= "Author" & r(eof) == 0 {
					local line2 = `trim'(`"`macval(line)'"')
					local description "`description' `line2'"
					file read `hitch' line
				}
				
				// Edit the package description
				// -------------------------------------------------------------
				tokenize `"`macval(description)'"', parse("--")
				local description : subinstr local description "`1'" "{bf:`1'}"
				local description : subinstr local description "--" "{hline 2}"
				
				
				markdown `description'
				local description `r(md)'
				
				/*
				// Markdown styling syntax
				forvalues i = 1/27 {
					local preline : subinstr local preline "___" "{ul:"
					local preline : subinstr local preline "___" "}"
				}
				forvalues i = 1/27 {
					local preline : subinstr local preline "__" "{bf:"
					local preline : subinstr local preline "__" "}"
				}							
				forvalues i = 1/27 {
					local preline : subinstr local preline "_" "{it:"
					local preline : subinstr local preline "_" "}"
				}
				*/
			}
			
			//Authors
			if substr(`trim'(`"`macval(line)'"'),1,6) == "Author" {
				file read `hitch' line
				if substr(`"`macval(line)'"',1,3) == "===" {
					file read `hitch' line
				}
				while missing(`trim'(`"`macval(line)'"')) {
					file read `hitch' line
				}
				
				//make sure it's not empty
				if substr(`trim'(`"`macval(line)'"'),1,6) != "Syntax" {
					
					while substr(`trim'(`"`macval(line)'"'),1,6) 			///
					!= "Syntax" {

						if !missing("`author0'") & missing(`"`macval(line)'"') {
							
							while missing(`trim'(`"`macval(line)'"')) {
								file read `hitch' line
							}
							
							if substr(`trim'(`"`macval(line)'"'),1,6) 		///
							!= "Syntax" {
								local author`i' = `trim'("{p 4 4 2}")
								local i `++i'
							}	
						}
						
						if substr(`trim'(`"`macval(line)'"'),1,6) 			///
						!= "Syntax" {
							
							markdown `line'
							local line `r(md)'
							
							

							local author`i' = `trim'(`"`macval(line)'"')
							file read `hitch' line	
							local i `++i'
						}	
					}
				}
			}
			
			
			//Syntax
			if substr(`trim'(`"`macval(line)'"'),1,6) == "Syntax" {
				file read `hitch' line
				if substr(`"`macval(line)'"',1,3) == "===" {
					file read `hitch' line
				}
				while missing(`"`macval(line)'"') {
					file read `hitch' line
				}
				
				//make sure it's not empty
				if substr(`trim'(`"`macval(line)'"'),55,21) != 					///
				"DO NOT EDIT THIS LINE" {
					
					while substr(`trim'(`"`macval(line)'"'),55,21) 				///
					!= "DO NOT EDIT THIS LINE" {
						
						local syntax`i2' = `trim'(`"`macval(line)'"')
						file read `hitch' line
						local i2 `++i2'
						
						local exitloop 1
					}
				}
			}
			
		file read `hitch' line
		}
	}
	
	// If the template is in use
	if "`template'" != "empty" {
		if !missing("`date'") {
			local releasDate: di c(current_date)
			file write `knot' "{right:`version', `releasDate'}" _n
		}
		else file write `knot' "{right:`version'}" _n
		
		if !missing(`"`macval(description)'"') {
			file write `knot' "{title:Title}" _n(2) "{phang}" _n				///
			`"`macval(description)'"'
		}
		
		if !missing("`author0'") {
			file write `knot' _n(3) "{title:Author}" _n "`author'" _n 			///
			"{p 4 4 2}" _n 
			
			local i `--i'
			forval j = 0/`i' {
				if `"`macval(author`j')'"' == "{p 4 4 2}"  file write `knot' _n ///
				"{p 4 4 2}" _n
				
				else file write `knot' `"`macval(author`j')'{break}"'  _n
			}
		}
		
		if !missing("`syntax0'") {
			file write `knot' _n(2) "{title:Syntax}" _n(2) 						///
			"{p 8 16 2}" _n 
			
			forval j = 0/`i2' {
				if "`syntax`j''" == "{p 8 16 2}"  file write `knot' _n
				file write `knot' `"`macval(syntax`j')'"'  _n
			}
		}
	}	
	
	// If the template is NOT in use
	if "`template'" == "empty" {
		if !missing("`date'") {
			local releasDate: di c(current_date)
			file write `knot' "{right:`releasDate'}" _n
		}
		if !missing("`title'") | !missing("`summary'") {
			
			if missing("`title'") local title commandname
			if missing("`summary'") local summary describe the comand...
			
			file write `knot' "{title:Title}" _n(2) "{phang}" _n				///
			`"`title' {hline 2} `summary'"' _n(2)
		}
		
		if !missing("`author'") | !missing("`affiliation'") | 					///
		!missing("`address'") {
			
			file write `knot' _n "{title:Author}" _n(2) "{p 4 4 2}" _n			
			
			if !missing("`author'") file write `knot' `"`author'{break}"' _n
			if !missing("`affiliation'") file write `knot' 						///
			`"`affiliation'{break}"' _n
			if !missing("`address'") file write `knot' `"`address'{break}"' _n
		}
	}
	
	
	
	
	
	// -------------------------------------------------------------------------
	// Part 3: Prepare ASCII to SMCL table conversion
	// =========================================================================
	
	while r(eof) == 0 {	
		
		if substr(`trim'(`"`macval(line)'"'),1,4) == "/***" &				///
		substr(`trim'(`"`macval(line)'"'),1,26) != 							///
		"/*** DO NOT EDIT THIS LINE" | 											///
		substr(`trim'(`"`macval(line)'"'),1,5) == "/***$" {
			
			file read `hitch' line
			
			//remove white space in old-fashion way!
			cap local m : display "`line'"
			if _rc == 0 & missing(trim("`m'")) {
				local line ""
				*di as err ">`line'<"
			}
			
			while r(eof) == 0 & substr(`trim'(`"`macval(line)'"'),1,4) 		///
			!= "***/" {
				
				//IF MISSING line, forward to the next non-missing line
				while missing(`"`macval(line)'"') & r(eof) == 0 {
					file write `knot' `"`macval(line)'"' _n
					file read `hitch' line
					
					//remove white space in old-fashion way!
					cap local m : display "`line'"
					if _rc == 0 & missing(trim("`m'")) {
						local line ""
						*di as err ">`line'<"
					}
				}
				
				////////////////////////////////////////////////////////////////
				// -------------------------------------------------------------
				
				
				//Interpret 3 lines at the time, for Markdown headings
				*local prepreline `"`macval(preline)'"'
				local preline `"`macval(line)'"'
				file read `hitch' line
				//local currentline `"`macval(line)'"'
				//file read `hitch' line
				//local postline `"`macval(line)'"'
				//local line `"`macval(currentline)'"' //stay on the current line
				
				
				if _rc == 0 & missing(trim("`m'")) {
					local line ""
					*di as err ">`line'<"
				}
					
				//remove white space in old-fashion way!
				cap local m : display "`line'"
				if _rc == 0 & missing(trim("`m'")) {
					local line ""
				}
		
				// -------------------------------------------------------------
				// IF MARKDOWN HEADING IS FOUND 
				// -------------------------------------------------------------
				if substr(`trim'(`"`macval(line)'"'),1,3) == "===" {
					file write `knot' _n `"{title:`macval(preline)'}"' _n 
				}
				
				// -------------------------------------------------------------
				// IF HEADING NOT FOUND
				// -------------------------------------------------------------
				else {
					
					// check for Markdown paragraph syntax 
					// ---------------------------------------------------------
					if substr(`trim'(`"`macval(preline)'"'),1,4) != "***/" &	///
					substr(`trim'(`"`macval(preline)'"'),1,3) != "===" {
						
						//Check for Paragraph code
						if substr(`trim'(`"`macval(preline)'"'),1,1) == ":" 	///
						| substr(`trim'(`"`macval(preline)'"'),1,1) == ">" {
							
							if substr(`trim'(`"`macval(preline)'"'),1,1) 	///
							== ">" {
								file write `knot' "{p 4 4 2}" _n
								local preline : subinstr local preline ">" "" 
							}
							else if substr(`trim'(`"`macval(preline)'"'),1,1) ///
							== ":" {
								file write `knot' "{p}" _n
								local preline : subinstr local preline ":" "" 
							}
							
							

							if !missing(`"`macval(line)'"') {
								local preline = `"`macval(preline)' "' + 		///
								`"`macval(line)'"'
						
								while !missing(`"`macval(line)'"') &			///
								substr(`trim'(`"`macval(line)'"'),1,4) 		///
								!= "***/" {
									file read `hitch' line
									
									//remove white space in old-fashion way!
									cap local m : display "`line'"
									if _rc == 0 & missing(trim("`m'")) {
										local line ""
									}
									
									local preline = `"`macval(preline)' "' + 	///
									`"`macval(line)'"'
								}
							}
							
							// Run Markdown
							// ---------------------------------------------
							*di as err `"p2:`preline'"'
							markdown `preline'
							if _rc == 0 local preline `r(md)'
							else {
								di as err "markdown.ado engine failed on "	///
								"the following line:" _n(2)
								di as txt `"`macval(preline)'"'
							}
							
							/*
							// Markdown styling syntax
							forvalues i = 1/27 {
								local preline : subinstr local preline "___" "{ul:"
								local preline : subinstr local preline "___" "}"
							}
							forvalues i = 1/27 {
								local preline : subinstr local preline "__" "{bf:"
								local preline : subinstr local preline "__" "}"
							}							
							forvalues i = 1/27 {
								local preline : subinstr local preline "_" "{it:"
								local preline : subinstr local preline "_" "}"
							}
							
							*/
							
						}
						
						*di as err "p3{bf:`preline'}"
						*di as err "p4{bf:`line'}"
						
						// this part is independent of the Marjdown engine
						// Create Markdown Horizontal line
						// =====================================================
						
						// CREATING THE ASCIITABLE, start with line
						
						//di as err "pre:`preline'"
						//di  `"cur:`line'"'
						//di  `"cur:`postline'"'
						
						*di as err "p :: `preline'"
						*di as err "  :: `line'"
						
						*di as err  "ppp:: `preprepreline'"
						*di as err "pp :: `prepreline'"
						*di as err "p  :: `preline'"
						*di as err "   :: `line'"
						local n = `c(linesize)' + 80
						
						while `n' > 0 & !missing("`asciitable'") {
							
							// Handling + in the line
							// =================================================
							if substr(`"`preline'"',`n',3) == "-+-" {
								// full + connected from above and below
								if substr(`"`line'"',`n'+1,1) == "|" &			///
								substr(`"`prepreline'"',`n'+1,1) == "|" {
									local preline1 = substr(`"`macval(preline)'"',1,`n'-1)
									local preline2 = substr(`"`macval(preline)'"',`n', .)
									//local preline2 : subinstr local preline2 "-+-" "-{c +}-"
									local preline2 : subinstr local preline2 "-+-" "-|-"
									local preline : di `"`macval(preline1)'"' `"`macval(preline2)'"'
								}
								* -|- -+- 
								
								// + connected above
								if substr(`"`prepreline'"',`n'+1,1) == "|" &			///
								substr(`"`line'"',`n'+1,1) != "|" {
									local preline1 = substr(`"`macval(preline)'"',1,`n'-1)
									local preline2 = substr(`"`macval(preline)'"',`n', .)
									//local preline2 : subinstr local preline2 "-+-" "-{c BT}-"
									local preline2 : subinstr local preline2 "-+-" "-B-"
									local preline : di `"`macval(preline1)'"' `"`macval(preline2)'"'
								}
								* -B- -{c BT}- 
								
								
								// + connected below
								if substr(`"`line'"',`n'+1,1) == "|" &			///
								substr(`"`prepreline'"',`n'+1,1) != "|" {
									local preline1 = substr(`"`macval(preline)'"',1,`n'-1)
									local preline2 = substr(`"`macval(preline)'"',`n', .)
									//local preline2 : subinstr local preline2 "-+-" "-{c TT}-"
									local preline2 : subinstr local preline2 "-+-" "-T-"
									local preline : di `"`macval(preline1)'"' `"`macval(preline2)'"'
								}
								* -T- -{c TT}- 
							}
							
							
							
							// Handling + in the corners
							// =================================================
							if substr(`"`preline'"',`n',2) == "-+"  &			///
							substr(`"`preline'"',`n',3) != "-+-"{
							
								
								if substr(`"`line'"',`n'+1,1) == "|" &			///
								substr(`"`prepreline'"',`n'+1,1) == "|" {
								
									local preline1 = substr(`"`macval(preline)'"',1,`n'-1)
									
									local preline2 = substr(`"`macval(preline)'"',`n', .)
									//local preline2 : subinstr local preline2 "-+" "-{c RT}"
									local preline2 : subinstr local preline2 "-+" "-!"
									local preline : di `"`macval(preline1)'"' `"`macval(preline2)'"'
								}
								* -! -{c RT} 
								
								
								// + connected above
								if substr(`"`prepreline'"',`n'+1,1) == "|" &			///
								substr(`"`line'"',`n'+1,1) != "|" {
									local preline1 = substr(`"`macval(preline)'"',1,`n'-1)
									local preline2 = substr(`"`macval(preline)'"',`n', .)
									//local preline2 : subinstr local preline2 "-+" "-{c BRC}"
									local preline2 : subinstr local preline2 "-+" "-;"
									local preline : di `"`macval(preline1)'"' `"`macval(preline2)'"'
								}
								* -2 -{c BRC} 
								
								
								// + connected below
								if substr(`"`line'"',`n'+1,1) == "|" &			///
								substr(`"`prepreline'"',`n'+1,1) != "|" {
									local preline1 = substr(`"`macval(preline)'"',1,`n'-1)
									local preline2 = substr(`"`macval(preline)'"',`n', .)
									//local preline2 : subinstr local preline2 "-+" "-{c TRC}"
									local preline2 : subinstr local preline2 "-+" "-]"
									local preline : di `"`macval(preline1)'"' `"`macval(preline2)'"'
									* -3 -{c TRC} 
								}
								
								
							}
							
							if substr(`"`preline'"',`n',2) == "+-" &			///
							substr(`"`preline'"',`n'-1,3) != "-+-"{
								
								// BOTH CONNECTIONS
								
								if substr(`"`line'"',`n',1) == "|" &			///
								substr(`"`prepreline'"',`n',1) == "|" {
								
									local preline1 = substr(`"`macval(preline)'"',1,`n'-1)
									local preline2 = substr(`"`macval(preline)'"',`n', .)
									//local preline2 : subinstr local preline2 "+" "{c LT}"
									local preline2 : subinstr local preline2 "+" "!"
									
									local preline : di `"`macval(preline1)'"' `"`macval(preline2)'"'
									* ! {c LT}
								}
								
								
								
								// + connected above
								if substr(`"`prepreline'"',`n',1) == "|" &			///
								substr(`"`line'"',`n',1) != "|" {
								
									local preline1 = substr(`"`macval(preline)'"',1,`n'-1)
									local preline2 = substr(`"`macval(preline)'"',`n', .)
									//local preline2 : subinstr local preline2 "+-" "{c BLC}-"
									local preline2 : subinstr local preline2 "+-" ":-"
									local preline : di `"`macval(preline1)'"' `"`macval(preline2)'"'
								}
								
								// + connected below
								if substr(`"`line'"',`n',1) == "|" &			///
								substr(`"`prepreline'"',`n',1) != "|" {
									local preline1 = substr(`"`macval(preline)'"',1,`n'-1)
									local preline2 = substr(`"`macval(preline)'"',`n', .)
									//local preline2 : subinstr local preline2 "+-" "{c TLC}-"
									local preline2 : subinstr local preline2 "+-" "[-"
									local preline : di `"`macval(preline1)'"' `"`macval(preline2)'"'
								}							
							}
							
							// Handling + in the corners
							// =================================================
							if substr(`"`line'"',`n'-1,3) == " | " &			///
							substr(`"`preline'"',`n'-1,3) == "---" {
								local preline1 = substr(`"`macval(preline)'"',1,`n'-1)
								local preline2 = substr(`"`macval(preline)'"',`n', .)
								local preline2 : subinstr local preline2 "-" "T"
								local preline : di `"`macval(preline1)'"' `"`macval(preline2)'"'
							}
							
							if substr(`"`preline'"',`n'-1,3) == " | " &			///
							substr(`"`line'"',`n'-1,3) == "---" {
								local line1 = substr(`"`macval(line)'"',1,`n'-1)
								local line2 = substr(`"`macval(line)'"',`n', .)
								local line2 : subinstr local line2 "-" "B"
								local line : di `"`macval(line1)'"' `"`macval(line2)'"'
							}
							
							
				
							
							local n `--n'
						}
						
						
						file write `knot' `"`macval(preline)'"' _n
					}
					
				
					if substr(`trim'(`"`macval(line)'"'),1,4) != "***/"  {
						
						local preprepreline `"`macval(prepreline)'"'
						local prepreline `"`macval(preline)'"'
						local preline `"`macval(line)'"'
						
						
						
*						file write `knot' `"`macval(line)'"' _n
						*file read `hitch' line
						
						//remove white space in old-fashion way!
						cap local m : display "`line'"
						if _rc == 0 & missing(trim("`m'")) {
							local line ""
						}
						
					}	
				}
			
			*local preprepreline `"`macval(prepreline)'"'
			*local prepreline `"`macval(preline)'"'
			
			}
		}
		
		// code line 
		
		file read `hitch' line
		
	}
	file close `knot'
	
	
	tempfile tmp1
	quietly copy "`tmp'" "`tmp1'", replace
	quietly copy "`tmp'" me.txt, replace
	
	
	
	// -----------------------------------------------------------------
	// Create the ASCII tables
	// ================================================================= 
	tempname hitch knot 
	qui file open `hitch' using `"`tmp1'"', read
	qui file open `knot' using `"`tmp'"', write replace
	file read `hitch' line
	while r(eof) == 0 {	
		
		if !missing("`asciitable'") {
			local line : subinstr local line "-|-" "-{c +}-"
			local line : subinstr local line "-B-" "-{c BT}-"
			local line : subinstr local line "-T-" "-{c TT}-", all
			local line : subinstr local line  "!-" "{c LT}-", all
			local line : subinstr local line "-!" "-{c RT}", all 
			local line : subinstr local line ":-" "{c BLC}-", all
			local line : subinstr local line "-;" "-{c BRC}", all
			local line : subinstr local line "[-" "{c TLC}-", all
			local line : subinstr local line  "-]" "-{c TRC}", all
			
			local line : subinstr local line "-| " "-{c RT} ", all
			local line : subinstr local line " |-" " {c LT}-", all
			local line : subinstr local line "|" "{c |}", all
		}
		
		foreach l in line {
							
			// Create SMCL Tab
			// -----------------------------------------------------
			if `trim'(`"`macval(`l')'"') != "- - -" &			///
				substr(`trim'(`"`macval(`l')'"'),1,5) == "- - -" {
				local `l' : subinstr local `l' "- - -" "{dlgtab:" 
				local `l' = `"`macval(`l')'"' + "}"
			}
							
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
							
							
							// Markdown styling syntax
								forvalues i = 1/27 {
									local `l' : subinstr local `l' "___" "{ul:"
									local `l' : subinstr local `l' "___" "}"
								}
								forvalues i = 1/27 {
									local `l' : subinstr local `l' "__" "{bf:"
									local `l' : subinstr local `l' "__" "}"
								}							
								forvalues i = 1/27 {
									local `l' : subinstr local `l' "_" "{it:"
									local `l' : subinstr local `l' "_" "}"
								}
							
							//local `l' : subinstr local `l' "|" "{c |}", all
							//local `l' : subinstr local `l' "-+-" "-{c +}-", all
							//local `l' : subinstr local `l' "+-" "{c TLC}-", all 
							//local `l' : subinstr local `l' "-+" "-{c TRC}", all 
							*local `l' : subinstr local `l' "-" "{c -}", all
							
							
							//Make it nicer
							local i 90
							while `i' > 1 {
								local j : display _dup(`i') "-"
								local `l' : subinstr local `l' "`j'" "{hline `i'}", all
								local i `--i'
							}
							
					}		
							
		file write `knot' `"`macval(line)'"' _n
		file read `hitch' line
	}
	file close `knot'
	quietly copy "`tmp'" "`tmp1'", replace
	quietly copy "`tmp'" me2.txt, replace
	
	
	
	
	
	
	
	
	
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


markdoc figure.ado, replace export(sthlp) template(empty) asciitable
