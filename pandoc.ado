// documentation is written for markdoc package (github.com/haghish/markdoc) 
// . markdoc wpandoc.ado, mini export(sthlp) replace

/***
_v. 1.1_

pandoc
======

__pandoc__ executing [Pandoc](http://pandoc.org/) from Stata

Syntax
------

> __pandoc__ _anything_ 

Description
-----------

[Pandoc](http://pandoc.org/) is a document convertor freeware. The __markdoc__ 
package uses this application to produce dynamic documents, slides, 
and package documentation. This program is a supplementary command that allows 
using this application for other purposes, outside __markdoc__. 

Examples
--------

executing Pandoc command

        . pandoc _filename_ -o _filename_

adding more Pandoc arguments

        . pandoc -s -S _filename_ -o _filename_

Author
------

[E. F. Haghish ](https://github.com/haghish)   
Center for Medical Biometry and Medical Informatics  
University of Freiburg, Germany  
_haghish@imbi.uni-freiburg.de_  
[http://www.haghish.com/stat](http://www.haghish.com/stat)

License
-------

MIT License

- - -

This help file was dynamically produced by 
[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/) 
***/


program define pandoc
syntax anything //[, pandoc(str) install ]
	
	capture weaversetup							  //it might not be yet created
	
	*if !missing("`pandoc'") {
	*	confirm file "`pandoc'"
	*	global pandoc "`pandoc'"
	*}
	
	if missing("`pandoc'") & !missing("$pathPandoc") {
		global pandoc "$pathPandoc" 
	}
	
	markdoccheck //, `install' pandoc("`pandoc'") 
	
	confirm file "$pandoc"
	di as txt "$pandoc `anything'"
	
	! "$pandoc" `anything'

end

