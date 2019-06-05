{smcl}
{it:v. 2.0}


{title:sthlp}

{p 4 4 2}
converts Markdown to STHLP format to create Stata help files


{title:Syntax}

{p 8 8 2} {bf:sthlp} {it:filename} [, {it:replace} {it:debug} ]

{p 4 4 2}{bf:Options}

{col 5}Option{col 17}Description
{space 4}{hline 43}
{col 5}{it:replace}{col 17}replaces the existing file
{col 5}{it:debug}{col 17}runs {bf:sthlp} in debug mode
{space 4}{hline 43}

{title:Example}

{p 4 4 2}
extract the Markdown notation from a do-file and build a help file

     . sthlp "filename.do" , replace 


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



