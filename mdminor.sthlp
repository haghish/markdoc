{smcl}
{it:v. 1.3} 


{title:mdminor}

{p 4 4 2}
{bf:mdminor} interprets Markdown syntax and converts it in 
Microrosoft Word{c 39}s {bf:docx} format or {bf:pdf} format


{title:Syntax}

{p 8 8 2} {bf:mdminor} {it:text} [, {it:options}]


{p 4 4 2}{bf:Options}

{col 5}{it:option}{col 21}{it:Description}
{space 4}{hline}
{col 5}export({it:str}){col 21}specifies the file format and can be {bf:docx} (default) or {bf:pdf}
{col 5}name({it:str}){col 21}specifies the file name
{col 5}continue{col 21}avoids creating a new file and works on the loaded file in the memory
{col 5}replace{col 21}replaces the existing file
{space 4}{hline}

{title:Examples}

{p 4 4 2}
create a microsoft word file

        . mdminor "**hello** *world*!", export(docx) name(mydoc) replace

{p 4 4 2}
create a pdf file

        . mdminor "**hello** *world*!", export(pdf) name(mydoc) replace


{title:Author}

{p 4 4 2}
E. F. Haghish     {break}
University of Göttingen     {break}
{it:haghish@med.uni-goesttingen.de}    {break}
{browse "https://github.com/haghish":https://github.com/haghish} 


{title:License}

{p 4 4 2}
MIT License

{space 4}{hline}

{p 4 4 2}
This help file was dynamically produced by 
{browse "http://www.haghish.com/markdoc/":MarkDoc Literate Programming package} 


