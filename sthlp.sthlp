{smcl}
{it:v. 2.0.1}


{title:sthlp}

{p 4 4 2}
converts Markdown to STHLP format to create Stata help files


{title:Syntax}

{p 8 8 2} {bf:sthlp} {it:filename} [, {it:replace} {it:debug} ]

{p 4 4 2}{bf:Options}

{col 5}Option{col 19}Description
{space 4}{hline 66}
{col 5}{it:replace}{col 19}replaces the existing file
{col 5}{it:debug}{col 19}runs {bf:sthlp} in debug mode
{col 5}{it:helplayout}{col 19}appends the help file template to a script file
{col 5}{it:datalayout}{col 19}appends or creates the data documentation template
{space 4}{hline 66}

{title:Example}

{p 4 4 2}
extract the Markdown notation from a do-file and build a help file

     . sthlp filename.ado , replace 

{p 4 4 2}
append the help layout to an ado-file

     . sthlp filename.ado, helplayout

{p 4 4 2}
generate a data documentation template for {bf:auto.dta}

     . sysuse auto, clear
     . sthlp filename.do , replace datalayout


{title:Author}

{p 4 4 2}
E. F. Haghish    {break}
{it:haghish@med.uni-goesttingen.de}    {break}
{browse "https://github.com/haghish/echo":https://github.com/haghish/echo}    {break}


{title:License}

{p 4 4 2}
MIT License

{space 4}{hline}

{p 4 4 2}
This help file was dynamically produced by 
{browse "http://www.haghish.com/markdoc/":MarkDoc Literate Programming package} 



