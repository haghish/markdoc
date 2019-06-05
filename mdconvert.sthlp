{smcl}
{it:v. 1.3} 


{title:mdconvert}

{p 4 4 2}
{bf:mdconvert} converts  {browse "https://daringfireball.net/projects/markdown/":Markdown} to
Microsoft Word {bf:docx} or {bf:pdf} within Stata


{title:Syntax}

{p 8 8 2} {bf:mdconvert} using {it:filename} [, {it:options}]

{p 4 4 2}{bf:Options}

{col 5}{it:option}{col 27}{it:Description}
{space 4}{hline 75}
{col 5}{ul:rep}lace{col 27}names of the exported file
{col 5}name{col 27}bold face text
{col 5}{ul:e}xport(name){col 27}document format which can be {bf:docx} or {bf:pdf}
{col 5}{ul:t}itle(str){col 27}title of the document
{col 5}{ul:au}thor(str){col 27}author of the document
{col 5}{ul:aff}iliation(str){col 27}author affiliation
{col 5}{ul:add}ress(str){col 27}author address or email
{col 5}{ul:sum}mary(str){col 27}abstract or summary of the document
{space 4}{hline 75}

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

{break}    1. horizontal line
{break}    2. Hyperlink
{break}    3. Nested lists
{break}    4. Mathematical notations


{title:Examples}

{p 4 4 2}
convert Markdown file to docx

        . mdconvert using "markdown.md", name(mydoc) export(docx) replace

{p 4 4 2}
convert Markdown file to pdf

        . mdconvert using "markdown.md", name(mydoc) export(pdf) replace


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


