{smcl}
{right:version 1.0.0}
{title:Title}

{phang}
{cmd:rundoc} {hline 2} executes a {it:do-file} and exports a dynamic document in any format supported by {bf:{help markdoc}} 
 

{title:Syntax}

{p 4 4 2}
produce dynamic {it:document} or {it:presentation slides} from a do-file. If 
filename is specified without an extension, .do is assumed. 

{p 8 16 2}
{cmd: rundoc} {help filename} [{cmd:,} 
{opt pan:doc(str)} {opt print:er(str)} {opt instal:l} {opt replace} 
{opt e:xport(name)} {opt mark:up(name)} {opt num:bered} {opt sty:le(name)} 
{opt template(str)} {opt toc}
{opt linesize(int)} {opt tit:le(str)} {opt au:thor(str)} {opt aff:iliation(str)} {opt add:ress(str)} 
{opt sum:mary(str)} {opt d:ate} {opt tex:master} {opt statax} {opt noi:sily}
{* *! {opt ascii:table}}
]
{p_end}


{title:Description}

{p 4 4 2}
{bf:rundoc} executes a dynamic document from a do-file. In contrast to {bf:{help markdoc}} 
that requires smcl file for generating a dynamic document or presentation slides, 
{bf:rundoc} does not require you to create a {bf:smcl} log file and takes the 
do-file as the source and can export a document to all of the document formats 
supported by {help markdoc} which are {bf:pdf}, {bf:docx}, {bf:odt}, {bf:html}, 
{bf:latex}, {bf:slides}, etc.


{title:Options}

{p 4 4 2}
{bf:rundoc} takes the same options as {help markdoc}. The only difference is that 
the {bf:export()} option does not accept {bf:sthlp} or {bf:smcl} which are used for 
creating dynamic Stata help files in {help markdoc} package. 


{title:Author}

{p 4 4 2}
{bf:E. F. Haghish}       {break}
Center for Medical Biometry and Medical Informatics       {break}
University of Freiburg, Germany       {break}
{it:and}          {break}
Department of Mathematics and Computer Science         {break}
University of Southern Denmark       {break}
haghish@imbi.uni-freiburg.de       {break}

{p 4 4 2}
{browse "www.haghish.com/markdoc":MarkDoc Homepage}           {break}
Package Updates on  {browse "http://www.twitter.com/Haghish":Twitter}       {break}

    {hline}

{p 4 4 2}
{it:This help file was dynamically produced by {browse "http://www.haghish.com/markdoc/":MarkDoc Literate Programming package}} 

