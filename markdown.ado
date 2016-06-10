/*

					   Developed by E. F. Haghish (2014)
			  Center for Medical Biometry and Medical Informatics
						University of Freiburg, Germany
						
						  haghish@imbi.uni-freiburg.de
								   
                       * MarkDoc comes with no warranty *

	
	
	markdown program
	================
	
	This program is a part of MarkDoc package, a general purpose program for 
	literate programming in Stata. markdown command generates converts Markdown 
	syntax to SMCL, by returning an rclass named r(md) 
 
	3.7.0  June,  2016
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
	
	
	// Hyperlink
	// -------------------------------------------------------------------------
	if strpos(`"`macval(0)'"', "](") != 0 {
		local a = strpos(`"`macval(0)'"', "](")
		local 0 : subinstr local 0 "](" " "
		local l1 = substr(`"`macval(0)'"',1,`a') 
		local l2 = substr(`"`macval(0)'"',`a'+1,.) 
		*di as err "l1: `l1'"
		*di as err "l2: `l2'"
		
		// Extract the image syntax & link text
		if strpos(`"`macval(l1)'"', "![") != 0 {
			local a = strpos(`"`macval(l1)'"', "![")
			local l1 : subinstr local l1 "![" " "
			local text = substr(`"`macval(l1)'"',1,`a') 
			local hypertext = substr(`"`macval(l1)'"',`a'+1,.) 
			local image 1
		}
		else if strpos(`"`macval(l1)'"', "[") != 0 {
			local a = strpos(`"`macval(l1)'"', "[")
			local l1 : subinstr local l1 "[" " "
			local text = substr(`"`macval(l1)'"',1,`a') 
			local hypertext = substr(`"`macval(l1)'"',`a'+1,.) 
			*di as err "text: `text'"
			*di as err "hypertext: `hypertext'"
		}
		
		//Extract the name
		if strpos(`"`macval(l2)'"', ")") != 0 {
			local a = strpos(`"`macval(l2)'"', ")")
			local l2 : subinstr local l2 ")" " "
			local link = substr(`"`macval(l2)'"',1,`a') 
			local rest = substr(`"`macval(l2)'"',`a'+1,.) 
			*di as err "link: `link'"
			*di as err "rest: `rest'"
		}
		
		if "`image'" != "1" {
			local 0 : di `"`macval(text)' {browse "`macval(link)'":`macval(hypertext)'} `macval(rest)'"'
		}
		else {
			local 0 : di `"`macval(text)' `macval(rest)'"'
		}
	}
	
	// Text styling
	// -------------------------------------------------------------------------
	forvalues i = 1/27 {
		*local 0 : subinstr local 0 "______" "}}{bf:"
	}
	
	forvalues i = 1/27 {
		local 0 : subinstr local 0 "____" "{bf:{ul:"
		local 0 : subinstr local 0 "____" "}}"
	}
	
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
	if substr(`trim'(`"`macval(0)'"'),1,2) == "# " {
		local 0 : subinstr local 0 "# " ""
		local 0  "{title:`0'}"
	}
	else if substr(`trim'(`"`macval(0)'"'),1,3) == "## " {
		local 0 : subinstr local 0 "## " ""
		local 0  "{title:`0'}"
	}
	else if substr(`trim'(`"`macval(0)'"'),1,4) == "### " {
		local 0 : subinstr local 0 "### " ""
		local 0  "{title:`0'}"
	}
	else if substr(`trim'(`"`macval(0)'"'),1,5) == "#### " {
		local 0 : subinstr local 0 "#### " ""
		local 0  "{title:`0'}"
	}

	
	
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
						
						
	return local md `"`macval(0)'"'
	
end


