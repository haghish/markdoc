{smcl}
{right:version 1.0.0}
{title:Title}

{phang}
{cmd:wkhtmltopdf} {hline 2} renders {bf:html} documents to {bf:pdf} within Stata 

{title:Syntax}

{p 8 16 2}
{cmd: wkhtmltopdf} [{browse "http://wkhtmltopdf.org/usage/wkhtmltopdf.txt":options}]
{it:filename.html} {it:filename.pdf} 
{p_end}

{p 4 4 2}
See the {browse "http://wkhtmltopdf.org/usage/wkhtmltopdf.txt":options} which 
is a link to the {bf:wkhtmltopdf} manual, explaining the arguments you can 
add to adjust the pdf output. 



{title:Description}

{p 4 4 2}
{bf:{help MarkDoc}} requires the 
{browse "http://wkhtmltopdf.org/downloads.html":wkhtmltopdf}
software to convert {bf:html} to {bf:pdf} without requiring installing LaTeX. 
Moreove, {bf:MarkDoc} provides automatic installation of wkhtmltopdf which is 
very convenient. 

{p 4 4 2}
However, {bf:MarkDoc} is not the only software that deals with documents in Stata 
and many users show interest to create dynamic documents in their own way. 
To help them create {bf:pdf} documents, this command was created to convert their 
{bf:html} documents to {bf:pdf}. 



{title:Example}

    convert html file to pdf
        . wkhtmltopdf myfile.html myfile.pdf

    {hline}

{p 4 4 2}
{it:This help file was dynamically produced by} 
{it:{browse "http://www.haghish.com/markdoc/":MarkDoc Literate Programming package}} 

