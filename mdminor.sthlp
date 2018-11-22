{smcl}
{it:v. 1.0.0} 


{title:Title}

{p 4 4 2}
{bf:mdminor} {hline 2} interprets Markdown syntax and converts it in 
Microrosoft Word{c 39}s {bf:docx} format or {bf:pdf} format


{title:Syntax}

{p 8 8 2} {bf:mdminor} {it:text} [, {it:options}]


{p 4 4 2}
{it:options}

{space 4}{hline}

{p 4 4 2}
export({it:str}): specifies the file format and can be {bf:docx} (default) or {bf:pdf}    {break}
name({it:str}): specifies the file name    {break}
continue: avoids creating a new file and works on the loaded file in the memory    {break}
replace: replaces the existing file    {break}

{space 4}{hline}


{title:Example(s)}

    create a microsoft word file
        . mdminor "**hello** *world*!", export(docx) name(mydoc) replace

    create a pdf file
        . mdminor "**hello** *world*!", export(pdf) name(mydoc) replace


{title:Author}

{p 4 4 2}
E. F. Haghish     {break}
University of Göttingen     {break}
info [aT] haghish [D0T] com      {break}

{p 4 4 2}
The command is hosted on  {browse "http://github.com/haghish/markdoc":GitHub}

{space 4}{hline}

{p 4 4 2}
This help file was dynamically produced by 
{browse "http://www.haghish.com/markdoc/":MarkDoc Literate Programming package} 

