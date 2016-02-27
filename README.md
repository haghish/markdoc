# MarkDoc : a general-purpose literate programming package for Stata

Author
------
  E. F. Haghish  
  Center for Medical Biometry and Medical Informatics  
  University of Freiburg, Germany   
  haghish@imbi.uni-freiburg.de  
  http://www.haghish.com/markdoc  

Additional script files
-----------------------

__MarkDoc__ requires 3 other script files from Weaver package which are __img__, __txt__, and __tbl__. These files are 
required for dynamically inserting image, writing dynamic text/markup, and creating dynamic tables. For updating these
files see the Weaver package

Description
-----------

A general-purpose literate programming package for Stata that produces dynamic analysis
        documents or package documentation in various formats (pdf, docx, html, odt, epub, markdown),
        dynamic presentation slides (pdf, slidy, dzslide), as well as dynamic Stata help files (sthlp, 
        smcl)

Package Structure
-----------------

The main engine of MarkDoc is __markdoc.ado__. For producing Stata help files and SMCL files, you should read __sthlp.ado__, 
__markup.ado__, and __markdown.ado__. Here is a description of other script files:

_markdocversion.ado_ checks the new updates available for MarkDoc, if there is any  
_markdoccheck.ado_ checks the required third-party software on the machine and if the __install__ option is specified, 
it install the required software  
_markdocpandoc.ado_ installs [Pandoc](http://pandoc.org/) automatically, if the __install__ option is specified and the software is not found
_markdocwkhtmltopdf.ado_ installs [wkhtmltopdf](http://wkhtmltopdf.org/) automatically, if the __install__ option is specified and the software is not found

