/***
_version 4.6_

Title
=====

mini - a simplified command to call __markdoc__ in light-weight _mini_ mode, 
without requiring any dependencies


Syntax
------

> __mini__ _filename_ [, _options_ ]

where _options_ can be any of the [markdoc](help markdoc) options

Description
-----------

__mini__ is just a wrapper for __markdoc__ with the _mini_ option to run 
__markdoc__ independent of any third-party dependencies. 

Example
-------

execute a do-file and produce a word, pdf, and html files

     . mini "filename.do" , export(docx) 
     . mini "filename.do" , export(pdf) 
     . mini "filename.do" , export(html) 

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

