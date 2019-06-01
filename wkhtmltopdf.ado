// documentation is written for markdoc package (github.com/haghish/markdoc) 
// . markdoc wkhtmltopdf.ado, mini export(sthlp) replace

/***
_v. 1.1_

wkhtmltopdf
===========

__wkhtmltopdf__ renders __html__ documents to __pdf__ within Stata

Syntax
------

> __wkhtmltopdf__ [[_options_](http://wkhtmltopdf.org/usage/wkhtmltopdf.txt)] 
_filename.html_ _filename.pdf_

See the [_options_](http://wkhtmltopdf.org/usage/wkhtmltopdf.txt), which 
is a link to the __wkhtmltopdf__ manual, explaining the arguments you can 
add to adjust the pdf output. 

Description
-----------

if the __mini__ engine is not used, 
__markdoc__ requires the [wkhtmltopdf](http://wkhtmltopdf.org/downloads.html) 
software to convert __html__ to __pdf__ without requiring installing LaTeX. 
Moreove, __markdoc__ provides automatic installation of wkhtmltopdf, if desired. 

However, __markdoc__ is not the only software that deals with documents in Stata 
and many users show interest to create dynamic documents in their own way. 
to help them create __pdf__ documents, this command was created to convert their 
__html__ documents to __pdf__. 

Example
-------

convert html file to pdf

        . wkhtmltopdf myfile.html myfile.pdf

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
	
	*di as err ":::`printer'"
	
	shell "`printer'" `0'
	
end


