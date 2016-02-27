/*

					   Developed by E. F. Haghish (2014)
			  Center for Medical Biometry and Medical Informatics
						University of Freiburg, Germany
						
						  haghish@imbi.uni-freiburg.de
								   
                       * MarkDoc comes with no warranty *

	
	
	markdown program
	================
	
	This program is a part of MarkDoc package, a general purpose program for 
	literate programming in Stata. This program generates converts Markdown 
	syntax to SMCL, by returning an rclass named r(md) 
 
	3.6.7  February,  2016
*/


program define markdown, rclass
	
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
	
	// Avoid string quotations and also grave accesnts
	// -------------------------------------------------------------------------
	*local 0 : subinstr local 0 `"""' "{c 34}", all
	local 0 : subinstr local 0 "`" "{c 96}", all
	local 0 : subinstr local 0 "'" "{c 39}", all
	*local 0 : subinstr local 0 "=" "{c 61}", all
	
	// Text styling
	// -------------------------------------------------------------------------
	forvalues i = 1/27 {
		local 0 : subinstr local 0 "___" "{ul:"
		local 0 : subinstr local 0 "___" "}"
	}
	forvalues i = 1/27 {
		local 0 : subinstr local 0 "__" "{bf:"
		local 0 : subinstr local 0 "__" "}"
	}							
	forvalues i = 1/27 {
		local 0 : subinstr local 0 "_" "{it:"
		local 0 : subinstr local 0 "_" "}"
	}
	
	// Secondary syntax for headers
	// -------------------------------------------------------------------------
	if substr(`trim'(`"`macval(line)'"'),1,2) == "# " {
		local 0 : subinstr local 0 "# " "", all
		local 0  "{title:`0'}"
	}
	else if substr(`trim'(`"`macval(line)'"'),1,3) == "## " {
		local 0 : subinstr local 0 "## " "", all
		local 0  "{title:`0'}"
	}
	
	// Simple ASCII to SMCL tables
	// -------------------------------------------------------------------------
	
	/*
	local 0 : subinstr local 0 "|" "{c |}", all
	local 0 : subinstr local 0 "-+-" "{c -}{c +}{c -}", all

	//THIS IS SMARTER, BUT SLOWER
	
	
	local i 80
	while `i' > 1 {
		local line : display _dup(`i') "-"
		local 0 : subinstr local 0 "`line'" "{hline `i'}"
		local i `--i'
	}
	*/
	
	
	// Create Markdown Horizontal line
	// -------------------------------------------------------------------------
	if `trim'(`"`macval(0)'"') == "- - -" {
		local 0 : subinstr local 0 "- - -"  "    {hline}" 
	}
	
	// Create SMCL Tab
	// -------------------------------------------------------------------------
	if `trim'(`"`macval(0)'"') != "- - -" &										///
	substr(`trim'(`"`macval(0)'"'),1,5) == "- - -" {
		local 0 : subinstr local 0 "- - -" "{dlgtab:" 
		local 0 = `"`macval(0)' "' + "}"
	}
						
						
	return local md `0'
	
end
