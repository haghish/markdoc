/*

					   Developed by E. F. Haghish (2014)
			  Center for Medical Biometry and Medical Informatics
						University of Freiburg, Germany
						
						  haghish@imbi.uni-freiburg.de
								   
                       * MarkDoc comes with no warranty *

	
	
	MarkDoc Package
	===============
	
	This ado file is a part of MarkDoc package and is called within markdoc.ado
	file to check if Pandoc is installed on the system correctly and is 
	accessible for MarkDoc package
	
	
	Engine
	------
	
	If the "INSTALL" option is specified and Pandoc is not installed on the 
	machine, then Pandoc is installed automatically. Otherwise, Stata will 
	print an error and provide the option to install Pandoc automatically 
	within Stata. 
*/
	
	
	
program define markdoccheck
	
	syntax [, INSTALl Test markup(str) pandoc(str) printer(str) export(name) style(name) ]
	
	version 11
	
	*save the current working directory
	qui global location "`c(pwd)'"
		
	****************************************************************************
	* MICROSOFT WINDOWS
	****************************************************************************
				
	if "`c(os)'" == "Windows" {
		
		// PANDOC
		// ------
		if "`pandoc'" == "" {
		
			cap quietly findfile pandoc.exe, path("`c(sysdir_plus)'Weaver\Pandoc")
			if "`r(fn)'" ~= "" {
				qui local location "`c(pwd)'"
				qui cd "`c(sysdir_plus)'"
				qui cd Weaver
				cap qui cd pandoc
				local d : pwd
				global pandoc : di "`d'\pandoc.exe"					
				qui cd "`location'"
			}
			
			if "`r(fn)'" == "" {
					
				//If the "Install option" is specified, install Pandoc if 
				//it is not already installed
					
				if `"`install'"'  == "install" {
					markdocpandoc , `test'
				}
					
				if `"`install'"'  ~= "install" {
					di as txt "{hline}" _n
					di as error "{bf:WARNING}"
					di as txt "{p}The {bf:Pandoc} software was not found on" ///
					" your machine. MarkDoc package cannot produce " ///
					"documents without this software." _n 
							
					di as txt `"{browse "http://www.haghish.com/packages/pandoc.php":    {c 149} Learn How To Installing Pandoc Manually}"'  
							
					di as txt "{stata markdocpandoc:    {c 149} Install Pandoc {bf:Automatically}}"	
					
					if "`export'" == "html" | "`export'" == "pdf"     ///
					   | "`export'" == "docx" | "`export'" == "md"      ///
						 | "`export'" == "sthlp" {
						 
						 di as txt _n "{p}Alternatively, you can add the "      ///
						 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:mini}} "' ///
						 "option to markdoc, which runs the engine in " ///
						 "light mode, independent of third-party software. " ///
						 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:read more about the mini option here...}} "' _n
					}
							
					di as txt "{hline}"	_n
					
					quietly error 1
				}
			}		
		}
			
		// WKHTMLTOPDF
		// -----------
		if "`printer'" == "" & "`export'" == "pdf" & "$printername" ~= "pdflatex" {
			
			// Search for wkhtmltopdf		
			cap quietly findfile wkhtmltopdf.exe, path("`c(sysdir_plus)'Weaver\wkhtmltopdf\bin")
			
			// if wkhtmltopdf exists
			if "`r(fn)'" ~= "" {
				qui local location "`c(pwd)'"
				qui cd "`c(sysdir_plus)'"
				qui cd Weaver
				qui cd wkhtmltopdf
				qui cd bin
				local d : pwd
				global setpath : di "`d'\wkhtmltopdf.exe"					
				qui cd "`location'"
			}
			
			// if it does not exist
			if "`r(fn)'" == "" {
					
				if `"`install'"'  == "install" {
					markdocwkhtmltopdf
				}
					
				if `"`install'"'  ~= "install" {
					di as txt "{hline}" _n
					di as error "{bf:WARNING}"
					di as txt "{p}The {bf:wkhtmltopdf} software was not found on" ///
					" your machine. MarkDoc package cannot produce " ///
					"PDF documents without this software." _n 
							
					di as txt `"{browse "http://www.haghish.com/packages/pdf_printer.php":    {c 149} Learn How To Install wkhtmltopdf PDF drivers Manually}"'  
					di as txt "{stata markdocwkhtmltopdf:    {c 149} Install wkhtmltopdf {bf:Automatically}}"		
					

					 di as txt _n "{p}Alternatively, you can add the "      ///
					 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:mini}} "' ///
					 "option to markdoc, which runs the engine in " ///
					 "light mode, independent of third-party software. " ///
					 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:read more about the mini option here...}} "' _n
					
							
					di as txt "{hline}"	_n
					
					quietly error 1
				}
			}
		}
	
		// SUPPLEMENTARY
		//--------------
		if "`export'" == "tex" & "`style'" == "stata" {
			cap quietly findfile sj.sty, path("`c(sysdir_plus)'Weaver\supplementary\stata")
			
			if "`r(fn)'" == "" {
					
				qui local location "`c(pwd)'"
		
				*GETTING THE PATH TO PANDOC
				qui cd "`c(sysdir_plus)'Weaver"
					
				cap qui copy "http://www.haghish.com/software/supplementary.zip" ///
				"supplementary.zip", replace
				cap qui unzipfile "supplementary", replace
				cap qui erase "supplementary.zip"
					
				*GO BACK TO THE WORKING DIRECTORY
				qui cd "`location'"
			}
		}
	
	}
	
	****************************************************************************
	* MACINTOSH 
	****************************************************************************
	if "`c(os)'" == "MacOSX" {
		
		// PANDOC
		// ------
		if "`pandoc'" == "" {
						
			cap quietly findfile pandoc, path("`c(sysdir_plus)'Weaver/Pandoc")
			
			if "`r(fn)'" ~= "" {
					
				qui local sub "`c(pwd)'"
		
				*GETTING THE PATH TO PANDOC
				qui cd "`c(sysdir_plus)'Weaver/Pandoc"
				local d : pwd
				global pandoc : di "`d'/pandoc"
					
				*GO BACK TO THE WORKING DIRECTORY
				qui cd "`sub'"
			}
			
			if "`r(fn)'" == "" {
					
				//If the "Install option" is specified, install Pandoc if 
				//it is not already installed
					
				if `"`install'"'  == "install" {
					markdocpandoc , `test'
				}
					
				if `"`install'"'  ~= "install" {
					di as txt "{hline}" _n
					di as error "{bf:WARNING}"
					di as txt "{p}The {bf:Pandoc} software was not found on" ///
					" your machine. MarkDoc package cannot produce " ///
					"documents without this software." _n 
							
					di as txt `"{browse "http://www.haghish.com/packages/pandoc.php":    {c 149} Learn How To Installing Pandoc Manually}"'  
							
					di as txt "{stata markdocpandoc:    {c 149} Install Pandoc {bf:Automatically}}"		
					
					if "`export'" == "html"   | "`export'" == "pdf"     ///
					   | "`export'" == "docx" | "`export'" == "md"      ///
						 | "`export'" == "sthlp" {
						 
						 di as txt _n "{p}Alternatively, you can add the "      ///
						 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:mini}} "' ///
						 "option to markdoc, which runs the engine in " ///
						 "light mode, independent of third-party software. " ///
						 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:read more about the mini option here...}} "' _n
					}
							
					di as txt "{hline}"	_n
					
					quietly error 1
							
				}
			}			
		}
			
	
		// WKHTMLTOPDF
		// -----------
		if "`printer'" == "" & "`export'" == "pdf" & "$printername" ~= "pdflatex" {
			
			// Search for wkhtmltopdf		
			cap quietly findfile wkhtmltopdf, path("`c(sysdir_plus)'Weaver/wkhtmltopdf")
			
			// if wkhtmltopdf exists
			if "`r(fn)'" ~= "" {
				qui local location "`c(pwd)'"
				qui cd "`c(sysdir_plus)'"
				qui cd Weaver
				qui cd wkhtmltopdf
				local d : pwd
				global setpath : di "`d'/wkhtmltopdf"					
				qui cd "`location'"									
			}
			
			// if it does not exist
			if "`r(fn)'" == "" {
					
				if `"`install'"'  == "install" {
					markdocwkhtmltopdf
				}
					
				if `"`install'"'  ~= "install" {
					di as txt "{hline}" _n
					di as error "{bf:WARNING}"
					di as txt "{p}The {bf:wkhtmltopdf} software was not found on" ///
					" your machine. MarkDoc package cannot produce " ///
					"PDF documents without this software." _n 
							
					di as txt `"{browse "http://www.haghish.com/packages/pdf_printer.php":    {c 149} Learn How To Installing PDF drivers Manually}"'  
					di as txt "{stata markdocwkhtmltopdf:    {c 149} Install wkhtmltopdf {bf:Automatically}}"		
		
					di as txt _n "{p}Alternatively, you can add the "      ///
					 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:mini}} "' ///
					 "option to markdoc, which runs the engine in " ///
					 "light mode, independent of third-party software. " ///
					 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:read more about the mini option here...}} "' _n
					
							
					di as txt "{hline}"	_n
					
					quietly error 1
				}
			}
		}
		
		// SUPPLEMENTARY
		//--------------
		if "`export'" == "tex" & "`style'" == "stata" {
			cap quietly findfile supplementary, path("`c(sysdir_plus)'Weaver")
			
			if "`r(fn)'" == "" {
					
				qui local location "`c(pwd)'"
		
				*GETTING THE PATH TO PANDOC
				qui cd "`c(sysdir_plus)'Weaver"
					
				cap qui copy "http://www.haghish.com/software/supplementary.zip" ///
				"supplementary.zip", replace
				cap qui unzipfile "supplementary", replace
				cap qui erase "supplementary.zip"
					
				*GO BACK TO THE WORKING DIRECTORY
				qui cd "`location'"
			}
		}
		
	}	
	
	
	****************************************************************************
	* UNIX 
	****************************************************************************
	if "`c(os)'" == "Unix" {
		
		if "`pandoc'" == "" {
			*Search for Pandoc			
			cap quietly findfile pandoc, path("`c(sysdir_plus)'Weaver/Pandoc")
			
			if "`r(fn)'" ~= "" {
					
				*save the current working directory
				qui local sub "`c(pwd)'"
	
				*GETTING THE PATH TO PANDOC
				qui cd "`c(sysdir_plus)'Weaver/Pandoc"
				local d : pwd
				global pandoc : di "`d'/pandoc"
					
				*GO BACK TO THE WORKING DIRECTORY
				qui cd "`sub'"
				}
			
			if "`r(fn)'" == "" {
					
				//If the "Install option" is specified, install Pandoc if 
				//it is not already installed
					
				if `"`install'"'  == "install" {
					markdocpandoc
				}
					
				if `"`install'"'  ~= "install" {
					di as txt "{hline}" _n
					di as error "{bf:WARNING}"
					di as txt "{p}The {bf:Pandoc} software was not found on" ///
					" your machine. MarkDoc package cannot produce " ///
					"documents without this software." _n 
							
					di as txt `"{browse "http://www.haghish.com/packages/pandoc.php":    {c 149} Learn How To Installing Pandoc Manually}"'  
					di as txt "{stata markdocpandoc:    {c 149} Install Pandoc {bf:Automatically}}"		
					
					if "`export'" == "html"   | "`export'" == "pdf"     ///
					   | "`export'" == "docx" | "`export'" == "md"      ///
						 | "`export'" == "sthlp" {
						 
						 di as txt _n "{p}Alternatively, you can add the "      ///
						 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:mini}} "' ///
						 "option to markdoc, which runs the engine in " ///
						 "light mode, independent of third-party software. " ///
						 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:read more about the mini option here...}} "' _n
					}
							
					di as txt "{hline}"	_n
					
					quietly error 1
				}
			}	
		}
		
	
	
		// WKHTMLTOPDF
		// -----------
		if "`printer'" == "" & "`export'" == "pdf" & "$printername" ~= "pdflatex" {
			
			// Search for wkhtmltopdf		
			cap quietly findfile wkhtmltopdf, path("`c(sysdir_plus)'Weaver/wkhtmltopdf")
			
			// if wkhtmltopdf exists
			if "`r(fn)'" ~= "" {
				qui local location "`c(pwd)'"
				qui cd "`c(sysdir_plus)'"
				qui cd Weaver
				qui cd wkhtmltopdf
				local d : pwd
				global setpath : di "`d'/wkhtmltopdf"					
				qui cd "`location'"	
			}
			
			// if it does not exist
			if "`r(fn)'" == "" {
					
				if `"`install'"'  == "install" {
					markdocwkhtmltopdf
				}
					
				if `"`install'"'  ~= "install" {
					di as txt "{hline}" _n
					di as error "{bf:WARNING}"
					di as txt "{p}The {bf:wkhtmltopdf} software was not found on" ///
					" your machine. MarkDoc package cannot produce " ///
					"PDF documents without this software." _n 
							
					di as txt `"{browse "http://www.haghish.com/packages/pdf_printer.php":    {c 149} Learn How To Installing PDF drivers Manually}"'  
					di as txt "{stata markdocwkhtmltopdf:    {c 149} Install wkhtmltopdf {bf:Automatically}}"		
					
					di as txt _n "{p}Alternatively, you can add the "      ///
					 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:mini}} "' ///
					 "option to markdoc, which runs the engine in " ///
					 "light mode, independent of third-party software. " ///
					 `"{browse "https://github.com/haghish/markdoc/wiki/mini":{bf:read more about the mini option here...}} "' _n
					
							
					di as txt "{hline}"	_n
					
					quietly error 1
				}
			}
		}
		
		// SUPPLEMENTARY
		//--------------
		if "`export'" == "tex" & "`style'" == "stata" {
			cap quietly findfile supplementary, path("`c(sysdir_plus)'Weaver")
			
			if "`r(fn)'" == "" {
					
				qui local location "`c(pwd)'"
		
				*GETTING THE PATH TO PANDOC
				qui cd "`c(sysdir_plus)'Weaver"
					
				cap qui copy "http://www.haghish.com/software/supplementary.zip" ///
				"supplementary.zip", replace
				cap qui unzipfile "supplementary", replace
				cap qui erase "supplementary.zip"
					
				*GO BACK TO THE WORKING DIRECTORY
				qui cd "`location'"
			}
		}
	}	
	
	
	*go back to the previous working directory
	qui cd "$location"
	macro drop location
	
	end
	
