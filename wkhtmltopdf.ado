/*** DO NOT EDIT THIS LINE -----------------------------------------------------
Version: 1.0.0
Title: wkhtmltopdf
Description: renders __html__ documents to __pdf__ within Stata  
----------------------------------------------------- DO NOT EDIT THIS LINE ***/


/***
Syntax
======

{p 8 16 2}
{cmd: wkhtmltopdf} [{browse "http://wkhtmltopdf.org/usage/wkhtmltopdf.txt":options}]
{it:filename.html} {it:filename.pdf} 
{p_end}

See the {browse "http://wkhtmltopdf.org/usage/wkhtmltopdf.txt":options} which 
is a link to the __wkhtmltopdf__ manual, explaining the arguments you can 
add to adjust the pdf output. 


Description
===========

__{help MarkDoc}__ requires the 
[wkhtmltopdf](http://wkhtmltopdf.org/downloads.html) 
software to convert __html__ to __pdf__ without requiring installing LaTeX. 
Moreove, __MarkDoc__ provides automatic installation of wkhtmltopdf which is 
very convenient. 

However, __MarkDoc__ is not the only software that deals with documents in Stata 
and many users show interest to create dynamic documents in their own way. 
To help them create __pdf__ documents, this command was created to convert their 
__html__ documents to __pdf__. 


Example
=================

    convert html file to pdf
        . wkhtmltopdf myfile.html myfile.pdf

- - -

_This help file was dynamically produced by_ 
_[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/)_ 
***/




*cap prog drop wkhtmltopdf
program wkhtmltopdf
	
	// Run weaversetup
	// -------------------------------------------------------------------------
	capture program drop weaversetup			  //reload it
	capture weaversetup							  //it might not be yet created
	
	if !missing("$pathWkhtmltopdf") {
		local printer "$pathWkhtmltopdf"
	}
	else {
		markdoccheck , export(pdf) 
		local printer "$setpath"
	}	
	
	di as err ":::`printer'"
	
	shell "`printer'" `0'
	
end


markdoc wkhtmltopdf.ado, export(sthlp) replace

