/*** DO NOT EDIT THIS LINE -----------------------------------------------------

Version: 1.0.0


Intro Description
=================

pandoc -- executing __{browse "http://pandoc.org/":Pandoc}__ from Stata seamlessly 


Author(s) section
=================

E. F. Haghish
Center for Medical Biometry and Medical Informatics
University of Freiburg, Germany
_haghish@imbi.uni-freiburg.de_
_ {browse "http://www.haghish.com/stat"} _


Syntax
=================

{opt pandoc} [{it:anything}] 
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt pandoc(str)}}path to executable pandoc on the operating system{p_end}
{synopt :{opt install}}installs a portable version of Pandoc, if it is not 
accessible{p_end}
{synoptline}
----------------------------------------------------- DO NOT EDIT THIS LINE ***/


/***
Description
=================

{p 4 4 2}
__{browse "http://pandoc.org/":Pandoc}__ is a document convertor freeware. The 
{help MarkDoc} package uses this application to produce dynamic documents, slides, 
and package documentation. This program is a supplementary command that allows 
using this application for other purposes, outside MarkDoc. 

***/

cap prog drop pandoc

program define pandoc
syntax anything [, pandoc(str) install ]
	
	capture weaversetup							  //it might not be yet created
	
	if !missing("`pandoc'") {
		confirm file "`pandoc'"
		global pandoc "`pandoc'"
	}
	
	if missing("`pandoc'") & !missing("$pathPandoc") {
		global pandoc "$pathPandoc" 
	}
	
	markdoccheck , `install' pandoc("`pandoc'") 
	
	confirm file "$pandoc"
	di as txt "$pandoc `anything'"
	
	! "$pandoc" `anything'

end



/***
Example
=================

    executing Pandoc command
        . pandoc _filename_ -o _filename_

    adding more Pandoc arguments
        . pandoc -s -S _filename_ -o _filename_
***/

/***


{hline}
{p}
this helpfile was dynamically produced by {help MarkDoc}.
{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/markdoc.php#sthlp":Read more...}{smcl}
***/
