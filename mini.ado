// documentation is written for markdoc package (github.com/haghish/markdoc) 
// . markdoc mini.ado, mini export(sthlp) replace

/***
_version 4.8_

mini
=====

__mini__ is a simplified command to call the _mini_ engine from the __markdoc__ 
package 

Syntax
------

> __mini__ _filename_ [, _options_ ]

where _options_ are identical to the [markdoc](help markdoc) options

Description
-----------

__mini__ is a simplified command to call the light-weight _mini_ engine forom 
the __markdoc__ command. it can be called to convert a Markdown file to any 
file format supported by the mini engine (html, docx, pdf, sthlp, slide). the 
command also can execute a do-file to produce a dynamic document.  

Examples
--------

convert a Markdown file to a word, pdf, html, sthlp, and slides files

        . mini "filename.md" , export(docx) 
        . mini "filename.md" , export(pdf) 
        . mini "filename.md" , export(html) 
        . mini "filename.md" , export(sthlp) 
        . mini "filename.md" , export(slide) 

execute a do-file and produce a word, pdf, and html files...

        . mini "filename.do" , export(docx) 
        . mini "filename.do" , export(pdf) 
        . mini "filename.do" , export(html) 

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



*cap prog drop mini
prog mini
	version 15
	tokenize `"`macval(0)'"', parse(",")
	if "`2'" == "," {
		markdoc `0' mini
	}
	else {
		markdoc `0', mini
	}
end

