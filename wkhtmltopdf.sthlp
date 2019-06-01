{smcl}
{it:v. 1.1}


{title:wkhtmltopdf}

{p 4 4 2}
{bf:wkhtmltopdf} renders {bf:html} documents to {bf:pdf} within Stata


{title:Syntax}

{p 8 8 2} {bf:wkhtmltopdf}  {browse "http://wkhtmltopdf.org/usage/wkhtmltopdf.txt":[{it:options}}] 
{it:filename.html} {it:filename.pdf}

{p 4 4 2}
See the  {browse "http://wkhtmltopdf.org/usage/wkhtmltopdf.txt":{it:options}}, which 
is a link to the {bf:wkhtmltopdf} manual, explaining the arguments you can 
add to adjust the pdf output. 


{title:Description}

{p 4 4 2}
if the {bf:mini} engine is not used, 
{bf:markdoc} requires the  {browse "http://wkhtmltopdf.org/downloads.html":wkhtmltopdf} 
software to convert {bf:html} to {bf:pdf} without requiring installing LaTeX. 
Moreove, {bf:markdoc} provides automatic installation of wkhtmltopdf, if desired. 

{p 4 4 2}
However, {bf:markdoc} is not the only software that deals with documents in Stata 
and many users show interest to create dynamic documents in their own way. 
to help them create {bf:pdf} documents, this command was created to convert their 
{bf:html} documents to {bf:pdf}. 


{title:Example}

{p 4 4 2}
convert html file to pdf

        . wkhtmltopdf myfile.html myfile.pdf


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


