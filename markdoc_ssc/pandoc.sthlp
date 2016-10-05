{smcl}
{right:version 1.0.0,  6 Mar 2016}
{title:Title}

{phang}
{bf:pandoc }{hline 2} executing {bf:{browse "http://pandoc.org/":Pandoc}} from Stata seamlessly


{title:Author}

{p 4 4 2}
E. F. Haghish{break}
Center for Medical Biometry and Medical Informatics{break}
University of Freiburg, Germany{break}
{it:haghish@imbi.uni-freiburg.de}{break}
{it: {browse "http://www.haghish.com/stat"} }{break}


{title:Syntax}

{p 8 16 2}
{opt pandoc} [{it:anything}] 
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt pandoc(str)}}path to executable pandoc on the operating system{p_end}
{synopt :{opt install}}installs a portable version of Pandoc, if it is not 
accessible{p_end}
{synoptline}


{title:Description}

{p 4 4 2}
{bf:{browse "http://pandoc.org/":Pandoc}} is a document convertor freeware. The 
{help MarkDoc} package uses this application to produce dynamic documents, slides, 
and package documentation. This program is a supplementary command that allows 
using this application for other purposes, outside MarkDoc. 


{title:Example}

    executing Pandoc command
        . pandoc {it:filename} -o {it:filename}

    adding more Pandoc arguments
        . pandoc -s -S {it:filename} -o {it:filename}


    {hline}

{p 4 4 2}
This help file was dynamically produced by {help markdoc:MarkDoc Literate Programming package}

