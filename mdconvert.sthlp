{smcl}
{it:v. 1.0.0} 


{title:Title}

{p 4 4 2}
{bf:mdconvert} {hline 2} converts  {browse "https://daringfireball.net/projects/markdown/":Markdown} to
Microsoft Word {bf:docx} or {bf:pdf}


{title:Syntax}

{p 8 8 2} {bf:mdconvert} using {it:filename} [, {it:options}]

{p 4 4 2}
{it:options}

{space 4}{hline}

{p 4 4 2}
{ul:rep}lace: replaces the existing document    {break}
name: name of the exported file    {break}
{ul:e}xport(name): document format which can be {bf:docx} or {bf:pdf} 
{ul:t}itle(str): title of the document    {break}
{ul:au}thor(str): author of the document    {break}
{ul:aff}iliation(str): author affiliation      {break}
{ul:add}ress(str): author address or email     {break}
{ul:sum}mary(str): abstract or summary of the document

{space 4}{hline}

	

{title:Description}

{p 4 4 2}
{bf:mdconvert} is an alternative to  {browse "https://pandoc.org/":Pandoc} for converting 
Markdown documents to {bf:docx} and {bf:pdf} within Stata 15. This package was 
developed to support  {browse "https://github.com/haghish/markdoc":markdoc} package and 
allow generating dynamic documents independent of Pandoc or 
{browse "https://wkhtmltopdf.org/":wkhtmltopdf} for generating Microsoft Word and 
PDF documents respectively. 


{title:Limitations}

{p 4 4 2}
Generating docx and pdf files in Stata 15 is done using the {bf:putdocx} and 
{bf:putpdf} commands. Compared to Pandoc, these commands are still very limited
and do not fully cover the Markdown syntax. For example, they do not allow:

{break}1. horizontal line
{break}2. Hyperlink
{break}3. Nested lists
{break}4. Mathematical notations


{title:Example(s)}

    convert Markdown file to docx
        . mdconvert using path/to/markdown.md, name(mydoc) export(docx) replace

    convert Markdown file to pdf (NOT DEVELOPED YET)
        . mdconvert using path/to/markdown.md, name(mydoc) export(pdf) replace


{title:Author}

{p 4 4 2}
E. F. Haghish     {break}
University of Göttingen     {break}
info [aT] haghish [D0T] com      {break}

{p 4 4 2}
The command is hosted on
GitHub  {browse "http://github.com/haghish/markdoc":hyperlink}

{space 4}{hline}

{p 4 4 2}
This help file was dynamically produced by 
{browse "http://www.haghish.com/markdoc/":MarkDoc Literate Programming package} 

