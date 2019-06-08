/*

					   Developed by E. F. Haghish (2014)
			  Center for Medical Biometry and Medical Informatics
						University of Freiburg, Germany
						
						  haghish@imbi.uni-freiburg.de
								   
                       * MarkDoc comes with no warranty *

	
	
	markup program
	===============
	
	This program is a part of MarkDoc package, a general purpose program for 
	literate programming in Stata. extracts the documentation notations written 
	in script files and create a document that can be typesseted. 
 
	3.7.0  February,  2016
*/
*capture program drop markup
program define markup
	
	// NOTE:
	// Stata 14 introduces ustrltrim function for removing Unicode whitespace 
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
	Export(name) 	 /// specifies the exported format 
	localfile(str)	 /// save the output in a local file, if available
	debug            ///
	]
	
	
	
	
	
	// -------------------------------------------------------------------------
	// Syntax Processing
	// =========================================================================
	
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
	
	confirm file "`script'"

	
	************************************************************************	
	*
	* MAIN ENGINE 
	* -----------
	*
	* Part 1- create a temporary file to include the text chunks
	************************************************************************
	
	
	// -------------------------------------------------------------------------
	// Part 1: Adding the template 
	// =========================================================================
	tempfile tmp 
	tempname hitch knot 
	qui file open `hitch' using `"`script'"', read
	qui file open `knot' using `"`tmp'"', write replace
	file read `hitch' line
	local i  1
	
	// -----------------------------------------------------------------
	// EXTRACT NOTATIONS 
	// ================================================================= 
	while r(eof) == 0 {	
		
		local passtitle
		
		capture if substr(`trim'(`"`macval(line)'"'),1,26) == "/*** DO NOT EDIT THIS LINE" {
			local passtitle 1
			file read `hitch' line
		}
		
		while !missing("`passtitle'") {
			*file read `hitch' line
			
			local titlefound 1
			
			// Get the package title
			if substr(`trim'(`"`macval(line)'"'),1,6) == "Title:" {
				local line : subinstr local line "Title:" ""
				local t = `trim'("`line'")
				if !missing("`t'") local title "`t'"
				
				file write `knot' "> __`title':__ "
			}
			
			if substr(`trim'(`"`macval(line)'"'),1,12) == "Description:" {
				local line : subinstr local line "Description:" ""
				local description = `trim'("`line'")
				if !missing(`"`macval(description)'"') {
					
	
					md2smcl `"`macval(description)'"'
					local description `r(md)'	
					file write `knot' "`description'" _n
					file read `hitch' line
					
					while substr(`trim'(`"`macval(line)'"'),55,21) != "DO NOT EDIT THIS LINE" ///
					& r(eof) == 0 {
						*local line2 = `trim'(`"`macval(line)'"')
						local line2 = `"`macval(line)'"'
						md2smcl `"`macval(line2)'"'
						file write `knot' `"`r(md)'"' _n
						file read `hitch' line
					}
				}
				
			}
			
		
			if substr(`trim'(`"`macval(line)'"'),55,21) == "DO NOT EDIT THIS LINE" {
				local passtitle		//exit the loop
			}
			else file read `hitch' line
		}
		
		
		local pass										// reset
		capture if substr(`trim'(`"`macval(line)'"'),1,4) == "/***" &			///
		substr(`trim'(`"`macval(line)'"'),1,26) != 								///
		"/*** DO NOT EDIT THIS LINE" & 											///
		substr(`trim'(`"`macval(line)'"'),1,5) != "/***$" {
			local pass 1
			file read `hitch' line
		}	
		
		
		if !missing("`pass'") {

			
			*while r(eof) == 0 & substr(`trim'(`"`macval(line)'"'),1,4) != "***/" {
			while r(eof) == 0 & trim(`"`macval(line)'"') != "***/" {
				
				
				
				if substr(`trim'(`"`macval(line)'"'),1,2) == ": " {			
					local line : subinstr local line ": " "" 
				}
				else if substr(`trim'(`"`macval(line)'"'),1,1) == ":" {			
					local line : subinstr local line ":" "" 
				}
				
				if substr(`trim'(`"`macval(line)'"'),1,9) == "{p 4 4 2}" 	///
				| substr(`trim'(`"`macval(line)'"'),1,9) == "{p 8 8 2}" {			
					file read `hitch' line
				}
				
				//avoid tabs
				if substr(`trim'(`"`macval(line)'"'),1,5) == "- - -" {
					local line "- - -"
				}
				
				file write `knot' `"`macval(line)'"' _n
				file read `hitch' line
			}
		}
		
		file read `hitch' line
	}
	

	file close `knot'
	
	if !missing("`debug'") {
		quietly copy "`tmp'" 0markup.txt, replace
	}
	quietly copy "`tmp'" "$localfile", `replace'		
		
	
end
