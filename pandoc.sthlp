{smcl}
{it:v. 1.1}


{title:pandoc}

{p 4 4 2}
{bf:pandoc} executing  {browse "http://pandoc.org/":Pandoc} from Stata


{title:Syntax}

{p 8 8 2} {bf:pandoc} {it:anything} 


{title:Description}

{p 4 4 2}
{browse "http://pandoc.org/":Pandoc} is a document convertor freeware. The {bf:markdoc} 
package uses this application to produce dynamic documents, slides, 
and package documentation. This program is a supplementary command that allows 
using this application for other purposes, outside {bf:markdoc}. 


{title:Examples}

{p 4 4 2}
executing Pandoc command

        . pandoc _filename_ -o _filename_

{p 4 4 2}
adding more Pandoc arguments

        . pandoc -s -S _filename_ -o _filename_


{title:Author}

{p 4 4 2}
{browse "https://github.com/haghish":E. F. Haghish}     {break}
Center for Medical Biometry and Medical Informatics    {break}
University of Freiburg, Germany    {break}
{it:haghish@imbi.uni-freiburg.de}    {break}
{browse "http://www.haghish.com/stat":http://www.haghish.com/stat}


{title:License}

{p 4 4 2}
MIT License

{space 4}{hline}

{p 4 4 2}
This help file was dynamically produced by 
{browse "http://www.haghish.com/markdoc/":MarkDoc Literate Programming package} 


