{smcl}
{it:version 4.6}


{title:Title}

{p 4 4 2}
mini - a simplified command to call {bf:markdoc} in light-weight {it:mini} mode, 
without requiring any dependencies



{title:Syntax}

{p 8 8 2} {bf:mini} {it:filename} [, {it:options} ]

{p 4 4 2}
where {it:options} can be any of the  {browse "help markdoc":markdoc} options


{title:Description}

{p 4 4 2}
{bf:mini} is just a wrapper for {bf:markdoc} with the {it:mini} option to run 
{bf:markdoc} independent of any third-party dependencies. 


{title:Example}

{p 4 4 2}
execute a do-file and produce a word, pdf, and html files

     . mini "filename.do" , export(docx) 
     . mini "filename.do" , export(pdf) 
     . mini "filename.do" , export(html) 


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


