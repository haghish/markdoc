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
 
	3.6.7  February,  2016
*/


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
	

	// -----------------------------------------------------------------
	// EXTRACT NOTATIONS 
	// ================================================================= 
	while r(eof) == 0 {	
		
		if substr(`trim'(`"`macval(line)'"'),1,4) == "/***" &				///
		substr(`trim'(`"`macval(line)'"'),1,26) != "/*** DO NOT EDIT THIS LINE" | ///
		substr(`trim'(`"`macval(line)'"'),1,5) == "/***$" {
			
			file read `hitch' line
			while r(eof) == 0 & substr(`trim'(`"`macval(line)'"'),1,4) != "***/" {
				
				if substr(`trim'(`"`macval(line)'"'),1,1) == ":" {			
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
	
	quietly copy "`tmp'" "$localfile", `replace'		
		
	
end
