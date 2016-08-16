# MarkDoc : a general-purpose literate programming package for Stata

A general-purpose literate programming package for Stata that produces dynamic analysis
documents or package documentation in various formats (pdf, docx, html, odt, epub, markdown),
dynamic presentation slides (pdf, slidy, dzslide), as well as dynamic Stata help files (sthlp, 
smcl). __MarkDoc__ is very simple and intuitive to use and can be simply applied even in introductory 
statistics courses and workshops. This is a useful tool for teaching statistics, practicing statistics, 
data analysis, and also developing new packages. 

        
Author
------
  **E. F. Haghish**  
  Center for Medical Biometry and Medical Informatics
  University of Freiburg, Germany      
  _haghish@imbi.uni-freiburg.de_     
  _http://www.haghish.com/markdoc_  
  _[@Haghish](https://twitter.com/Haghish)_   
  
Installation
------------

The major releases of __MarkDoc__ are also hosted on SSC server. But the package receives constant updates on GitHub, which hosts the most recent version, along with he previous releases. 
  
    net install markdoc, replace  from("https://raw.githubusercontent.com/haghish/markdoc/master/")
    
__MarkDoc__ also requires two additional Stata packages which are __`weaver`__ and __`statax`__, both hosted on SSC.

    ssc install weaver
    ssc install statax
    
Finally, in order to use a document conversion (i.e. exporting Microsoft Word, PDF, HTML, LaTeX, ePub, etc,...) __MarkDoc__ requires two additional third-party software which are [Pandoc](http://pandoc.org/) and [wkhtmltopdf](http://wkhtmltopdf.org/). Furthermore, for Typesetting LaTeX documents, a [complete distribution of LaTeX](https://latex-project.org/ftp.html) is required. The complete guide for installing them is provided in the MarkDoc help file and also, 
[__MarkDoc Homepage__ ](http://www.haghish.com/statistics/stata-blog/reproducible-research/markdoc.php)
    

Additional script files
-----------------------

__MarkDoc__ requires 3 other script files from Weaver package which are __`img`__, __`txt`__, and __`tbl`__. These files are 
required for dynamically inserting image, writing dynamic text/markup, and creating dynamic tables. For updating these
files see the Weaver package


Package Structure
-----------------

The main engine of MarkDoc is __markdoc.ado__. For producing Stata help files and SMCL files, you should read __sthlp.ado__, 
__markup.ado__, and __markdown.ado__. Here is a description of other script files:

_markdocversion.ado_ checks the new updates available for MarkDoc, if there is any  
_markdoccheck.ado_ checks the required third-party software on the machine and if the __install__ option is specified, 
it install the required software  
_markdocpandoc.ado_ installs [Pandoc](http://pandoc.org/) automatically, if the __install__ option is specified and the software is not found
_markdocwkhtmltopdf.ado_ installs [wkhtmltopdf](http://wkhtmltopdf.org/) automatically, if the __install__ option is specified and the software is not found

