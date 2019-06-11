{smcl}
{it:version 4.8}


{title:mini}

{p 4 4 2}
{bf:mini} is a simplified command to call the {it:mini} engine from the {bf:markdoc} 
package 


{title:Syntax}

{p 8 8 2} {bf:mini} {it:filename} [, {it:options} ]

{p 4 4 2}
where {it:options} are identical to the  {browse "help markdoc":markdoc} options


{title:Description}

{p 4 4 2}
{bf:mini} is a simplified command to call the light-weight {it:mini} engine forom 
the {bf:markdoc} command. it can be called to convert a Markdown file to any 
file format supported by the mini engine (html, docx, pdf, sthlp, slide). the 
command also can execute a do-file to produce a dynamic document.    {break}


{title:Examples}

{p 4 4 2}
convert a Markdown file to a word, pdf, html, sthlp, and slides files

        . mini "filename.md" , export(docx) 
        . mini "filename.md" , export(pdf) 
        . mini "filename.md" , export(html) 
        . mini "filename.md" , export(sthlp) 
        . mini "filename.md" , export(slide) 

{p 4 4 2}
execute a do-file and produce a word, pdf, and html files...

        . mini "filename.do" , export(docx) 
        . mini "filename.do" , export(pdf) 
        . mini "filename.do" , export(html) 


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


