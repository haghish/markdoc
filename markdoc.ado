/*** DO NOT EDIT THIS LINE -----------------------------------------------------
Version: 3.9.6
Title: markdoc
Description: a general-purpose literate programming package for Stata that 
produces dynamic analysis documents in various formats, such as __pdf__, __docx__, 
__odt__, __html__, __epub__, __markdown__, presentation slides in __pdf__ or 
__html__, as well as dynamic Stata package help files __sthlp__. 
----------------------------------------------------- DO NOT EDIT THIS LINE ***/

/***
{p 8 8 2}
To improve applications of the package for developing educational materials 
and encouraging university lecturers to ask students to practice 
literate programming for taking notes or doing their semester projects, 
MarkDoc was programmed to include unique features. For example, it includes a syntax highlighter, 
it recognizes markdown, html, and latex markup languages, it can render latex mathematical 
notations in {bf:pdf}, {bf:docx}, {bf:html}, {bf:odt}, and {bf:tex} documents, 
automatically capture graphs from Stata and include them in the document, creates dynamic tables, and 
supports writing dynamic text for interpretting the analysis. Moreover, a user-friendly 
GUI interface was developed for the package (try {bf:{stata db markdoc}}) to make using __MarkDoc__ easier for newbies.
These features make the package a 
complete tool for documenting data analysis, Stata packages, as well as a tool for 
producing educational materials within Stata Do-file editor. 

{p 8 8 2}
The source code of the project 
[is hosted on GitHub](https://github.com/haghish/MarkDoc) 
and also, the package documentation
[is hosted on GitHub wiki](https://github.com/haghish/MarkDoc/wiki). all 
contributions to the package, including improving the documentation or providing 
further examples are welcome. further resources are available in the webpages below. 

{p 8 8 2}
[Homepage](http://haghish.com/markdoc)   
[Journal Article](http://haghish.com/resources/pdf/Haghish_MarkDoc.pdf)   
[MarkDoc Documentation Manual](https://github.com/haghish/MarkDoc/wiki)  
[Release Notes](https://github.com/haghish/MarkDoc/releases)  
[Examples](https://github.com/haghish/MarkDoc/tree/master/Examples)  
[Please ask your questions on statalist.org](http://www.statalist.org/forums/forum/general-stata-discussion/general) 

Syntax
======

produce dynamic {it:documents}, {it:presentation slides}, or {it:help files} interactively

{p 8 13 2}
{cmdab:markdoc} {help filename} [{cmd:,} 
{opt pan:doc(str)} {opt print:er(str)} {opt instal:l} {opt t:est} {opt replace} 
{opt e:xport(name)} {opt mark:up(name)} {opt num:bered} {opt sty:le(name)} 
{opt template(str)} {opt toc}
{opt tit:le(str)} {opt au:thor(str)} {opt aff:iliation(str)} {opt add:ress(str)} 
{opt sum:mary(str)} {opt d:ate} {opt master} {opt statax} {opt noi:sily}
{* *! {opt ascii:table}}
]


{phang}
where {help filename} can be:

{synoptset 20 tabbed}{...}
{synoptline}
{synopt:{opt smcl}}converts {it:smcl} log file to any of the supported document formats. 
The {it:smcl} log is used for creating {it:dynamic document} as well as 
{it:dynamic slides}.{p_end}

{synopt:{opt do}}executes the {it:do-file} in a "cleared workspace" and produces a 
{it:dynamic document} or {it:dynamic slides}. A cleared workspace ensures the reproducibility 
of the analysis because it neglects the data that is already loaded in Stata and 
requires the user to load the data that is used for the analysis in the do-file. 
{p_end}

{synopt: {bf:ado} {c |} {bf:mata} }MarkDoc handles Stata programs differently. 
It creates {bf:sthlp} help files or package vignettes 
({bf:pdf}, {bf:html}, {bf:docx}, etc) from Stata programming script files. 
This process merely extracts the documentation from the source. The documentation 
can be written with either smcl or Markdown or a combination of both.{p_end}
{synoptline}
{p2colreset}{...}


__MarkDoc__ package also includes a few more commands that can be used to 
facilitate writing the dynamic document or dynamic slides. These commands are 
briefly described below, while the 
[complete documentation is available on GitHub wiki](https://github.com/haghish/MarkDoc/wiki):

write dynamic text using any of the supported markup languages. You can also 
use this command to write text within a loop or a program. 

{p 8 13 2}
{bf:{browse "https://github.com/haghish/MarkDoc/wiki/txt":txt}} [{help txt:{ul:{bf:c}}{bf:ode}}] [{it:display_directive} [{it:display_directive} [{it:...}]]]


include an image in the document. if _filename_ is missing, __img__ command
captures, saves, and imports the current graph from Stata automatically. 

{p 8 13 2}
{bf:{browse "https://github.com/haghish/MarkDoc/wiki/img":img}} [{it:{help filename}}] 
[{cmd:,} {opt markup(str)} {opt tit:le(str)} {opt w:idth(int)} {opt h:eight(int)} 
{opt m:arkup(str)} {opt left center} ]


{phang}
create a dynamic table in Markdown documents (Not supported in HTML and LaTeX). This 
command has several directives for styling the table, creating nested tables, and 
aligning the content of each column. 

{p 8 13 2}
{bf:{browse "https://github.com/haghish/MarkDoc/wiki/tbl":tbl}} {it:(#[,#...] [\ #[,#...] [\ [...]]])} [{cmd:,} {opt tit:le(str)}]


execute __pandoc__ commands directly from Stata

{p 8 13 2}
{bf:{browse "https://github.com/haghish/MarkDoc/wiki/pandoc":pandoc}} {it:command} ]


convert html files to pdf using __wkhtmltopdf__ software

{p 8 13 2}
{bf:{browse "https://github.com/haghish/MarkDoc/wiki/wkhtmltopdf":wkhtmltopdf}} {it:command} ]


{synoptset 20 tabbed}{...}
{synopthdr:MarkDoc options}
{synoptline}
{syntab:}
{synopt:{opt pan:doc(str)}}specify the path to Pandoc software on the operating system{p_end}

{synopt:{opt print:er(str)}}specify the path to PDF driver on the operating system{p_end}

{synopt:{opt instal:l}}Installs the required packages and software automatically on the user's machine, if they are not accessible {p_end}

{synopt:{opt t:est}}examines if MarkDoc is working properly by creating a test document{p_end}

{synopt:{opt replace}}replace the exported file if already exists{p_end}

{synopt:{opt e:xport(name)}}exports the {it:smclfile} to any of the supported document formats
which are {bf:pdf}, {bf:slide} (i.e. pdf slides), {bf:docx}, {bf:odt}, {bf:tex}, {bf:html}, {bf:epub}, and {bf:md}{p_end}

{synopt:{opt mark:up(name)}}specify the markup language used for writing the document and the default is Markdown{p_end}

{synopt:{opt num:bered}}numbers Stata commands in the dynamic document.{p_end}

{synopt:{opt unc}}specify that markdoc is being accessed from a Windows server with UNC file paths{p_end}

{synopt:{opt sty:le(name)}}specify the style of the document for HTML, PDF, Docx, and LaTeX documents. 
The available styles are {bf:simple}, {bf:stata}, and {bf:formal}. If the document is exported 
in LaTeX format, the {bf:stata} option (also if used with {cmd: master} option) 
will produce a {browse "http://www.stata-journal.com/author/":LaTeX article in the {bf:Stata Journal} style}, 
even if the document is written in Markdown.
{ul:In other words, you can write your stata journal article using Markdown}.{p_end}

{synopt:{opt template(str)}}renders the document using an external style sheet file. When the document is 
written in Markdown or HTML and exported to HTML or PDF, a CSS filename can 
be specified to alter the appearance of the document. Similarly, when the document is written in Markdown 
and exported to Microsoft Word Docx or Open Office ODT, a reference document with the similar format can be 
used to alter the style of the exported document (i.e. create a reference document, change the styles and 
themes, and use it as a template file). If the document is written in LaTeX, this option can also be used 
to add the required packages to the dynamic document by providing a file that inludes the packages and the template set up. 

{synopt:{opt toc}}creates table of content in PDF, Microsoft Word Docx, and LaTeX documents{p_end}

{synopt:{opt tit:le(str)}}specify the title of the document{p_end}

{synopt:{opt au:thor(str)}}specify the author of the document{p_end}

{synopt:{opt aff:iliation(str)}}specify the author affiliation in the document{p_end}

{synopt:{opt add:ress(str)}}specify the author's contact information in the document{p_end}

{synopt:{opt sum:mary(str)}}specify the summary of the document{p_end}

{synopt:{opt d:ate}}specify the current date in the document{p_end}

{synopt:{opt master}}while creating a LaTeX or HTML document, MarkDoc only translates the 
content of the smcl file to tex or html respectively. Since the document does not include the required
layout, it cannot be compiled (although it can be imported in a document). 
This option creates the layout in LaTeX and HTML to allow compiling the document. 
Many features of the HTML document (that are written with HTML markup) such as 
mathematical notations require this option. Otherwise, the user should build 
the layout from scratch.{p_end}

{synopt:{opt build}}when generating dynamic package documentation in sthlp format, 
the {bf:build} option will also create the {bf:stata.toc} and {bf:pkgname.pkg} 
automatically, so that cou can host an installable version of the package on 
GitHub or your personal website. {p_end}

{synopt:{opt statax}}highlights the syntax of Stata codes in the HTML and PDF 
documents using {help Statax}, which is a JavaScript syntax highlighter engine for Stata{p_end}

{synopt:{opt noi:sily}}enables extended log for debugging markdoc{p_end} 

{synoptline}
{p2colreset}{...}
{* *! {synopt:{opt ascii:table}}converts ascii and figures tables to smcl. This feature can be used for adding ascii models of a program or tables in Stata help file.}

Installation
============

The latest release as well as archived older versions of __markdoc__ are hosted on 
[GitHub](https://github.com/haghish/MarkDoc) website. MarkDoc receives weekly 
updates on GitHub so I recommend you to "watch" (subscribe) the repository's 
updates on GitHub to get the latest news about the package.
 
__markdoc__ depends on several other Stata modules. If you have the 
[__github__ package](https://github.com/haghish/github) installed, you can install 
__markdoc__ and all of its dependencies by typing:

        . github install haghish/markdoc

The __github__ command is used for searching, installing, and uninstalling Stata 
packages with their dependencies from GitHub website. to install the __github__ 
command, type:

        . net install github, from("https://haghish.github.io/github/")

Description
===========

{bf:markdoc} is a general-purpose literate programming package for Stata that 
produces {it:dynamic analysis documents}, {it:package vignette documentation}, 
{it:dynamic presentation slides}, as well as dynamic 
{it:Stata package help files}. 

For creating a dynamic document or presentation slides, MarkDoc requires a smcl 
log-file as input and converts it to other formats. For generating dynamic Stata 
help files or package vignette documentation, MarkDoc requires a Stata script-file 
(do, ado, mata) as input and exports the documentations written within the source. 
Visit MarkDoc homepage for documentation about generating 
{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/markdoc.php#sthlp":{bf:dynamic Stata help files and documentations}}. 

MarkDoc supports 
three different markup languages which are 
{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/dynamic_documents/markdown.php":Markdown}, 
{browse "http://haghish.com/statistics/stata-blog/reproducible-research/dynamic_documents/htmlcodes.php":HTML}, 
and {browse "http://haghish.com/statistics/stata-blog/reproducible-research/dynamic_documents/latex.php":LaTeX}. 
All of these markup languages can also include an image in the document, support 
writing dynamic text, and creating dynamic table. MarkDoc can export documents 
in various file formats including {bf:pdf} document and {bf:slide}, Microsoft Office {bf:docx}, 
Open Office and LibreOffice {bf:odt}, LaTeX {bf:tex}, {bf:html}, {bf:epub}, 
Markdown {bf:md}, {bf:slidy} and {bf:dzslide} HTML-based slides, and also 
{bf:sthlp} and {bf:smcl} for Stata documentation. If file format is not specified, MarkDoc creates a 
markdown {bf:md} file. MarkDoc {help weaver:requires the Weaver package} for 
making use of the {help txt}, {help tbl}, and {help img} commands which are used for writing 
dynamic text, creating dynamic tables, and importing figures automatically 
in the document, respectively. MarkDoc also  
{help statax:requires the Statax package} which provides 
{browse "http://www.haghish.com/statax/statax.php":a JavaScript syntax highlighter for Stata and Mata code}
 in HTML and PDF documents.

MarkDoc creates the dynamic documents by converting {it:smcl} log-file to other 
file formats mentioned above or parsing the documentation written in Stata script files. 
The documentation should be written within the 
source files using a special notations that are seperated from regular 
comments. Weaving the dynamic document or dynamic slides 
can take place at any point without 
requiring closing the log-file, which provides live-preview of the document. This 
is the biggest advantage of MarkDoc and {help Weaver} packages to other classic literate 
programming packages which cannot provide live-preview of the document in an 
interactive analysis session. 

MarkDoc supports both Stata and {help Mata:Mata} languages. Therefore, advanced users who work or 
program in Mata, can use Markdoc - with the same syntax and markup notation - 
to produce a dynamic document or slides, or document their programs. The same source 
that is used for generating dynamic Stata {bf:sthlp} help files, can be used to 
produce Microsoft Word {bf:docx}, {bf:pdf}, etc.

For a more detailed documentation and examples, visit 
{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/markdoc.php":{bf:MarkDoc Homepage}}. 

Writing mathematical notation
=============================

__markdoc__ can render LaTeX mathematical notations not only when the document 
is exported to LaTeX __tex__, but also when the document is exported to 
__pdf__ document or __slide__, Microsoft Office __docx__, 
OpenOffice and LibreOffice __odt__, and __html__. 

Mathematical notations can be inline a text paragraph or on a separate line. 
For writing inline notations, place the notation between single dollar signs 
(e.g. $a^2 + b^2 = c^2$). For including notation on a separate line, place the 
notations between double dollar signs (e.g. $$a^2 + b^2 = c^2$$). The example 
below demonstrates how to export a PDF presentation slides with notations:

    . qui log using example, replace
    
        /***
        Mathematical notations can be inline a text paragraph e.g. $a^2 + b^2 = c^2$
        or on a separate line such as:
    
        $$a^2 + b^2 = c^2$$
        ***/
    
    . qui log c
    . markdoc example, export(slide) printer("/usr/texbin/pdflatex") 
    
Inserting an image or figure in the document
============================================

Any of the supported markup languages can be used to insert a figure in the 
document. In general, there are two ways for inserting an image in the document. 
First, you can use Markdown, HTML, or LaTeX syntax for inserting an image {hline 2} 
that is already saved in your hard drive {hline 2} in the document. The other solution is using {help img} command. 
__img__ command can take the {help filename} of exsisting image on the hard 
drive and print the markup code (Markdown, HTML, or LaTeX. the default is 
Markdown) int he document. {cmd:img} command can also auto-export the current 
graph and import it in the document. For more information in this regard see 
the {help img:img help file} and also 
{ul:{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/markdoc.php#img":Examples and explanations on MarkDoc homepage}}

{title:Writing dynamic text}

{pstd}
the {help txt:{bf:txt}} command is borrowed from {help weaver} package to print 
dynamic text in the the exported dynamic document. 
It can be used for interpreting the analysis results or dynamically referring to values of 
scalars or macros in the dynamic document. Writing dynamic text allows the content of 
the text to change by altering 
analysis codes and thus is the desirable way for explaining the analysis results. The text and 
macros can be styled using any of the supported markup languages in MarkDoc which are 
{it:markdown}, {it:LaTeX}, and {it:HTML}. This command is fully documented in 
the {help txt:txt help file}. 


{title:Creating dynamic tables with tbl command}

{pstd}
the {help tbl:{bf:tbl}} command also belongs to {help weaver} package. The syntax of this command
is similar to {help matrix input}, however, it can include {it:String}, digits, 
scalars, and macros to create a dynamic table. This command is fully documented in 
the {help tbl:tbl help file}.


{title:Markers} 

{p 4 4 2}In addition to 3 markup languages, MarkDoc also introduces a few handy 
markers for annotating the smcl log-file. These markers can be used to specify what 
parts of the log-file should not appear in the dynamic document. The 
table below provides a brief summary of these annotating markers. In general, 
comments - unless they appear after a command - will be ignored in the dynamic 
document. However, the markers mentioned below are "special comments" that will 
influence the MarkDoc process. {break} 
 
 
{synoptset 30}{...}
{marker marker}
{p2col:{it:Marker}}Description{p_end}
{synoptline}

{syntab:{ul:Creating text block}}

{synopt :{bf: /*** }}{p_end}
{synopt : ...}creates a block of comments in the smcl file that will be interpreted in the dynamic document {p_end}
{synopt :{bf: ***/}}


{syntab:{ul:Hiding command or output}}

{synopt :{bf: /**/} {it:command} }only include the {bf:output} in the dynamic document {p_end}
{synopt :{bf: /***/} {it:command} }only include the {bf:command} in the dynamic document {p_end}


{syntab:{ul:Hiding a section}}

{synopt :{bf: //OFF }}{p_end}
{synopt : ... }Anything placed after "{bf://OFF}" until "{bf://ON} markers will be {bf:ignored} in the dynamic document {p_end}
{synopt :{bf: //ON}}


{syntab:{ul:Appending external files}}

{synopt :{bf: //IMPORT} {help filename} }Include an external text file (Markdown, HTML, LaTeX) to the dynamic document{p_end}

{synoptline}
{p2colreset}{...}

{p 4 4 2}Apart from the writing markers "{bf: /*** }" and "{bf: ***/ }", which 
are used for writing text, the other markers {bf:are not supported within loops}. 
Simply because smcl log-file does not print the output after each command in the loop. 
Nonetheless, writing markup text within the loop is not recommended either because 
it only gets printed once. For active writing within the loop or a program, see the 
{help txt} command or {help weaver} package. {break}


{title:Writing text in the do-file}
 
{pstd}
As noted, MarkDoc package allows writing and styling text as a comment in the do file. 
Text can be placed between "{bf:/***}" and "{bf:***/}" signs, where these signs are placed 
on separate lines individually. Here is an example:

    {bf:    /***} 
    
    {bf:    Text heading} 
    {bf:    ============} 
    
    {bf:    subheading}
    {bf:    ----------} 
    
    {bf:    When you write a dynamic document in MarkDoc, place text between}
    {bf:    the "/***" and "***/" signs. But they should be placed on separate lines,}
    {bf:    as shown in this example.}
        
    {bf:    ***/}

{pstd}  
    
    
{title:Hiding commands in dynamic document}

{pstd}
Use "{bf:/**/}" sign before each Stata command to hide it from the document. However, 
this sign does not hide the command outputs, but only the command itself.

{phang} Here is an example:

    {bf:  /**/} {it:sysuse auto} 
    {bf:  /**/} {it:regress price mpg} 


{title:Hiding output in dynamic document}

{pstd}
Use "{bf:/***/}" sign before each Stata command to hide its output in the 
dynamic document. However, this sign does not hide the command itself, 
but only the output. In contrast to {help quietly} command which hides 
the output in the smcl log, the "{bf:/***/}" sign only eliminates the 
output in the dynamic document and the output will be registered in the smcl log file.
Using this marker is very similar to the example above.


{title:Hiding a large part of the smcl file}

{pstd}
If you want to register several commands and outputs in the smcl log, but you wish 
to remove them from the dynamic document, begin the section you wish to hide with 
"{bf://OFF}" on a separate line as shown below. MarkDoc will ignore anything that 
comes after this marker until you specify "{bf://ON}" marker which will continue 
interpreting the smcl log. In contrast to turning the {help log:log off} and {help log:log on}
for ignoring part of the code in the document, these markers allow you to save 
everything in the log file and yet, exclude them in the dynamic document. Note 
that these markers cannot be written in Stata interactively and should be placed 
or run from the do file. 

{phang}{c 29} {cmd:  //OFF}

    {bf:  {it:command}} 
    {bf:  {it:command}} 
    {bf:  ... }
    
    {bf:  //ON}


{title:Supported markup languages}

{pstd}
MarkDoc supports three markup languages which are 
{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/dynamic_documents/markdown.php":Markdown}, 
{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/dynamic_documents/htmlcodes.php":HTML}, and
{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/dynamic_documents/latex.php":LaTeX}. 
Whereas writing with Markdown allows exporting the document in any format (including HTML 
and LaTeX), writing with HTML or LaTeX requires exporting the document in {bf:PDF} or {bf:html} and  
{bf:tex} format respectively. Markup languages hould not be used together in one document because 
MarkDoc process each markup language differently.


{title:Markdown syntax}

{pstd}
Writing with Markdown can make your script files appealing. It is a fairly minimalistic 
language which makes your text distinguishable from the computer code, in contrast 
to HTML and LaTeX, which add to the complexity of the code. 
To learn about using Markdown syntax for styling text and importing graphs, see 
{browse "http://haghish.com/statistics/stata-blog/reproducible-research/dynamic_documents/markdown.php":Writing with Markdown in Stata}.

{title:Software Installation}
{psee}

{marker sof}{...}
{pstd}
The MarkDoc package requires additional software which can be installed manually or 
automatically. The required software are 
{browse "http://pandoc.org/":Pandoc} and 
{browse "http://wkhtmltopdf.org/downloads.html":wkhtmltopdf} driver. They are both 
opensource freeware, supported for any common operating system such as Microsoft Windows, 
Macintosh, and Linux. Naturally, users who wish to use LaTeX markup for writing 
the documentation, will need a 
{browse "https://latex-project.org/ftp.html":TeX distribution with pdfLaTeX}. 

{pstd}
After a manual installation, the path to executable Pandoc should be specified in 
{opt pan:doc(str)} option. Similarly, the path to executable wkhtmltopdf or pdfLaTeX 
should be given to {opt print:er(str)} option. Note that the {opt print:er(str)} option 
is only needed for compiling {bf:pdf} document. 

{pstd}
With automatic installation (i.e. using the {opt install} option), Pandoc and Wkhtmltopdf are downloaded and placed
in Weaver directory which is located in /ado/plus/Weaver/ on your machine. To find the 
location of ado/plus/ directory on your machine use the 
{help sysdir} command which returns the system directories. The usual complete
paths to the Weaver directory are shown below. Note that username refers to your machine's username.

{p 8 8 2}{bf:Windows:} {it:C:\ado\plus\Weaver} 

{p 8 8 2}{bf:Macintosh:} {it:/Users/username/Library/Application Support/Stata/ado/plus/Weaver} 

{p 8 8 2}{bf:Unix:} {it:/home/username/ado/plus/Weaver}


{title:Set file paths permanently}
{psee}

{pstd}
After manual installation, the paths to the executable Pandoc, wkhtmltopdf, and pdfLaTeX can be permanently set using {cmd: weave setup} command. This command will open {it:weaversetup.ado} document, where you can define the files paths as global macros.

{phang}{cmd:  weave setup}


{marker trouble}{...}
{title:Software troubleshoot}

{pstd}
As mentioned, the required software can be installed manually or automatically. 
The optional automatic installation is expected to 
work properly in Microsoft Windows {bf:XP}, Windows {bf:7}, and Windows {bf:8.1}, Macintosh  
{bf:OSX 10.9.5}, Linux {bf:Mint 17 Cinnamon} (32bit & 64bit), Ubuntu {bf:14} (64bit), and 
{bf:CentOS 7} (64bit). Other operating systems may require manual software installation. 

{pstd}
However, if for some technical or permission reasons MarkDoc fails to download, access, or run 
Pandoc, install it manually and provide the 
file path to Pandoc using {opt pan:doc(str)} option. visit 
{browse "http://www.haghish.com/packages/pandoc.php":Installing Pandoc for Stata packages}  
for more information regarding manual installation of Pandoc. 


{title:Calling Pandoc}

{pstd}
{help Pandoc: Pandoc commands can also be executed from Stata}. This command takes the path to 
the executable Pandoc from MarkDoc and allows you to use Pandoc seamlessly for converting 
files within Stata 

    {bf:  pandoc ./example.tex -o ./example.html}
    

{title:Remarks}

{pstd}
If the log-file is closed exactly using "{bf:qui log c}" command, Markdoc automatically removes 
this command from the end of the file. 

{pstd}
Similarly, MarkDoc removes "{bf:qui log off}" from the logfile. Therefore "{bf:qui log off}" 
and "{bf:qui log on}" can be used to separate codes in the dofile that are not wanted in the 
dynamic document, but still required in for the analysis. Nonetheless, this is not a 
proper practice and can harm the transparency of the analytic session. The log-file 
should include as much information about the history of the analysis as possible. 
Use the "Markers" for hiding sections of the log-file in the dynamic document. 


{title:Dynamic Document Examples}

{phang}{cmd:  set linesize 90}

    {bf:  qui log using example, replace}

    {bf:         /***} 
    {bf:         Introduction to MarkDoc (heading 1)} 
    {bf:         ===================================} 
    
    {bf:         Using Markdown (heading 2)}
    {bf:         --------------------------} 
    
    {bf:         Writing with __markdown__ syntax allows you to add text and graphs to}
    {bf:         _smcl_ logfile and export it to a editable document format. I will demonstrate}
    {bf:         the process by using the __Auto.dta__ dataset.}

    {bf:         ###Get started with MarkDoc (heading 3)}
    {bf:         I will open the dataset, list a few observations, and export a graph.}
    {bf:         Then I will export the logfile to Microsoft Office docx format.}
    {bf:         ***/}

    {bf:  /***/ sysuse auto, clear} 
    {bf:  /**/  list in 1/5 }      
    {bf:  histogram price}
    {bf:  graph export graph.png,  width(400) replace}

    {bf:         /***} 
    {bf:         Adding a graph or image in the report} 
    {bf:         ======================================} 

    {bf:         Adding a graph using Markdown}
    {bf:         -----------------------------}
    
    {bf:         In order to add a graph using Markdown, I export the graph in PNG format.}
    {bf:         You can explain the graph in the "brackets" and define the file path in parentheses}
    {bf:         }
    {bf:         ![explain the graph](./graph.png)}
    {bf:         ***/}

{phang}{c 29}{cmd: qui log c}

    {bf:  markdoc example, replace export(html) install}            
    {bf:  markdoc example, replace export(docx)}
    {bf:  markdoc example, replace export(tex) master}
    {bf:  markdoc example, replace export(pdf)}
    {bf:  markdoc example, replace export(epub)}


{title:Dynamic Slide Examples}

{phang}{cmd:{c 29}  qui log using example, replace}

    {bf:         /***} 
    {bf:     ---} 
    {bf:     title:MarkDoc Dynamic Slides} 
    {bf:     author: E. F. Haghish} 
    {bf:     ---}
    
    {bf:         Slide 1} 
    {bf:         =======} 
    
    {bf:         - Writing with __markdown__ syntax allows you to add text and graphs }
    {bf:         to _smcl_ logfile and export it to a editable document format. I will demonstrate}
    {bf:         the process by using the __Auto.dta__ dataset.}

    {bf:         - I will open the dataset, list a few observations, and export a graph.}
    {bf:         Then I will export the logfile to Microsoft Office docx format.}
    
    {bf:         Adding commands and output} 
    {bf:         ==========================}
    {bf:         ***/}
    
    

    
    {bf:{c 29} sysuse auto, clear}     
    {bf:{c 29} histogram price}
    {bf:{c 29} graph export graph.png,  width(400) replace}
    
    {bf:         /***} 
    {bf:         Adding image in a slide} 
    {bf:         =======================} 
    
    {bf:         ![Histogram of the price variable](./graph.png)}
    {bf:         ***/}
    
    {bf:  qui log c}
    {bf:  markdoc example, replace export(slide) install printer("/usr/texbin/pdflatex") }

Author
======

__E. F. Haghish__     
Center for Medical Biometry and Medical Informatics     
University of Freiburg, Germany     
_and_        
Department of Mathematics and Computer Science       
University of Southern Denmark     
haghish@imbi.uni-freiburg.de     
      
[MarkDoc Homepage](www.haghish.com/markdoc)         
Package Updates on [Twitter](http://www.twitter.com/Haghish)  

Also see
========

{psee}
{space 0}{bf:{help Weaver}}: HTML & PDF Dynamic Report producer

{psee}
{space 0}{bf:{help Statax}}: JavaScript syntax highlighter for Stata   

- - -

This help file was dynamically produced by {help markdoc:MarkDoc Literate Programming package}
***/

*cap prog drop markdoc
program markdoc
    
    // -------------------------------------------------------------------------
    // NOTE:
    // Stata 14 introduces ustrltrim() function for removing Unicode whitespace 
    // characters and blanks. The previous trim() function cannot remove unicode 
    // whitespace. The program is updated to function for all versions of Stata, 
    // but yet, there is a slight chance of "unreliable" behavior from MarkDoc 
    // in older versions of Stata, if the string has a unicode whitespace. This 
    // can be fixed by finding a solution to avoid "ustrltrim()". Yet, most of 
    // the torture tests have been positive. 
    // =========================================================================
    local version = int(`c(stata_version)')
    if `version' <= 13 {
        local trim trim
        local version 11
    }
    if `version' > 13 {
        local trim ustrltrim
        local version 14
    }
    version `version'
    
    // -------------------------------------------------------------------------
    // WARNING  
    // =======
    //
    // Any change in the syntax should be also made in rundoc.ado and markdoc 
    // called by rundoc
    // =========================================================================
    
    syntax [anything(name=smclfile id="The smcl file name is")]                 /// 
    [,               ///
    replace          /// replaces the exported file
    MARKup(name)     /// specifies the markup language used in the document
    Export(name)     /// specifies the exported format
    INSTALl          /// Installs the required software automatically
    Test             /// tests the required software to make sure they're running correctly 
    PANdoc(str)      /// specifies the path to Pandoc software on the machine
    PRINTer(str)     /// the path to the PDF printer on the machine
    master           /// creates a "Main" LaTeX & HTML layout 
    statax           /// Activate the syntax highlighter
    TEMPlate(str)    /// template docx, CSS, ODT, or LaTeX heading
    TITle(str)       /// specifies the title of the document (for styling)
    subtitle(str)    /// specifies the subtitle (currently only for slides)
    AUthor(str)      /// specifies the author of mthe document (for styling)
    AFFiliation(str) /// specifies author affiliation (for styling)
    ADDress(str)     /// specifies author contact information (for styling)
    Date             /// Add the current date to the document
    SUMmary(str)     /// writing the summary or abstract of the report
    VERsion(str)     /// add version to dynamic help file
    STYle(name)      /// specifies the style of the document
    toc              /// Creates table of content
    build            /// creates the toc and pkg files
    NOIsily          /// Debugging Pandoc, pdfLaTeX, and wkhtmltopdf
    ASCIItable       /// convert ASCII tables to SMCL in dynamic help files
    NUMbered         /// number Stata commands
    helplayout       /// create temporary help layout
    unc              /// an option for working with markdoc on servers
    debug            /// run the debug mode and save the temporary files
    ///
    /// Slide options
    /// ========================================================================
    btheme(str)      ///
    bcolor(str)      ///
    bfont(str)       ///
    bfontsize(str)   ///
    bcodesize(str)   ///
    bwidth(str)      ///
    bheight(str)     ///
    /// DISCONTINUED SYNTAX
    /// ========================================================================
    MATHjax          /// Interprets mathematics using MathJax
    linesize(numlist max=1 int >=80 <=255) /// line size of the document and translator
    TEXmaster        /// creates a "Main" LaTeX file which is executable 
    ///SETpath(str)  /// the path to the PDF printer on the machine
    ///Printer(name) /// the printer name (for PDF only) 
    ///TABle         /// changes the formats of the table and creates publication ready tables (UNDER DEVELOPMENT AND UNDOCUMENTED)
    ///RUNhead(str)  /// running head for the document (for styling) 
    ///PDFlatex(str) ///this command is discontinued in version 3.0 and replaced by setpath()
    ///Font(name)    /// specifies the document font (ONLY HTML)
    ]
    
    
    // =========================================================================
    // AVOID CRASHES by removing the working log from previous execution
    // =========================================================================
    cap macro drop CurrentMarkDocDofile
    
    // =========================================================================
    // CHANGED SYNTAX
    // =========================================================================    
    local mathjax mathjax
                    
    if !missing("`texmaster'") {
        di "The {bf:texmaster} option was renamed to {bf:master}, although it " ///
       "continues to work..." _n 
       local master master
    }   
    
    if !missing("`linesize'") {
        di "The {bf:linesize} option is discontinued. {bf:markdoc} auto-detects "   ///
       "the linesize..." _n 
       local linesize
       //DO THE CHANGES
    }  
    
    // -------------------------------------------------------------------------
    // Check for Required Packages (Weaver & Statax)
    // =========================================================================
    
    capture findfile github.ado
    if _rc != 0 {
        if !missing("`install'") {
            net install github, from("https://haghish.github.io/github/")
        }
        else {
            display as err "github package is required: "                       ///
            `"{ul:{stata net install github, from("https://haghish.github.io/github/"):net install github, from("https://haghish.github.io/github/")}}"' _n(2)
            error 601
        }
    }   
        
    capture findfile weave.ado
    if _rc != 0 {
        if !missing("`install'") {
            
            github install haghish/weaver
        }
        else {
            capture findfile statax.js
            if _rc != 0 {
                display as err "weaver & statax packages are required: " _n     ///
                "{c 149} {ul:{stata github install haghish/weaver:github install haghish/weaver}}" _n ///
                "{c 149} {ul:{stata github install haghish/statax:github install haghish/statax}}"      ///
                _n(2)
                error 601
            }
            if _rc == 0 {
                display as err "Weaver package is required: "                   ///
                "{ul:{stata github install haghish/weaver:github install haghish/weaver}}" _n(2)
                error 601
            }
        }   
    }

    capture findfile statax.js
    if _rc != 0 {
        if !missing("`install'") {
            github install haghish/statax
        }
        else {
            display as err "statax package is required: "                       ///
            "{ul:{stata github install haghish/statax:github install haghish/statax}}" _n(2)
            error 601
        }   
    }
    
    // Run weaversetup
    // -------------------------------------------------------------------------
    capture program drop weaversetup              //reload it
    capture weaversetup                           //it might not be yet created
    
    // Creating PDF slides with LaTeX Markup is the same as writing LaTeX PDF doc
    // -------------------------------------------------------------------------
    if "`export'" == "slide" & "`markup'" == "latex" {
        local export pdf
    }
    
    // Auto-correcting possible typos
    // -------------------------------------------------------------------------
    if "`markup'" == "HTML" local markup html
    if "`markup'" == "LATEX" local markup latex
    if "`markup'" == "Markdown" local markup markdown
    if "`export'" == "PDF" local export pdf
    if "`export'" == "HTML" local export html
    if "`export'" == "LATEX" | "`export'" == "latex" local export tex
    if "`export'" == "SMCL" local export smcl
    if "`export'" == "STHLP" local export sthlp
    if "`export'" == "latex" local export tex
    
    // =========================================================================
    // Markup Language: 
    // check the markup language and the exported document format. If the 
    // format is not specified, alter the default if the "markup" is specified. 
    // check the output document for LaTeX and HTML markups and if the document 
    // does not match the markup language, return proper error
    // =========================================================================    
    if "`markup'" == "html" {
        if "`export'" != "html" & "`export'" != "pdf" & "`export'" != "xhtml" & ///
        !missing("`export'") {
            di as err "{p}The {bf:html} markup can only export {bf:html} " ///
            "and {bf:pdf} documents"
            error 100
        }
        if missing("`export'") local export html
    }
    
    if "`markup'" == "latex" {
        if "`export'" != "tex" & "`export'" != "pdf" & !missing("`export'")  {
            di as err "{p}The {bf:latex} markup can only export {bf:tex} " ///
            "and {bf:pdf} documents"
            error 100
        }
        if missing("`export'") local export tex
    }

    // should MarkDoc be quiet?
    // -------------------------------------------------------------------------
    if missing("`noisily'") {
        local cap cap
    }

    // The printer is used for creating PDF documents in MarkDoc. In general,
    // there are 2 printers available which are "wkhtmltopdf" & "pdflatex."
    // The default is "wkhtmltopdf" 
    // -------------------------------------------------------------------------
    if "`export'" == "pdf" &  "`markup'" != "latex" {
        global printername "wkhtmltopdf"        //printer for HTML and Markdown
        
        if missing("`printer'") & !missing("$pathWkhtmltopdf") {
            local printer "$pathWkhtmltopdf"
        }
    }

    // should MarkDoc create a layout master?
    // -------------------------------------------------------------------------
    if !missing("`style'") | !missing("`statax'") | "`export'" == "pdf" {
        if "`export'" == "pdf" | "`export'" == "html" | "`export'" == "tex" {
            local master master     
        }
    }
    
    // =========================================================================
    // pdfLaTeX
    //
    // This section does not install pdfLaTeX. But it attempts to find it 
    // on the users' operating system
    // =========================================================================
    if "`export'" == "pdf" &  "`markup'" == "latex" & missing("`printer'")      ///
    | "`export'" == "slide" & missing("`printer'") {
        
        global printername "pdflatex"           
        
        // look for weaversetup.ado
        if !missing("$pathPdflatex") {
            local printer "$pathPdflatex"
        }
        
        //be nice and search for it on their machines! 
        else {
            
            // WINDOWS 32bit
            // =============
            // ???
            
            // WINDOWS 64bit
            // =============
            if "`c(os)'" == "Windows"  {
        
                cap quietly findfile pdflatex.exe,                              ///
                path("C:\Program Files\MiKTeX 2.9\miktex\bin\x64\")
                if "`r(fn)'" != "" {
                    local printer "C:\Program Files\MiKTeX 2.9\miktex\bin\x64\pdflatex.exe"
                }
            }
            
            // MACINTOSH 
            // =========
            if "`c(os)'" == "MacOSX" {
                cap quietly findfile pdflatex, path("/usr/texbin/")
                if "`r(fn)'" != "" {
                    local printer "/usr/texbin/pdflatex"
                }
            }
            
            // Unix
            // ====
            // ???
        }
        
        if missing("`printer'") {
            di as txt "{p}(The {bf:printer} option is not defined, but "        ///
            "MarkDoc attempts to access pdfLaTeX automatically)" _n             

            display "(warning! pdfLaTeX not found...)"
            //error 100
        }
    }
    
    // =========================================================================
    // STYLE
    // 
    // MarkDoc applies a number of styles for HTML, PDF, and LaTeX documents
    // The default style is "simple." Below the name of available styles is 
    // specified for each output format. The available styles are "simple"
    // and "stata." The default style is "simple" 
    // =========================================================================
    if "`style'"  == "" local style "simple"   
    if "`export'" == "pdf" & "`style'" == "" local style "simple" 

    // CHECK FOR REQUIRED SOFTWARE
    // -------------------------------------------------------------------------
    //If PDF format is specified and pdf path is not empty, make sure file exists
    if "`printer'" != "" {
        confirm file "`printer'"
    }
    
    if !missing("`pandoc'") {
        confirm file "`pandoc'"
        global pandoc "`pandoc'"
    }
    else if missing("`pandoc'") & !missing("$pathPandoc") {
        confirm file "$pathPandoc"
        global pandoc "$pathPandoc" 
    }

    // Print the path to pandoc
    // -------------------------------------------------------------------------
    if !missing("`noisily'") display _n(2) "{title:Pandoc path}" _n "$pandoc"
    
    
    // checkes the required software
    // -------------------------------------------------------------------------
    markdoccheck , `install' `test' export(`export') style(`style')             ///
    markup(`markup') pandoc("$pandoc") printer("`printer'")
        
    // -------------------------------------------------------------------------
    // TEST MARKDOC
    // =========================================================================
    if "`test'" == "test" {
        di _n(2)
        di as txt "{hline}" _n
        di as txt "{p}{ul: {bf:Running Example Do-file}}" _n
        di as txt "{p}Running example.do from "                                 ///
        `"{browse "http://www.haghish.com/packages/markdoc/example.do":http://www.haghish.com/packages/markdoc/example.do}. "' ///
        "Make sure you are {bf:connected to internet} and you "                 ///
        "have permision to write and remove files in the current "              ///
        "working directory. " _n 
                
        do "http://www.haghish.com/packages/markdoc/example.do"
        
        di _n(2)
        di as txt "{hline}" _n
        di as txt "{p}{ul: {bf:Running MarkDoc Test}}" _n
        di as txt "{p}The example do-file is successfully executed. Next, "                                 ///
        "MarkDoc attempts to compile a HTML and PDF document" _n
        
        markdoc example, export(html) statax replace                ///
        title(Testing MarkDoc Package) author(E. F. Haghish)                    ///
        affiliation("Medical Biometry and Medical Informatics, "                ///
        "University of Freiburg")                                               ///
        address(haghish@imbi.uni-freiburg.de) style(stata) pandoc("`pandoc'")   ///
        printer("`printer'") `noisily' `install'
        
        markdoc example, export(pdf) statax replace                 ///
        title(Testing MarkDoc Package) author(E. F. Haghish)                    ///
        affiliation("Medical Biometry and Medical Informatics, "                ///
        "University of Freiburg")                                               ///
        address(haghish@imbi.uni-freiburg.de) style(stata) pandoc("`pandoc'")   ///
        printer("`printer'") `noisily' `install'
        
        
        cap quietly findfile "example.html"
        if "`r(fn)'" != "" {
            cap quietly findfile "example.pdf"
            if "`r(fn)'" != "" {
                display as txt "{p}{bf: MarkDoc works properly. "               ///
                "May The Source Be With You! ;)}" _n
            }
        }
        di as txt "{hline}" _n  
    }
                    
    // -------------------------------------------------------------------------
    // SYNTAX PROCESSING
    // =========================================================================
        
    // Syntax Highlighter
    // -------------------------------------------------------------------------
    if "`export'" != "html" & "`export'" != "pdf" & !missing("`statax'")        ///
    & "`export'" != "tex" {
        display as txt "{p}(The {bf:statax} option is only used "               ///
         "when exporting to {bf:html}, {bf:pdf}, or {bf:tex} formats)" _n
         local statax                           //Erase the macro
    }
    
    // PDF PROCESSING
    // ==============
    // Create a local for processing the PDF. Then change the export to HTML
    // and later, change it to PDF using the "pdfhtml" local
    if "`export'" == "pdf" & "`markup'" != "latex" {
        local pdfhtml "pdfhtml" 
        local export "html"
    }
    
    if "`export'" == "pdf" & "`markup'" == "latex" {
        local pdftex "pdftex" 
        tempfile tex2pdf
        //local export "tex"
    }
    
    /*
    if !missing("`pdfhtml'") | !missing("`pdftex'") {
        if !missing("`printer'") {
            display as txt "{p}(The {bf:printer} option is only used "          ///
            "when exporting to {bf:pdf} format)" _n
            //error 198
        }
    }
    */
                
    if "`master'" != "" & "`export'" != "tex" & "`export'" != "pdf" & "`export'" != "html" {
        di as txt "{p}(The {ul:{bf:master}} option should only be "             ///
        "specified while exporting to {bf:tex} or {bf:html} format)" _n
    }
        
    //Styles should be "simple" or "stata"
    if "`style'" != "" & "`style'" != "stata" & "`style'" != "simple"           ///
        & "`style'" != "formal" & "`style'" != "empty" {
        di as err "{p}{bf:style} option not recognized."
        error 198
    }
    
    // make sure no problem happenes if the file has double quotation sign
    capture local fname : display "`smclfile'"
    if _rc != 0 {
        capture local fname : display `smclfile'
        if _rc == 0 {
            local smclfile `fname'
        }
    } 
    
    
    // Use Absolute Path for UNC working directory
    if c(os) == "Windows" & substr(c(pwd),1,2) =="\\\\" {
        quietly abspath "`smclfile'"
        if _rc == 0 {
            local smclfile `r(abspath)'
        }
    }
    

    

    //If there is NO SMCL FILE and INSTALL or TEST options are not given, 
    //RETURN AN ERROR that the SMCL FILE IS NEEDED
        
    if "`smclfile'" == "" & "`test'" == "" & "`install'" == "" {
        
        di as txt _n(2) "{bf:MarkDoc requires...}" _n(2)                        ///
        "    smcl log-file to produce a dynamic document or PDF slides" _n      ///
        "    {cmd:. markdoc {it:smclname}, [options]}" _n(2)                    ///
        "    do, ado, or mata file to produce dynamic Stata help files" _n      ///
        "    {cmd:. markdoc {it:filename}, export(sthlp)}" _n(2)                ///
        "    the {bf:test} option to test the required third-party software" _n ///
        "    {cmd:. markdoc, test}" _n(2)                                       ///
        "see {help MarkDoc} for more details"
        exit 198
    }
                    
    //Avoid Syntax Error for TEST and INSTALL options, when there is no
    //SMCL file specified in the command. To do so, only run the engine
    //when the SMCL file is provided and the TEST option is NOT GIVEN. 
    //HOWEVER, IF THE USER WISHES TO RUN MARKDOC AND INSTALL IT AT THE SAME
    //TIME, THERE WOULD BE NO CONFLICT AT ALL.

    
    if "`smclfile'" != "" & "`test'" == "" & "`export'" != "sthlp" &            ///
    "`export'" != "smcl" {
        
        // Create an "output" file that is exported from Pandoc
        // --------------------------------------------------------------
        tempfile output 
        
        // For those who work on the server, temporary file with a suffix that 
        // does not yet exist becomes a problem. Define a temporary file and 
        // replace the current remp file! 
        tempfile tempput
        tempname knot
        file open `knot' using "`tempput'", write
        file close `knot'       
        confirm file "`tempput'"        


    
        tempfile md
        local md  "`md'.md"
        
        local input `smclfile'  
        
        if (index(lower("`input'"),".smcl")) {
            local input : subinstr local input ".smcl" ""
            if "`export'" == "slide" {
                local convert "`input'.pdf"
                local output "`output'.pdf"
            }   
            else if "`export'" == "dzslide" | "`export'" == "slidy" {
                local convert "`input'.html"
                local output "`output'.html"
            }
            else {
                local convert "`input'.`export'"
                local output "`output'.`export'"
            }   
            
            local html "`input'_.html"
            local pdf "`input'.pdf"
            local name "`input'"
            local input  "`input'.smcl"
        }
        else if (index(lower("`input'"),".ado")) {
            local input : subinstr local input ".ado" ""
            *if "`export'" == "slide" local convert "`input'.pdf"
            *else if "`export'" == "dzslide" local convert "`input'.html"
            *else if "`export'" == "slidy" local convert "`input'.html"
            *else local convert "`input'.`export'"
            if "`export'" == "slide" {
                local convert "`input'.pdf"
                local output "`output'.pdf"
            }   
            else if "`export'" == "dzslide" | "`export'" == "slidy" {
                local convert "`input'.html"
                local output "`output'.html"
            }
            else {
                local convert "`input'.`export'"
                local output "`output'.`export'"
            }
            
            local md  "`input'.md"
            local html "`input'_.html"
            local pdf "`input'.pdf"
            local name "`input'"
            local input  "`input'.ado"
            local scriptfile 1                      //define a scriptfile
        }
        else if (index(lower("`input'"),".mata")) {
            local input : subinstr local input ".mata" ""
            if "`export'" == "slide" local convert "`input'.pdf"
            else if "`export'" == "dzslide" local convert "`input'.html"
            else if "`export'" == "slidy" local convert "`input'.html"
            else local convert "`input'.`export'"
            local md  "`input'.md"
            local html "`input'_.html"
            local pdf "`input'.pdf"
            local name "`input'"
            local input  "`input'.mata"
            local scriptfile 1                      //define a scriptfile
        }
        else if (index(lower("`input'"),".do")) {
            local input : subinstr local input ".do" ""
            *if "`export'" == "slide" local convert "`input'.pdf"
            *else if "`export'" == "dzslide" local convert "`input'.html"
            *else if "`export'" == "slidy" local convert "`input'.html"
            *else local convert "`input'.`export'"
            if "`export'" == "slide" {
                local convert "`input'.pdf"
                local output "`output'.pdf"
            }   
            else if "`export'" == "dzslide" | "`export'" == "slidy" {
                local convert "`input'.html"
                local output "`output'.html"
            }
            else {
                local convert "`input'.`export'"
                local output "`output'.`export'"
            }
            
            local md  "`input'.md"
            local html "`input'_.html"
            local pdf "`input'.pdf"
            local name "`input'"
            local rundocScript "`input'"
            local input  "`input'.do"
            *local scriptfile 1                     //define a scriptfile
            local rundoc 1                          //run rundoc
            
            //allow rundoc get nested in the file
            global rundoc "`input'"
        }
        else if (!index(lower("`input'"),".smcl")) {
            if "`export'" == "slide" {
                local convert "`input'.pdf"
                local output "`output'.pdf"
            }   
            else if "`export'" == "dzslide" | "`export'" == "slidy" {
                local convert "`input'.html"
                local output "`output'.html"
            }
            else {
                local convert "`input'.`export'"
                local output "`output'.`export'"
            }   
            local md  "`input'.md"
            local html "`input'_.html"
            local pdf "`input'.pdf"
            local name "`input'"
            local input  "`input'.smcl"
        }
        
        *confirm file "`input'"
        cap confirm file "`input'"
        if _rc != 0 {
            cap confirm file "`smclfile'"
            if _rc != 0 {
                di as err "file `smclfile' not found"
            }
            else di as err "file `smclfile' is not a Stata file (.smcl, .do, "  ///
            ".ado, .mata)"                  
            exit 198
        }
        
        *Check if the exported document already exists
        capture quietly findfile "`convert'"
        if "`r(fn)'" != "" & "`replace'" == "" {
            di as err "{p}{bf:`convert'} file already exists. "                 ///
            "Use the {bf:replace} option to replace the existing file."                     
            exit 198
        }
        
    
        quietly copy "`tempput'" "`output'", replace

        
        // =========================================================================
        // Execute rundoc for the do-files
        //
        // execute rundoc with the `name' which does not have the ".do"
        // =========================================================================
        if !missing("`rundoc'") {
            
            if !missing("`pdfhtml'") local export "pdf"
            
            rundoc "`name'",                                                    ///
            `replace'                                                           ///
            markup(`markup')                                                    ///
            export(`export')                                                    ///
            `install'                                                           ///
            `test'                                                              /// 
            pandoc("`pandoc'")                                                  ///
            printer("`printer'")                                                ///
            `master'                                                            ///
            `statax'                                                            ///
            template(`template')                                                ///
            title("`title'")                                                    ///
            author("`author'")                                                  ///
            affiliation("`affiliation'")                                        ///
            address("`address'")                                                ///
            `date'                                                              ///
            summary("`summary'")                                                ///
            version("`version'")                                                ///
            style("`style'")                                                    ///
            linesize(`linesize')                                                ///
            `toc'                                                               ///
            `noisily'                                                           ///
            `debug'                                                         ///
            `asciitable'                                                        ///
            `numbered'                                                          ///
            `mathjax'                                                           ///
            btheme(`btheme')                                                    ///
            bcolor(`bcolor')                                                    ///
            bfont(`bfont')                                                      ///
            bfontsize(`bfontsize')                                              ///
            bcodesize(`bcodesize')                                              ///
            bwidth(`bwidth')                                                    ///
            bheight(`bheight')                      
            
            exit
        }
    
    ****************************************************************************
    *DO NOT PRINT ANYTHING ON THE LOG
    ****************************************************************************
    //quietly log query    
    //if `"`r(filename)'"' != "" {
    //  if `"`r(status)'"' == "on" {
    //      local status `"`r(status)'"'        // status of the log
    //      qui log off
    //  }   
    //}
    
    // -------------------------------------------------------------------------
    // RUN THE ENGINE FOR LOG FILES
    // =========================================================================
    if missing("`scriptfile'") {
    
        ************************************************************************    
        *
        * MAIN ENGINE : Log to Document
        * -----------
        *
        * Part 1- Correcting the SMCL file
        * Part 2- Processing the SMCL file
        * Part 3- Converting the SMCL file
        *   A: Convert to TXT
        *   B: Process the TXT file
        * Part 4- Converting TXT to Markdown / HTML / LaTeX
        * Part 5- Exporting dynamic document
        ************************************************************************    
        
        
        ************************************************************************
        * PART 1. CORRECTING THE SMCL FILE 
        *         - Removing indents before special notations
        *         - Loop correction
        *         - Changing "." to "{com}."
        ************************************************************************
        tempfile tmp //DEFINE tmp FOR THE FIRST TIME
        tempname hitch knot 
        qui file open `hitch' using `"`input'"', read
        qui file open `knot' using `"`tmp'"', write replace
        *file write `knot'  _newline 
        file read `hitch' line
    
        // IF THE DOCUMENT IS IN LATEX MARKUP, BEGIN WITH VERBATUM
        // It is not clear if the user wishes to write his own LaTeX document or 
        // just create a tex file. This requires post processing to erase the 
        // unnecessary \begin{verbatum}
        if "`markup'" == "latex" & "`style'" != "empty" {
            file write `knot' "\begin{verbatim}" _n
        }
                    
                
        while r(eof) == 0 { 
            local jump
            local jump2
            
            // -----------------------------------------------------------------
            // Change the accents 
            // ================================================================= 
            local line : subinstr local line "`" "{c 96}", all
            local line : subinstr local line "'" "{c 39}", all
            
            // -----------------------------------------------------------------
            // replacing the "dots" with "{com}. "
            // ================================================================= 
            if substr(`"`macval(line)'"',1,1) == "." & `"`macval(line)'"' > "." {   
                local line : subinstr local line "." "{com}."
            }
            
            // -----------------------------------------------------------------
            // LOOP CORRECTION 
            // ================================================================= 
            if substr(`"`macval(line)'"',1,5) == "{txt}" &                      ///
            substr(`"`macval(line)'"',9,6) == "{com}."  {
                local preline `"`macval(line)'"'
                local preline = substr(`"`macval(preline)'"',15,.)
                
                //remove numbering system
                if missing("`numbered'") {
                    *local line `"{txt}   {com}. `macval(preline)'"'
                    local line = substr(`"`macval(line)'"',9,.)
                }
                
                // Figure Interpretation
                // -------------------------------------------------------------
                if substr(trim(`"`macval(preline)'"'),1,5) == "/***$" &         ///
                "`export'" == "html" {
                    
                    local figure 1                      // indicator
                    
                    file write `knot' _n
                    
                    if substr(trim(`"`macval(preline)'"'),1,6) == "/***$$" {
                        file write `knot' "//FIGURENEW" 
                        local preline : subinstr local preline "/***$$" "/***"
                    }
                    else if substr(trim(`"`macval(preline)'"'),1,5) == "/***$" {
                        file write `knot' "//FIGURECONTINUE" 
                        local preline : subinstr local preline "/***$" "/***"
                    }
                    
                }
                if substr(trim(`"`macval(preline)'"'),1,5) == "/***$" &         ///
                "`export'" != "html" {
                    
                    file write `knot' _n
                    
                    if substr(trim(`"`macval(preline)'"'),1,6) == "/***$$" {
                        local preline : subinstr local preline "/***$$" "/*"
                    }
                    else if substr(trim(`"`macval(preline)'"'),1,5) == "/***$" {
                        local preline : subinstr local preline "/***$" "/*"
                    }
                }
                
                
                // Text Interpretation
                // -------------------------------------------------------------
                if substr(trim(`"`macval(preline)'"'),1,4) == "/***"   &        ///
                 substr(trim(`"`macval(preline)'"'),1,5)   != "/***/"  &        ///
                 substr(trim(`"`macval(preline)'"'),1,5)   != "/****"  {
                    
                    file write `knot' _n
                    file read `hitch' line
            
                    while substr(`"`macval(line)'"',1,1) == ">" {
                        local preline `"`macval(line)'"'
                        local preline : subinstr local preline ">" ""
                        ocal preline : subinstr local preline " " "    ", all //convert tab to 4 spaces
*                       local preline = trim(`"`macval(preline)'"')  //THIS WILL RUIN MARKDOWN
                        file write `knot' `">`macval(preline)'"' _n 
                        file read `hitch' line
                    }
                    local jump2 1
                    local jump  1
                }
                
                
                // Special notations
                // -------------------------------------------------------------
                if substr(trim(`"`macval(preline)'"'),1,9) == "qui log c" |     ///
                substr(trim(`"`macval(preline)'"'),1,11) == "qui log off" |     ///
                substr(trim(`"`macval(preline)'"'),1,10) == "qui log on"  |     ///
                substr(trim(`"`macval(preline)'"'),1,11) == "qui markdoc" |     ///
                substr(trim(`"`macval(preline)'"'),1,8)  == "markdoc " {
                    local jump 1
                }
                
                
                // Hiding comments
                // -------------------------------------------------------------
                if substr(trim(`"`macval(preline)'"'),1,2) == "//" |            ///
                substr(trim(`"`macval(preline)'"'),1,1) ==    "*" {             
                    local jump 1
                }
            }
            

            // -----------------------------------------------------------------
            // Stata & Mata Correction
            // =================================================================
            if substr(`"`macval(line)'"',1,6) == "{com}." |                     ///     
            substr(`"`macval(line)'"',1,6) == "{com}:" |                        ///
            substr(`"`macval(line)'"',1,1) == ":" {     
                local preline `"`macval(line)'"'
                local preline : subinstr local preline "{com}." ""
                local preline : subinstr local preline "{com}:" ""
                if substr(`"`macval(line)'"',1,1) == ":" {
                    local preline : subinstr local preline ":" ""
                }   
                
                
                
                // Figure Interpretation
                // -------------------------------------------------------------
                if substr(trim(`"`macval(preline)'"'),1,5) == "/***$" &         ///
                "`export'" == "html" {
                    
                    
                    file write `knot' _n
                    
                    
                    if substr(trim(`"`macval(preline)'"'),1,6) == "/***$$" {
                        capture file close `fig'
                        local figure = `figure' + 1     // indicator
                        tempfile f`figure'
                        tempname fig 
                        file write `knot' "//FIGURENEW" 
                        file read `hitch' line
                        
                        qui file open `fig' using "`f`figure''", write replace
                        
                        while substr(`"`macval(line)'"',1,1) == ">" {
                            local preline `"`macval(line)'"'
                            local preline : subinstr local preline ">" ""
                            local preline = trim(`"`macval(preline)'"')
                            if substr(trim(`"`macval(preline)'"'),1,4) != "***/" {
                                file write `fig' `"`macval(preline)'"' _n 
                            }   
                            file read `hitch' line
                        }
                        
                    }
                    else if substr(trim(`"`macval(preline)'"'),1,5) == "/***$" {
                        
                        file read `hitch' line
                        
                        while substr(`"`macval(line)'"',1,1) == ">" {
                            local preline `"`macval(line)'"'
                            local preline : subinstr local preline ">" ""
                            local preline = trim(`"`macval(preline)'"')
                            if substr(trim(`"`macval(preline)'"'),1,4) != "***/" {
                                file write `fig' `"`macval(preline)'"' _n 
                            }   
                            file read `hitch' line
                        }
                    }
                }
                
                // If export is not HTML, hide them
                if substr(trim(`"`macval(preline)'"'),1,5) == "/***$" &         ///
                "`export'" != "html" {
                    
                    file write `knot' _n
                    
                    if substr(trim(`"`macval(preline)'"'),1,6) == "/***$$" {
                        local preline : subinstr local preline "/***$$" "/*"
                    }
                    else if substr(trim(`"`macval(preline)'"'),1,5) == "/***$" {
                        local preline : subinstr local preline "/***$" "/*"
                    }
                }
                
                // Text Interpretation
                // -------------------------------------------------------------
                if substr(trim(`"`macval(preline)'"'),1,4) == "/***"   &        ///
                 substr(trim(`"`macval(preline)'"'),1,5)   != "/***/"  &        ///
                 substr(trim(`"`macval(preline)'"'),1,5)   != "/****"  {
                    
                    file write `knot' _n 
                    file read `hitch' line
            
                    while substr(`"`macval(line)'"',1,1) == ">" {
                        local preline `"`macval(line)'"'
                        local preline : subinstr local preline ">" ""
                        local preline : subinstr local preline "    " "    ", all //convert tab to 4 spaces
*                       local preline = trim(`"`macval(preline)'"')
                        file write `knot' `">`macval(preline)'"' _n 
                        file read `hitch' line
                    }
                    local jump2 1
                    local jump  1
                }
                
                // Special notations
                // -------------------------------------------------------------
                if substr(trim(`"`macval(preline)'"'),1,5) == "/***/" |         ///
                substr(trim(`"`macval(preline)'"'),1,4) ==    "/**/"  |         ///
                substr(trim(`"`macval(preline)'"'),1,4) ==    "//ON"  |         ///
                substr(`trim'(`"`macval(preline)'"'),1,8) ==  "//IMPORT"  |     ///
                substr(trim(`"`macval(preline)'"'),1,5) ==    "//OFF" {     
            
                    local preline = trim(`"`macval(preline)'"')
                    local line `"{com}. `macval(preline)'"'
                }
                
                if substr(trim(`"`macval(preline)'"'),1,9) == "qui log c" |     ///
                substr(trim(`"`macval(preline)'"'),1,11) == "qui log off" |     ///
                substr(trim(`"`macval(preline)'"'),1,10) == "qui log on"  |     ///
                substr(trim(`"`macval(preline)'"'),1,11) == "qui markdoc" |     ///
                substr(trim(`"`macval(preline)'"'),1,8)  == "markdoc " {
                    local jump 1
                }
                
                // Hiding comments
                // -------------------------------------------------------------
                if substr(trim(`"`macval(preline)'"'),1,2) == "//" &            ///
                substr(trim(`"`macval(preline)'"'),1,5) != "//OFF" &            ///
                substr(trim(`"`macval(preline)'"'),1,4) !=  "//ON" &            ///
                substr(`trim'(`"`macval(preline)'"'),1,8) !=  "//IMPORT" {              
                    local jump 1
                }
                
                if substr(trim(`"`macval(preline)'"'),1,1) ==    "*" {              
                    local jump 1
                }
                
                if substr(trim(`"`macval(preline)'"'),1,2) ==  "/*"    &        ///
                substr(trim(`"`macval(preline)'"'),1,4)    !=  "/**/"  &        ///
                substr(trim(`"`macval(preline)'"'),1,5)    !=  "/***/" &        ///
                substr(trim(`"`macval(preline)'"'),1,4)    !=  "/***"  |        ///
                substr(trim(`"`macval(preline)'"'),1,5)    ==  "/****" {
                    local preline = trim(`"`macval(preline)'"')
                    local line `"{com}. `macval(preline)'"'
                }
            }
            
            //remove MarkDoc output text
            if substr(trim(`"`macval(line)'"'),1,16) == "(MarkDoc created"      ///
            | substr(trim(`"`macval(line)'"'),1,19) == "{p}(MarkDoc created" {
                local jump 1        
            }
                    
            
            if missing("`jump'") {

                file write `knot' `"`macval(line)'"' _n 
            }   
            if missing("`jump2'") {
                file read `hitch' line
            }   
        }
                                
        file close `knot'
        capture file close `fig'
        
        if !missing("`debug'") {
            capture erase 0process1.smcl
            copy "`tmp'" 0process1.smcl , replace       //For debugging
        }
        
        
        //copy "`f1'" fig1.txt, replace 
        //copy "`f`figure''" fig2.txt, replace
        

        
        ********************************************************************
        * PART 2- PROCESSING SMCL: 
        *
        *           1) Add empty line after comments followed by a command
        *           2) Add an empty line if {res} is abruptly follow by {com}
        *           3) Add an empty line after long commands (also in braces)
        *           4) ADDING AN EMPTY LINE BETWEEN COMMAND AND OUTPUT
        *           5) HIDING COMMANDS/COMMENTS for /**/ & "*" MARKER
        *           6) HIDING OUTPUTS for /***/ MARKER
        *           7) HIDING //OFF - //ON
        *           8) HIDING //COMMAND - //END
        *           9) HIDING //RESULT - //END
        *           10) HIDING COMMENTS
        *           11) MANIPULATE COMMENT MARKERS
        *           12) REMOVING EMPTY LINES
        *           13) REMOVING txt COMMAND
        *           14) REMOVING img COMMAND
        *           15) REMOVING tble COMMAND
        *           16) REMOVING MATA FUNCTION
        ********************************************************************
        tempfile tmp1                           //DEFINE tmp1 FOR THE FIST TIME
        tempname hitch knot 
        qui file open `hitch' using "`tmp'", read
        qui file open `knot' using `"`tmp1'"', write replace
        *file write `knot' _newline 
        file read `hitch' line
        while r(eof) == 0 { 
            
            local jump                              // RESET JUMP
            local word1 : word 1 of `"`macval(line)'"'
            local pre1 : word 1 of `"`previousline'"'   //Previous line
            
            ********************************************************************
            * 1) add empty line after comments followed by a command
            ********************************************************************
            if substr(`"`macval(pre1)'"',1,1) == ">" {
                if substr(`"`macval(word1)'"',1,5) == "{com}" {
                    file write `knot' _newline
                }
            }
            
            ****************************************************************
            * 2) Add an empty line if {res} is abruptly follow by {com}
            ****************************************************************
            if substr(`"`macval(pre1)'"',1,5) == "{res}" {
                if substr(`"`macval(word1)'"',1,5) == "{com}" {
                    file write `knot' _newline
                }
            }
            
            ****************************************************************
            * 3) Add an empty line after long commands (also in braces)
            ****************************************************************
            if substr(`"`macval(pre1)'"',1,7) == "{com}. " |                    ///
            substr(`"`macval(pre1)'"',9,7) == "{com}. " {
                    
                if substr(`"`macval(pre1)'"',-4,.) == " ///" |                  ///
                substr(`"`macval(pre1)'"',-3,.) == " /*" |                      ///
                substr(`"`macval(pre1)'"',-3,.) == "/* " {

                    *When the /* */ sign is used to move to the next line, avoid
                    *the * to be interpreted as a Markdown Italic sign
                    while substr(`"`macval(word1)'"',1,1) == ">" & r(eof) == 0 {                    
                        local line : subinstr local line "*/" "\*/"
                        local line : di substr(`"`macval(line)'"',2,.)              
                        file write `knot' `"`macval(line)'"' _n
                        file read `hitch' line
                        local word1 : word 1 of `"`macval(line)'"'
                        local next next
                    }
                    
                    if "`next'" == "next" {
                        file write `knot' _newline      //Add empty line
                    }   
                } 
                
                
                
                ****************************************************************
                * 4) ADDING AN EMPTY LINE BETWEEN COMMAND AND OUTPUT
                ****************************************************************
                if substr(`"`macval(word1)'"',1,1) == ">" {
                    while substr(`"`macval(word1)'"',1,1) == ">" & r(eof) == 0 {
                        file write `knot' `"`macval(line)'"' _n
                        file read `hitch' line                          
                        local word1 : word 1 of `"`macval(line)'"'
                    }
                    if `"`macval(line)'"' != "" {
                        file write `knot' _n
                    }
                }
            }
            
            
            ****************************************************************
            * 5) HIDING "/**/" "*" and "//" Comments
            ****************************************************************
            if substr(`"`macval(word1)'"',1,8) == "{com}. *" |                  ///
            ///& substr(`"`macval(word1)'"',1,9) != "{com}. *:" |               ///
            substr(`"`macval(word1)'"',1,9) == "{com}. //" |                    ///
            substr(`"`macval(word1)'"',1,9) == "{com}: //" |                    ///
            substr(`"`macval(word1)'"',1,4) == ": //" |                         ///
            substr(`"`macval(word1)'"',1,11) == "{com}. /**/" { 
            
                if substr(`"`macval(word1)'"',1,12) != "{com}. //OFF" &         ///
                substr(`"`macval(word1)'"',1,11) != "{com}. //ON" &             ///
                substr(`"`macval(word1)'"',1,15) != "{com}. //IMPORT" {
                    //Read the next line! and make sure it does not start with  
                    //">" Otherwise read another line                   
                    file read `hitch' line
                    local word1 : word 1 of `"`macval(line)'"'
                                
                    // Repeat this action for consequent lines
                    while substr(`"`macval(word1)'"',1,8) == "{com}. *"         ///
                    | substr(`"`macval(word1)'"',1,9) == "{com}. //" &          ///
                        r(eof) == 0                                             ///
                    | substr(`"`macval(word1)'"',1,1) == ">" & r(eof) == 0      /// 
                    | substr(`"`macval(word1)'"',1,4) == ": //" & r(eof) == 0   ///
                    | substr(`"`macval(word1)'"',1,11) == "{com}. /**/" &       ///
                    r(eof) == 0 {
                        file read `hitch' line
                        local word1 : word 1 of `"`macval(line)'"'
                    }
                }   
            }
            
            ****************************************************************
            * 6) HIDING /***/ results
            ****************************************************************
            // when the command begins with /***/ marker, follow all the output
            // and remove them all until the next command {com.}
            if substr(`"`macval(word1)'"',1,12) == "{com}. /***/"  {
                
                
                // Write it down and read the next line to check if the 
                // command continues to next lines                  
                //Read the next line! and make sure it does not start with ">" 
                //Otherwise it means this is the rest of the command
                
                
                // Repeat this action for consequent lines
                while substr(`"`macval(word1)'"',1,12) == "{com}. /***/"        ///
                & r(eof) == 0  {
                    
                    //di as err "FOUND ONE"
                    
                    local line : subinstr local line `"{com}. /***/"' "{com}.", all
                    //di as err `"`macval(line)'"'
                    
                    file write `knot' `"`macval(line)'"' _n
                    file read `hitch' line
                    local word1 : word 1 of `"`macval(line)'"'
                        
                    //If the command continues, continue writing    
                    while substr(`"`macval(word1)'"',1,1) == ">" & r(eof) == 0 {
                        file write `knot' `"`macval(line)'"' _n
                        file read `hitch' line
                        local word1 : word 1 of `"`macval(line)'"'
                    }
                        
                    // REMOVE THE OUTPUT
                    // =================
                    if substr(`"`macval(word1)'"',1,12) != "{com}. /***/"  {
                        while substr(`"`macval(word1)'"',1,6) != "{com}."       ///
                        & r(eof) == 0 {
                            file read `hitch' line
                            local word1 : word 1 of `"`macval(line)'"'
                        }   
                    }
                }   
            }
                
            ****************************************************************
            * 7) HIDING //OFF : Remove anything between //OFF and //ON
            ****************************************************************
            if substr(`"`macval(word1)'"',1,12) == "{com}. //OFF"  {    
                
                while substr(`"`macval(word1)'"',1,11) != "{com}. //ON" &       /// 
                r(eof) == 0 {
                    file read `hitch' line
                    local word1 : word 1 of `"`macval(line)'"'
                }
                    
                // Also remove the //ON
                if substr(`"`macval(word1)'"',1,11) == "{com}. //ON" {
                    file write `knot' _n
                    file read `hitch' line
                    local word1 : word 1 of `"`macval(line)'"'
                }
            }
                
            ****************************************************************
            * 8) HIDING //COMMAND : Only keep the commands
            * >>>>>>>>>> UNDER DEVELOPMENT <<<<<<<<<<<
            ****************************************************************
            
            ****************************************************************
            * 9) HIDING //RESULT : Only keep the output
            * >>>>>>>>>> UNDER DEVELOPMENT <<<<<<<<<<<
            ****************************************************************
            
            ****************************************************************
            * 10) HIDING COMEMNTS : Remove anything between /* and */
            ****************************************************************
                
            while substr(`"`macval(word1)'"',1,9) == "{com}. /*"  &             ///
            substr(`"`macval(word1)'"',1,11) != "{com}. /***"     |             ///
            substr(`"`macval(word1)'"',1,12) == "{com}. /****" {    
                        
                file read `hitch' line
                local word1 : word 1 of `"`macval(line)'"'
                            
                while substr(`"`macval(word1)'"',1,1) == ">" &              ///
                r(eof) == 0 {
                    file read `hitch' line
                    local word1 : word 1 of `"`macval(line)'"'
                }
            }   
            
            
            
            ****************************************************************
            * 11) MANIPULATING COMMENT MARKERS : Changing the comment signs
            ****************************************************************

            //Remove "***/"
            //=============
            if trim(substr(trim(`"`macval(line)'"'),2,.)) == "***/" {
                local line : subinstr local line "***/" ""  
            }
            

            ****************************************************************
            * 12) REMOVING EMPTY LINES
            ****************************************************************
            // removing the lines that only have "{com}. "
            // NOTE: the "{txt}" can add a line between results and next cmd
            if trim(`"`macval(line)'"') == "{com}." |                           ///
            trim(`"`macval(line)'"') == "." |                                   ///
            trim(`"`macval(line)'"') == "{com}:" |                              ///
            trim(`"`macval(line)'"') == ": "                                    ///
            /// | `"`macval(line)'"' == "{txt}" 
            {
                local jump jump
            }
                                
            
            ****************************************************************
            * 13) REMOVING WEAVER COMMANDS
            *     - txt
            *     - img
            *     - tble 
            ****************************************************************
            //If the next line does NOT begin with "{txt}>" read 
            // then read another line. Which means the text was long
            if substr(`"`macval(line)'"',1,6) == "{com}." {
                local ln `"`macval(line)'"'
                local ln : subinstr local ln "{com}." ""
                
                // Problem
                // =======
                // the "txt" command might be used for multi-line long paragraphs. 
                // when the text is multi-line. the "txt" command always ends with a 
                // "{res} ".In a loop, however, the next command comes immediately!
                
                if substr(trim(`"`macval(ln)'"'),1,4) == "txt " {       
                    local txtcommand found          //FOR POST PROCESSING                       
                    file read `hitch' line                          
                    local word1 : word 1 of `"`macval(line)'"'
                    
                    
                    if substr(`"`macval(word1)'"',1,5) != "{txt}" &             ///
                    substr(`"`macval(word1)'"',1,5) != "{com}" &            ///
                    trim(`"`macval(line)'"') != "" {
                    
                        ///while substr(`"`macval(line)'"',1,6) != "{txt}>" &       ///
                        ///while substr(`"`macval(word1)'"',1,2) == "> " &      ///
                        ///substr(`"`macval(word1)'"',1,4) != ">~~~" &          ///
                        while trim(`"`macval(line)'"') != "{res}" &                     ///
                        substr(`"`macval(word1)'"',1,5) != "{com}" &            ///
                        r(eof) == 0 {
                            file read `hitch' line
                            local word1 : word 1 of `"`macval(line)'"'
                        }
                    }               
                }
            
                
                if substr(trim(`"`macval(ln)'"'),1,.) == "img"                  ///
                | substr(trim(`"`macval(ln)'"'),1,9) == "img using"             ///
                |  substr(trim(`"`macval(ln)'"'),1,4) == "img," {
                    
                    file read `hitch' line
                    while substr(`"`macval(line)'"',1,1) == ">" & r(eof) == 0 & ///
                    substr(`"`macval(line)'"',1,3) != ">//" {
                        file read `hitch' line                          
                    }
                }
                
                if substr(trim(`"`macval(ln)'"'),1,4) == "tbl "                 ///
                |  substr(trim(`"`macval(ln)'"'),1,5) == "tble " {
                    file read `hitch' line
                    while substr(`"`macval(line)'"',1,1) == ">" & r(eof) == 0 & ///
                    substr(`"`macval(line)'"',1,3) != ">//" {
                        file read `hitch' line                          
                    }
                }
            }
            
            
            ****************************************************************
            * 16) PRESERVING mata Function
            ****************************************************************
            if substr(`"`macval(word1)'"',1,15) == "{com}: function"            ///
            | substr(`"`macval(word1)'"',1,10) == ": function"{
                file write `knot' `"`macval(line)'"' _n
                file read `hitch' line                                      
                
                while substr(`"`macval(line)'"',1,6) != ": end " &      ///
                r(eof) == 0 & `"`macval(line)'"' != ": " &                      ///
                `"`macval(line)'"' != "" {  
                    if substr(`"`macval(line)'"',1,1) == ">" & ///
                    substr(`"`macval(line)'"',1,3) != ">//" {       
                        local line : subinstr local line ">" " "
                    }
                    if substr(`"`macval(line)'"',1,3) == ">//" {
                        local line : subinstr local line ">//" "    //"
                    }
                    file write `knot' `"`macval(line)'"' _n
                    file read `hitch' line                          
                    local word1 : word 1 of `"`macval(line)'"'
                }
            
            }
            
            //COPY THE CURRENT LINE. It is used in the next round
            local previousline `"`macval(line)'"' 
            
            if substr(trim(`"`macval(line)'"'),1,19) ==  "{txt}end of do-file" {
                local jump 1
            }
                
            
            if "`jump'" == "" { 
                file write `knot' `"`macval(line)'"' _n 
            }
            file read `hitch' line
                
        }

        file close `knot'       
        
        if !missing("`debug'") {
            capture erase 0process2.smcl
            copy "`tmp1'" 0process2.smcl    , replace           //for debugging
        }
        
        
        
        
        ********************************************************************
        * GUESSING THE DOCUMENTATION LINESIZE
        ********************************************************************
        if missing("`linesize'") {
            local clinesize "`c(linesize)'"                     //save the linesize
            tempfile sth 
            tempname hitch knot 
            qui file open `hitch' using "`tmp1'", read
            file read `hitch' line
            local linelength 1
            while r(eof) == 0 {
                local pass
                cap if substr(`"`macval(line)'"',1,1) == ">" local pass 1
                if !missing("`pass'") {
                    cap local m = strlen(`"`macval(line)'"') 
                    if `m' > `linelength' {
                        local linelength `m'
                    }               
                }   
                file read `hitch' line
            }
            file close `hitch'
            local pass
            
            // the problem happens if:
            // -----------------------
            if `linelength' > `c(linesize)' {
                if `linelength' > 255 {
                    di as err _n(2) "{title:Warning}"
                    di as err "{p}your documentation has a width of "           ///
                    "`linelength' which is beyond the limit of Stata. This "    ///
                    "can corrupt your document... avoid writing very long "     ///
                    "lines in the document. " _n
                    
                    qui set linesize 255
                    *error 198
                }
                else {
                    di as txt _n(2) "{title:Warning}"
                    di as txt "{p}your documentation has a width of "           ///
                    "`linelength', while your Stata has linesize of "           ///
                    "`c(linesize)'. {help markdoc} automatically adjusts your " ///
                    "document width. You can avoid this warning by increasing " ///
                    "Stata's {bf:linesize} or by writing shorter lines" _n
                    
                    qui set linesize `linelength'
                }   
            }
            
            // display the original inelength and linesize
            if !missing("`noisily'") {
                di as txt _n(2) "{title:Linesize}" _n
                display as txt "    DOCUMENT WIDTH: `linelength'" 
                display as txt "SPECIFIED LINESIZE: `clinesize'" _n
            }
        }
    
        ********************************************************************
        *CREATING CODE BLOCK WITH txt [code] COMMAND
        *
        * If the txt [code] command is used consequently, remove empty space
        * between the code lines. This code chunk only gets executed if the 
        * txt command was applied. 
        ********************************************************************
        
        if "`txtcommand'" == "found" {
            tempfile tmp
            quietly  copy `"`tmp1'"' `"`tmp'"', replace
            tempfile tmp1
            tempname hitch knot 
            qui file open `hitch' using `"`tmp'"', read
            qui file open `knot' using `"`tmp1'"', write replace
            *file write `knot'  _newline 
            file read `hitch' line
            while r(eof) == 0 {
                if substr(`"`macval(word1)'"',1,4) == ">~~~" {
                    local linecopy `"`macval(line)'"'
                    file read `hitch' line  
                    if `"`macval(line)'"' == "" {
                        local linecopy2 `"`macval(line)'"'
                        file read `hitch' line
                        local word1 : word 1 of `"`macval(line)'"'
                        if substr(`"`macval(word1)'"',1,4) == ">~~~" {
                            file read `hitch' line                          
                            local word1 : word 1 of `"`macval(line)'"'
                        }
                        else file write `knot' `"`macval(linecopy)'"' _n(2)     
                    }
                    else file write `knot' `"`macval(linecopy)'"' _n
                }
                file write `knot' `"`macval(line)'"' _n
                file read `hitch' line                          
                local word1 : word 1 of `"`macval(line)'"'
            }

            file close `knot'
            file close `hitch'  
            
            if !missing("`debug'") {
                copy "`tmp1'" 0process2B.smcl   , replace
            }   
        }
            

            
        ********************************************************************
        *PROCESSING SMCL: 1) APPENDING LONG LINES IN COMMANDS AND BRACES
        *                 2) ADDING AN EMPTY LINE BETWEEN COMMAND AND OUTPUT
        *
        *   >>>>>>>>>> UNDER DEVELOPMENT <<<<<<<<<<
        ********************************************************************
        

        ********************************************************************
        *Statax WEAVER EXPORT: ADD <pre class="sh_stata">
        ********************************************************************
        if "`statax'" == "statax" & "`export'" == "html" |                      ///
            "`statax'" == "statax" & "`export'" == "pdf" {
            tempfile tmp
            quietly  copy `"`tmp1'"' `"`tmp'"', replace
            tempfile tmp1
            tempname hitch knot 
            qui file open `hitch' using `"`tmp'"', read
            qui file open `knot' using `"`tmp1'"', write replace
            file write `knot'  _newline 
            file read `hitch' line      
            while r(eof) == 0 {
                local word1 : word 1 of `"`macval(line)'"'  
                while substr(`"`macval(word1)'"',1,7) == "{com}. " {
                
                    //PROCESS THE PROGRAMS DIFFERENTLY
                    //================================
                    if substr(`"`macval(word1)'"',1,12) == "{com}. prog " |     ///
                    substr(`"`macval(word1)'"',1,13) == "{com}. progr " |       ///
                    substr(`"`macval(word1)'"',1,14) == "{com}. progra " |      ///
                    substr(`"`macval(word1)'"',1,15) == "{com}. program " |     ///
                    {
                            
                        file write `knot' `"><pre class="sh_stata">  "'
                        file write `knot' `"`macval(line)'"' _n
                        file read `hitch' line                          
                        local word1 : word 1 of `"`macval(line)'"'
                        while substr(`"`macval(word1)'"',-5,.) != ". end"       ///
                        & r(eof) == 0 {
                                
                            //BREAK FOR COMMENTS
                            //------------------
                            if substr(`"`macval(word1)'"',1,1) == ">" { 
                                file write `knot' `"</pre>"' _n
                                while substr(`"`macval(word1)'"',1,1) == ">"    ///
                                & r(eof) == 0 {
                                    file write `knot' `"`macval(line)'"' _n
                                    file read `hitch' line                          
                                    local word1 : word 1 of `"`macval(line)'"'
                                }
                        
                                //Jump the empty lines
                                while substr(`"`macval(word1)'"',1,.) == ""     ///
                                & r(eof) == 0 {
                                    file read `hitch' line                          
                                    local word1 : word 1 of `"`macval(line)'"'
                                }
                        
                                file write `knot' `"><pre class="sh_stata">  "' _n
                            }   
                                
                            file write `knot' `"`macval(line)'"' _n
                            file read `hitch' line                          
                            local word1 : word 1 of `"`macval(line)'"'                      
                        }
                            
                        if substr(`"`macval(word1)'"',-5,.) == ". end" {
                            file write `knot' `"`macval(line)'"' _n
                            file read `hitch' line                          
                            local word1 : word 1 of `"`macval(line)'"'
                        }
                            
                        file write `knot' `"</pre>"' _n

                    }
                        
                
                    //PROCESS THE MATA DIFFERENTLY
                    //================================
                    if substr(`"`macval(word1)'"',1,11) == "{com}. mata" {      
                        file write `knot' `"><pre class="sh_stata">  "'
                        file write `knot' `"`macval(line)'"' _n
                        file read `hitch' line                          
                        local word1 : word 1 of `"`macval(line)'"'          
                        while substr(`"`macval(word1)'"',-12,.) !=              ///
                        "{txt}{hline}" & r(eof) == 0 {
                                
                            //BREAK FOR COMMENTS
                            //------------------
                            if substr(`"`macval(word1)'"',1,1) == ">" { 
                                file write `knot' `"</pre>"' _n
                                while substr(`"`macval(word1)'"',1,1) == ">"    ///
                                & r(eof) == 0 {
                                    file write `knot' `"`macval(line)'"' _n
                                    file read `hitch' line                          
                                    local word1 : word 1 of `"`macval(line)'"'
                                }
                                    
                                //Jump the empty lines
                                while substr(`"`macval(word1)'"',1,.) == ""     ///
                                & r(eof) == 0 {
                                    file read `hitch' line                          
                                    local word1 : word 1 of `"`macval(line)'"'
                                }       
                                file write `knot' `"><pre class="sh_stata">  "' _n
                            }
                                
                                
                            //SEPARATE OUTPUT
                            //---------------
                                
                            if substr(`"`macval(word1)'"',1,5) == "{res}" {             
                                file write `knot' `"</pre>"' _n     
                                file write `knot' `"><pre class="output">  "' _n        
                                file write `knot' `"`macval(line)'"' _n
                                file read `hitch' line                          
                                local word1 : word 1 of `"`macval(line)'"'
                                while substr(`"`macval(word1)'"',1,6) !=        ///
                                "{com}:" & r(eof) == 0 {
                                    file write `knot' `"`macval(line)'"' _n
                                    file read `hitch' line                          
                                    local word1 : word 1 of `"`macval(line)'"'
                                }
                                file write `knot' `"</pre>"' _n
                                file write `knot' `"><pre class="sh_stata">  "' _n              
                            }
                                
                            file write `knot' `"`macval(line)'"' _n
                            file read `hitch' line                          
                            local word1 : word 1 of `"`macval(line)'"'                      
                        }
                            
                        if substr(`"`macval(word1)'"',-12,.) == "{txt}{hline}" {
                            file write `knot' `"`macval(line)'"' _n
                            file read `hitch' line                          
                            local word1 : word 1 of `"`macval(line)'"'
                        }   
                            
                        file write `knot' `"</pre>"' _n
                    }
                        
                    // PROCESSING COMMANDS
                    // ===================
                    if substr(`"`macval(word1)'"',1,7) == "{com}. " &           ///
                    substr(`"`macval(word1)'"',1,12) != "{com}. prog " &        ///
                    substr(`"`macval(word1)'"',1,13) != "{com}. progr " &       ///
                    substr(`"`macval(word1)'"',1,14) != "{com}. progra " &      ///
                    substr(`"`macval(word1)'"',1,15) != "{com}. program " &     ///
                    {
                        file write `knot' `"><pre class="sh_stata">  "'
                        file write `knot' `"`macval(line)'"' // don't add new line
                        file read `hitch' line                          
                        local word1 : word 1 of `"`macval(line)'"'
                            
                        if substr(`"`macval(word1)'"',1,1) == ">" {
                            file write `knot' _n            // add new line
                            while substr(`"`macval(word1)'"',1,1) == ">"        ///
                            & r(eof) == 0 {
                                file write `knot' `"`macval(line)'"' _n
                                file read `hitch' line                          
                                local word1 : word 1 of `"`macval(line)'"'
                            }
                            file write `knot' `"></pre>"' _n
                        }
                        else file write `knot' `"</pre>"' _n
                    }
                     
                }

                file write `knot' `"`macval(line)'"' _n
                file read `hitch' line      
            }

            file close `knot'
            file close `hitch'
        
            if !missing("`debug'") {
                copy "`tmp1'" 0process2C.smcl   , replace   
            }   
        }
            

        ********************************************************************
        *TABLE OPTION: CREATING PUBLICATION READY TABLES
        * >>>>>>>>>> UNDER DEVELOPMENT <<<<<<<<<<
        ********************************************************************
    }       





        // ---------------------------------------------------------------------
        // THE SCRIPT FILE ENGINE
        // =====================================================================        
        if !missing("`scriptfile'") {   
            tempfile tmp3
            global localfile "`tmp3'"
            markup `smclfile', export("`export'") `replace' localfile("$localfile")
            
            if !missing("`debug'") {
                display as txt _n(2) "{title:extracting documentation}" _n 
                copy "$localfile" 0documentation.txt, replace
            }
        }   
        

        // ---------------------------------------------------------------------
        // FIGURE PROCESSING
        // =====================================================================
        
        //copy "`tmp1'" 0process2D.smcl , replace   
        
        if !missing("`figure'") {                           
            quietly  copy `"`tmp1'"' `"`tmp'"', replace
            tempfile tmp1
            
            tempname hitch knot 
            qui file open `hitch' using "`tmp'", read
            qui file open `knot' using `"`tmp1'"', write replace
            file write `knot' _newline 
            file read `hitch' line
            local figure
            while r(eof) == 0 { 
                    
                
                
                if substr(`"`macval(line)'"',1,11) == "//FIGURENEW" {
                    local figure = `figure' + 1     
                    
                    qui file open `fig' using "`f`figure''", read 
                    
                    file write `knot' "><script>" _n                            ///
                    ">document.body.innerHTML += Viz("  _n                      ///
                    //"'digraph { ' +" _n                                       ///
                    
                    file read `fig' figline
                    
                    while r(eof) == 0 {
                        if !missing(`trim'(`"`macval(figline)'"')) {
                            file write `knot' "'" `"`macval(figline)'"' "'"
                        }   
                        
                        file read `fig' figline
                        
                        if !missing(`trim'(`"`macval(figline)'"')) {
                            file write `knot' " +" _n
                        }   
                        
                    }
                    file write `knot' _n /// ">'} '" _n                                 ///
                    `">);"' _n                                                  ///
                    "></script>" _n
                    
                    file close `fig'
                }
                
                else file write `knot' `"`macval(line)'"' _n
                
                file read `hitch' line
            }
            file close `knot'
            file close `hitch'
            
            
            if !missing("`debug'") {
                copy "`tmp1'" 0process3.smcl, replace
            }
        }   
        
    
            
        
        ********************************************************************
        *PART 3A- TRANSLATING SMCL TO TXT
        ********************************************************************
        tempfile tmp
        
        if  missing("`scriptfile'") {
            quietly  copy `"`tmp1'"' `"`tmp'"', replace
        }   
    
        *Save the current setting of the translator
        qui translator query smcl2txt
        
        *Save the default linesize of the translator
        local savelinesize `r(linesize)'
        local savemargin `r(lmargin)'
        translator set smcl2txt linesize `c(linesize)'
        
        if  missing("`scriptfile'") translator set smcl2txt lmargin 6
        if !missing("`scriptfile'") translator set smcl2txt lmargin 0
        
        if "`numbered'" == "numbered" {
            if "`r(cmdnumber)'" == "off" {
                local savecmdnumber off
                translator set smcl2txt cmdnumber on
            }
        } 
        else if "`r(cmdnumber)'" == "on" {
                local savecmdnumber on
                translator set smcl2txt cmdnumber off
        }
                
        if "`r(logo)'" == "on" {
            local savelogo on
            translator set smcl2txt logo off
        }       
    
        *Translating the document to TXT        
        tempfile tmp1
        
        if  missing("`scriptfile'") {
            qui translate "`tmp'" "`tmp1'", trans(smcl2txt) replace
        }   
        if !missing("`scriptfile'") {
            qui translate "$localfile" "`tmp1'", trans(smcl2txt) replace
            capture macro drop localfile
        }   
        
        *reset the users' default setting of the translator
        if !missing("`savecmdnumber'") translator set smcl2txt cmdnumber `savecmdnumber'
        if "`savelogo'" == "on" translator set smcl2txt logo on
        
        *RESTORE THE DEFAULT LINESIZE OF THE TRANSLATOR
        translator set smcl2txt linesize `savelinesize'
        translator set smcl2txt lmargin  `savemargin'
        
        //DEBUG
        if !missing("`debug'") {
            capture erase 0process4.txt
            copy "`tmp1'" 0process4.txt , replace    //for debugging
        }   
        
        
        ********************************************************************
        * PART 3B- PROCESSING TXT
        *
        *   1) removing empty \begin{verbatum}
        *   2) APPENDING LONG LINES IN COMMANDS AND BRACES
        ********************************************************************
        tempfile tmp
        quietly  copy `"`tmp1'"' `"`tmp'"', replace
        tempfile tmp1
        tempname hitch knot 
        qui file open `hitch' using `"`tmp'"', read 
        qui cap file open `knot' using "`tmp1'", write replace
        *file write `knot'  _newline
        file read `hitch' line  
        
        //REMOVE THE EMPTY LINES IN THE HEADER
        *while missing(ustrltrim(`"`macval(line)'"')) & r(eof) == 0 {
        while missing(trim(`"`macval(line)'"')) & r(eof) == 0 {
            file read `hitch' line
        }
                            
        
        // ---------------------------------------------------------------------
        // 1- Correcting the LaTeX file by removing empty \begin{verbatum}
        // ---------------------------------------------------------------------
        if "`markup'" == "latex" & missing("`scriptfile'") {
        
            while trim(`"`line'"') == "" & r(eof) == 0   {          
                file read `hitch' line  
            }
            
            if trim(`"`macval(line)'"') == "\begin{verbatim}" {
                file read `hitch' line
                while trim(`"`line'"') == "" & r(eof) == 0   {          
                    file read `hitch' line  
                }
                if substr(trim(`"`macval(line)'"'),1,2) != ">" {
                    file write `knot' "      \begin{verbatim}" _n
                }
            }
        }
        
        //Add the title page in Markdown
        if "`export'" != "tex" & "`export'" != "pdf" & "`export'" != "html" {
            if "`markup'" == "markdown" | "`markup'" == "" {        
                tempfile tmp1
                tempname hitch knot 
                qui file open `hitch' using "`tmp'", read 
                qui cap file open `knot' using "`tmp1'", write replace
                file read `hitch' line  
                
                //REMOVE THE EMPTY LINES IN THE HEADER
                *while missing(ustrltrim(`"`macval(line)'"')) & r(eof) == 0 {
                while missing(`trim'(`"`macval(line)'"')) & r(eof) == 0 {
                    file read `hitch' line
                }
        
                if "`export'" == "docx" | "`export'" == "odt" {
                    file write `knot'                                           ///
                    "---" _n                                                    ///
                    `"title: "`title'""' _n                                     
                    
                    if "`export'" == "docx" {
                        if !missing("`author'") & missing("`affiliation'") {
                            file write `knot' `"author: "`author'""' _n
                        }
                        if missing("`author'") & !missing("`affiliation'") {
                            file write `knot' `"author: "`affiliation'""' _n
                        }
                        if !missing("`author'") & !missing("`affiliation'") {
                            file write `knot' `"subtitle: "`author'""' _n       ///
                            `"author: "`affiliation'""' _n
                        }
                        if !missing("`summary'") file write `knot'              ///
                        "abstract: `summary'" _n
                    }
                    
                    if "`export'" != "docx" & !missing("`author'") {
                        file write `knot'`"author: "`author'""' _n              
                    }
                    
                    if !missing("`date'") file write `knot'                     ///
                    `"date: "`c(current_date)'""' _n                

                    file write `knot' "---" _n 
                }
                
                else if "`export'" == "slide" | "`export'" == "slidy"           ///
                | "`export'" == "dzslide" {
                    
                    file write `knot'                                           ///
                    "---" _n    
                    
                    if !missing("`title'") {
                        file write `knot' `"title: "`title'""' _n
                    }   
                    if !missing("`subtitle'") {
                        file write `knot' `"subtitle: "`subtitle'""' _n
                    }
                    if !missing("`author'")  {
                        file write `knot' `"author: "`author'""' _n
                    }
                    if !missing("`affiliation'") {
                        file write `knot' `"date: "`affiliation'""' _n
                    }
                    file write `knot' "---" _n 
                }
                
                else {
                
                    if "`title'" != "" file write `knot'                        ///
                    "  `title'" _n                                              ///
                    "=======" _n(2)

                    if "`author'" != "" file write `knot'  "`author'   " _n(2) 
                    if "`affiliation'" != "" file write `knot'                  ///
                    "`affiliation'    " _n(2) 
                    if "`date'" != "" file write `knot'                         ///
                    "`c(current_date)'    " _n(2)  
                }
                
                if "`export'" != "slide" & "`export'" != "slidy"            ///
                & "`export'" != "dzslide" {
                
                    if "`export'" != "docx" {
                        if "`summary'" != "" file write `knot'  "`summary'    " _n(2)
                    }
                    
                    if "`address'" != "" file write `knot'  "_`address'_    " _n(2) 
                }   
            }
        }
        
        while r(eof) == 0 {
            
            // -----------------------------------------------------------------
            // Change back the accents 
            // ================================================================= 
            local line : subinstr local line "{c 96}" "`" , all
            local line : subinstr local line "{c 39}" "'" , all
            
            *local word1 : word 1 of `"`macval(line)'"'
            
            // =================================================================
            // IMPORT files
            // -----------------------------------------------------------------
            if substr(`"`macval(line)'"',1,17) == "      . //IMPORT " |         ///
               substr(`"`macval(line)'"',30,12) == "  . //IMPORT"  {            //FOR STATAX            
                local line : subinstr local line `"      ><pre class="sh_stata">  . //IMPORT "' ""
                local line : subinstr local line "      . //IMPORT " "" 
                local line : subinstr local line "</pre>" ""                    //for Statax
                local importedFile = `trim'("`line'")
                confirm file "`importedFile'"
                local line ""
                
                //Open and append the file
                //------------------------
                tempname read 
                qui file open `read' using "`importedFile'", read 
                while r(eof) == 0 {
                    file write `knot' `"`macval(line)'"' _n
                    file read `read' line
                }
                file write `knot' `"`macval(line)'"' _n
                file close `read'
                local line ""
            }
            
            
            // -----------------------------------------------------------------
            // APPENDING COMMAND LINES AND BRACES
            //
            // >>>>>>>>>> UNDER DEVELOPMENT <<<<<<<<<<
            // =================================================================

            // OUTPUTS 
            capture while substr(`"`macval(line)'"',1,6) == "      " &              /// 
            substr(`"`macval(line)'"',10,1) != "." &                            ///
            `"`macval(line)'"' != "      " &                                    ///
            substr(`"`macval(line)'"',1,7) != "      >" {
            
                local host `"`macval(line)'"'
                file read `hitch' line
                
                while substr(`"`macval(line)'"',1,8) == "      > " {
                    local line : subinstr local line "      > " "", all
                    local host `"`macval(host)'"'`"`macval(line)'"'     
                    file read `hitch' line
                }
                capture file write `knot' `"    `macval(host)'"' _n //increase dent
            }
            
            
            if substr(`"`macval(line)'"',1,7) == "      >" {
                local line : subinstr local line "      > " "", all
                local line : subinstr local line "      >" "", all  
            }
                
            if substr(`"`macval(line)'"',1,7) == "      *" {
                local line : subinstr local line "      * " "", all
                local line : subinstr local line "      *" "", all  
            }
                        
            if substr(`"`macval(line)'"',1,8) == "       >" {
                local line : subinstr local line "       > " "", all
                local line : subinstr local line "       >" "", all 
            }           
                
            if substr(`"`macval(line)'"',1,8) == "       *" {
                local line : subinstr local line "       * " "", all    
                local line : subinstr local line "       *" "", all 
            }
            
            // Kill empty spaces
            if `"`macval(line)'"' == "      " | `"`macval(line)'"' == "       " {
                local line ""
            }
            
            // Removing the "***" marker, when the document is not Slides
            // ----------------------------------------------------------
            
            // If we are not exporting to slides, remove the alternative <HR>
            if "`export'" != "slide" & "`export'" != "slidy" & "`export'"       ///
            != "dzslide" {
                local clue
                capture local clue : di trim(`"`macval(line)'"')    
                if `"`macval(clue)'"' == "***" & substr(`"`macval(line)'"',1,4) != "    " {
                    local line : subinstr local line "***" ""
                }
            }
                                    
            //TABLES FOR MARKDOWN
            //===================               
            if substr(`"`macval(line)'"',1,8) == "      < " {
                local line : subinstr local line "      < " "", all
            }
            
            if substr(`"`macval(line)'"',1,5) == "     " {
                file write `knot' `"    `macval(line)'"' _n
            }
            else file write `knot' `"`macval(line)'"' _n
            file read `hitch' line
        }
                
        file close `knot'
        file close `hitch'
        
        if !missing("`debug'") {
            copy "`tmp1'" 0process5.txt , replace
        }
        
        
        
        
        ********************************************************************
        * PART 3C- Finalizing LaTeX document
        *
        *   1) auto inserting \begin{verbatum} & \end{verbatum}
        *       - detect whether Verbatum is active
        *       - deactivate and reactivate it when necessary
        ********************************************************************
        if "`markup'" == "latex" & "`style'" != "empty" {
            tempfile tmp
            quietly  copy `"`tmp1'"' `"`tmp'"', replace
            tempfile tmp1
            tempname hitch knot 
            qui file open `hitch' using `"`tmp'"', read 
            qui cap file open `knot' using "`tmp1'", write replace
            *file write `knot'  _newline
            file read `hitch' line  
            
            while r(eof) == 0 {
                local verbatim 
                local preline
                
                if trim(`"`macval(line)'"') == "\begin{verbatim}" {
                    local v "on"
                    local verbatim "Found"                      
                }   
                if trim(`"`macval(line)'"') == "\end{verbatim}" local v "off"
                
                
                if "`verbatim'" == "Found" {
                    local preline `"`macval(line)'"'
                
                    cap file read `hitch' line
                    while trim(`"`macval(line)'"') == "" & r(eof) == 0 {                
                        file read `hitch' line
                    }
                    
                    //if the file was empty
                    if r(eof) != 0 local v "off"
                    
                    //jump \end{verbatim}
                    if trim(`"`macval(line)'"') == "\end{verbatim}" {
                        cap file read `hitch' line
                        local v "off"
                    }
                    
                    else {
                        if substr(`"`macval(line)'"',1,2) == "  "  &            ///
                        !missing(`"`macval(line)'"') {
                            
                            // keep the verbatim
                            file write `knot' `"`macval(preline)'"' _n
                        }
                    }
                }
                
                
                if "`v'" == "on" {                  
                    if substr(`"`macval(line)'"',1,2) != "  "  &                ///
                    !missing(`"`macval(line)'"') {
                        
                        if missing("`verbatim'") file write `knot'              ///
                        "      \end{verbatim}" _n(2)
                        
                        local v "off"
                    }
                }
                
                if "`v'" == "off" {
                    if substr(`"`macval(line)'"',1,2) == "  " &                 ///
                    trim(`"`macval(line)'"') != "" {
                        file write `knot' _n "      \begin{verbatim}" _n
                        local v "on"
                    }
                }
                
                

                
                
                file write `knot' `"`macval(line)'"' _n
                file read `hitch' line
            }
            
            if "`v'" == "on" {  
                file write `knot' _n "      \end{verbatim}" _n
            }
        
            macro drop v 
            
            file close `knot'
            file close `hitch'
            
            if !missing("`debug'") {
                copy "`tmp1'" 5B.txt    , replace
            }   
        }   
        
        

        
            
        ********************************************************************
        *PART 4- CREATE MARKDOWN FILE
        ********************************************************************    
        tempfile tmp //for further processing
        
        
        if missing("`export'") {
            if "`markup'" == "markdown" | "`markup'" == ""  {
                
                if !missing("`noisily'") {
                    di _n(2) "{title:Creating Temp file}" _n                    ///
                    `"{p}$pandoc `tmp1' -o `tmp'"'
                }
            
                `cap' shell "$pandoc" "`tmp1'" -o "`md'"
                quietly  copy `"`md'"' `"`tmp'"', replace
                *copy "`tmp1'" 0process6.md , replace
            }
        }
        
        if !missing("`export'") {
            qui copy `"`tmp1'"' `"`tmp'"', replace
            qui copy `"`tmp1'"' `"`md'"', replace
            *copy "`tmp1'" 0process6.md , replace
        }   
                    
        if "`markup'" ==  "html"   {
            if !missing("`noisily'") {
                di _n(2) "{title:Creating Temp file}" _n                        ///
                `"{p}$pandoc `tmp1' -o `tmp'"'
            }   
            
            `cap' shell "$pandoc" "`tmp1'" -o "`tmp'"
            quietly  copy `"`tmp'"' `"`convert'"', replace
            //copy "`tmp'" 0process6.html   , replace
        }       
        
        if "`markup'" == "latex" & "`export'" == "tex" {
            `cap' quietly copy "`tmp1'" "`convert'", replace
        }
        
        if "`markup'" == "latex" & "`export'" == "pdf" {
            `cap' quietly copy "`tmp1'" "`tex2pdf'", replace
        }
        
        if !missing("`debug'") {
            copy "`tmp1'" 0process6.md  , replace       //for debugging
            copy "`md'" "0md.md", replace
        }   
    
        
    
        ********************************************************************
        *   STYLING THE HTML FILE
        ********************************************************************            
        if !missing("`master'") & "`export'" == "html"  {
            tempfile tmp1
            
            // Add the document style
            // -------------------------------------------------------------
            markdocstyle , tmp("`tmp'") tmp1("`tmp1'") `master' `mathjax'   ///
            `statax' style(`style') template("`template'") `figure'             ///
            export("`export'") markup("`markup'") `debug' `noisily' `toc'       ///
            title("`title'") author("`author'") affiliation("`affiliation'")    ///
            address("`address'") summary("`summary'") `date'
        }
        
            
        ********************************************************************
        *   REPLACE THE HTML FILE
        ********************************************************************    
        if "`export'" == "html" & "`style'" != "" {
            
            if "`markup'" == "markdown" | "`markup'" == ""  {
                quietly  copy `"`tmp1'"' `"`md'"', replace
                
                *copy "`md'" 0processMD1.md, replace
                
                // If the export was "pdf", then copy the file to "`html'"
                if "`pdfhtml'" == "pdfhtml" {
                    
                    //??? mathjax.org SDN has stopped working and the current 
                    //installed pandoc (v.1) points the HTML files to the old 
                    //SDN. Therefore, the PDF documents fail unless the 
                    //correct path is specified. for this, when there is a PDF
                    //export, I remove the --mathjax from pandoc code, when 
                    // pandoc intends to export HTML
                    
                    // Linus needs special treatment here 
                    // ----------------------------------
                    if "`c(os)'" == "Unix" {
                        tempfile real
                        tempname knot
                        qui file open `knot' using "`real'", write
                        qui file close `knot'   
                        qui copy "`real'" "`real'.html", replace public
                        
                        if !missing("`noisily'") {
                            /*di _n(2) "{title:Creating Temp file}" _n          ///
                            `"{p}$pandoc -s --mathjax `md' -o `real'.html"' */
                            
                            di _n(2) "{title:Creating Temp file}" _n            ///
                            `"{p}$pandoc -s `md' -o `real'.html"'
                        }   
                    
                        //shell "$pandoc" -S --mathjax "`md'" -o "`real'.html"
                        shell "$pandoc" -S "`md'" -o "`real'.html"
                        quietly  copy "`real'.html" "`html'", replace public
                    }
                    else {
                        if !missing("`noisily'") {
                            /*di _n(2) "{title:Creating Temp file}" _n          ///
                            ///`"{p}$pandoc -s --mathjax `md' -o `convert'"'
                            `"{p}$pandoc -s --mathjax `md' -o `output'"' _n */
                            
                            di _n(2) "{title:Creating Temp file}" _n            ///
                            `"{p}$pandoc -s `md' -o `output'"' _n
                        }   
                
                        //shell "$pandoc" -s --mathjax "`md'" -o "`output'"
                        shell "$pandoc" -s "`md'" -o "`output'"
                        quietly  copy "`output'" "`html'", replace public
                    }
                    
                    if !missing("`debug'") {
                        quietly  copy "`output'" 0processMD1.md, replace
                        quietly  copy "`output'" 0processHTML1.html, replace
                    }   
                    
                    *shell "$pandoc" "`md'" -o "`convert'"
                    *quietly  copy "`convert'" `"`html'"', replace
                    //copy "`convert'" "0pdfhtml.html", replace
                }
            }
            
            else if "`markup'" ==  "html"   {
                quietly  copy `"`tmp1'"' `"`convert'"', replace
            
                // If the export was "pdf", then copy the file to "`html'"
                if !missing("`pdfhtml'") {
                    quietly  copy `"`tmp1'"' `"`html'"', replace
                }   
            }   
        }
    
        ********************************************************************
        *EXPORT MARKDOWN FILE TO OTHER FORMATS
        ********************************************************************
        if "`export'" != "" {
            
            // DEFINE LATEX ENGINE PATH
            // ------------------------
            if !missing("`printer'") {
                local latexEngine --latex-engine="`printer'"
                global setpath "`printer'"
            }
                    
            // PDF Processing
            // ==============
            // for PDF processing, we changed the content of "`export'" 
            // macro from "pdf" to "html" and now that the HTML process
            // is done, it is time to turn it back to HTML. 
            if "`pdfhtml'" == "pdfhtml" {
                
                if !missing("`toc'") {
                    local toc  toc  --page-offset 0 --toc-text-size-shrink 1.0  
                }
                
                local export "pdf"
                local convert "`pdf'" 
                            
                ****************************************************
                * Print the HTML file to pdf
                ****************************************************
                            
                // MICROSOFT WINDOWS PDF PRINTER DEFAULT PATHS 
                // ===========================================
                if "`c(os)'"=="Windows" {
    
                    // ---------------------------------------------------------
                    // wkhtmltopdf
                    // ===========
                    //
                    // Use temporary files to prevent problems with UNC 
                    // directories on Windows. For more information, See
                    // https://support.microsoft.com/en-us/kb/156276
                    
                    // UPDATE: The temporary files cause problem to wkhtmltopdf 
                    // because the path to the files (e.g. figures) will not 
                    // be known to the wkhtmltopdf temporary file. 
                    if "$printername" == "wkhtmltopdf" | "$printername" == "" {
                        
                        tempfile in
                        //tempfile out
                        // The in file needs to have .html suffix. Erase any existing temp file
                        cap erase "`in'.html"
                        cap copy "`html'" "`in'.html", replace 
                    
                        
                        local quietly quietly       //avoid printer log
                        
                        if !missing("`unc'") {
                            if !missing("`noisily'") {
                            di _n(2) "{title:Print the HTML to PDF}" _n         ///
                            "$setpath --footer-center [page] "                  ///
                            " --footer-font-size 10 --margin-right 15mm "       ///
                            "--margin-left 15mm --margin-top 35mm "             ///
                            "--no-stop-slow-scripts --javascript-delay 5000 "   ///
                            "--enable-javascript `toc' --debug-javascript "     ///
                            ///"`in'.html `output'"
                            "`in'.html `convert'"
                            
                            local quietly           //display printer log
                            }
                        
                            `quietly' shell "$setpath"                          ///
                            --footer-center [page] --footer-font-size 10        ///
                            --margin-right 15mm                                 ///
                            --margin-left 15mm                                  ///
                            --margin-top 35mm                                   ///
                            --no-stop-slow-scripts --javascript-delay 5000      ///
                            --enable-javascript                                 ///
                            `toc'                                               ///
                            --debug-javascript                                  ///
                            ///"`in'.html" "`output'"
                            "`in'.html" "`convert'"
                        } 
                        else {
                            `quietly' shell "$setpath"                          ///
                            --footer-center [page] --footer-font-size 10        ///
                            --margin-right 15mm                                 ///
                            --margin-left 15mm                                  ///
                            --margin-top 35mm                                   ///
                            --no-stop-slow-scripts --javascript-delay 5000      ///
                            --enable-javascript                                 ///
                            `toc'                                               ///
                            --debug-javascript                                  ///
                            "`html'" "`convert'"
                        }
                        
                        
                        cap erase "`in'.html"
                        ///cap copy "`output'" "`convert'", replace
                    }       
                }   
                            
                // MACINTOSH PDF PRINTER DEFAULT PATHS
                // ===================================
                if "`c(os)'" == "MacOSX" {

                    // wkhtmltopdf
                    if "$printername" == "wkhtmltopdf" | "$printername" == "" {
                        
                        local quietly quietly       //avoid printer log
                        
                        if !missing("`noisily'") {
                            di _n(2) "{title:Print the HTML to PDF}" _n         ///
                            "$setpath --footer-center \[page\] "                ///
                            " --footer-font-size 10 --margin-right 15mm "       ///
                            "--margin-left 15mm --margin-top 35mm "             ///
                            "--no-stop-slow-scripts --javascript-delay 5000 "   ///
                            "--enable-javascript `toc' --debug-javascript "     ///
                            `"`html' `convert'"' 
                            
                            local quietly           //display printer log
                        }
                        
                        `quietly' shell "$setpath"                              ///
                        --footer-center \[page\] --footer-font-size 10          ///
                        --margin-right 15mm                                     ///
                        --margin-left 15mm                                      ///
                        --margin-top 35mm                                       ///
                        --no-stop-slow-scripts --javascript-delay 5000          ///
                        --enable-javascript                                     ///
                        `toc'                                                   ///
                        --debug-javascript                                      ///
                        "`html'" "`convert'"
                    }               
                }
*               copy "`html'" sth.html, replace 
*               copy "`convert'" sth.pdf, replace   
                            
                // UNIX PDF PRINTER DEFAULT PATHS
                // ==============================
                if "`c(os)'"=="Unix" {
                            
                    // wkhtmltopdf
                    
                    // increase the delay time to load the JS. Otherwise errors happen
                    if "$printername" == "wkhtmltopdf" | "$printername" == "" {
                        
                        local quietly quietly       //avoid printer log
                        
                        if !missing("`noisily'") {
                            di _n(2) "{title:Print the HTML to PDF}" _n         ///
                            "$setpath --footer-center \[page\] "                ///
                            " --footer-font-size 10 --margin-right 15mm "       ///
                            "--margin-left 15mm --margin-top 35mm "             ///
                            "--no-stop-slow-scripts --javascript-delay 5000 "   ///
                            "--enable-javascript `toc' --debug-javascript "     ///
                            `"`html'" "`convert'"' 
                            
                            local quietly           //display printer log
                        }
                        
                        `quietly' shell "$setpath"                              ///
                        --footer-center \[page\] --footer-font-size 10          ///
                        --margin-right 15mm                                     ///
                        --margin-left 15mm                                      ///
                        --margin-top 35mm                                       ///
                        --no-stop-slow-scripts --javascript-delay 5000          ///
                        --enable-javascript                                     ///
                        `toc'                                                   ///
                        --debug-javascript                                      ///
                        "`html'" "`convert'"                    
                    }   
                }               
            }   
            
            ****************************************************
            * DEALING WITH THE CONVERT FILE
            ****************************************************
    
            //di _n(2)
            if "`markup'" == "markdown" & "`pdfhtml'" == "" |                   ///
            "`markup'" == "" & "`pdfhtml'" == "" {
                
                if !missing("`toc'") local toc "--toc"
                
                if !missing("`template'") {
                    if "`export'" == "docx" local reference -S --reference-docx=`template'
                    if "`export'" == "odt"  local reference -S --reference-odt==`template'
                    if "`export'" == "epub" local reference -S --epub-stylesheet==`template'
                }
                
                if missing("`template'") & "`export'" == "docx" {
                    qui findfile markdoc_`style'.docx   
                    
                    if !missing("`r(fn)'") {
                        local d : pwd
                        cap qui cd "`c(sysdir_plus)'/m"
                        local tempPath : pwd
                        local template "`tempPath'/markdoc_`style'.docx"    
                        confirm file "`template'"
                        cap qui cd "`d'"
                        if "`c(os)'" == "Windows" {
                            local template : subinstr local template "/" "\", all
                        }
                        local reference -S --reference-docx="`template'"
                    }       
                }
                
                // ======================================================
                // RUNNING PANDOC
                // ------------------------------------------------------
                if "`export'" == "slide" {
                    
                    // LaTeX Beamer Default
                    if missing("`template'") {
                        tempfile template
                        tempname knot 
                        qui cap file open `knot' using "`template'", write replace
                        
                        if !missing("`bwidth'") & !missing("`bheight'") {
                            file write `knot' "\geometry{paperwidth=`bwidth'mm,paperheight=`bheight'mm}" _n
                        }                       
                        if missing("`bcodesize'") {
                            local bcodesize tiny
                        }   
                        local bcodesize : di "\" "`bcodesize'"
                        file write `knot' "\makeatletter" _n
                        file write `knot' "\def\verbatim@font{\ttfamily`bcodesize'}" _n
                        file write `knot' "\makeatother" _n 
                        
                        file close `knot'
                    }

                    // Use temporary files to prevent problems with UNC directories on
                    // Windows
                    // (See: https://support.microsoft.com/en-us/kb/156276)
                    
                    // Beamer layout options
                    // ---------------------
                
                    if !missing("`btheme'") {
                        local beamerlayout : di "-V theme:`btheme'"
                    }   
                    if !missing("`bcolor'") {
                        local beamerlayout : di "`beamerlayout' -V colortheme:`bcolor'"
                    }   
                    if !missing("`bfont'")  {
                        local beamerlayout : di "`beamerlayout' -V fonttheme:`bfont'"
                    }   
                    *if !missing("`bfontsize'") local beamerlayout `beamerlayout' fontsize:`bfontsize'pt

                    
                    if "`noisily'" == "noisily" {
                        di _n(2) "{title:Executing Pandoc Command}" _n          ///
                        `""$pandoc" `toc' -t beamer "`md'" "'                   ///
                        `"`latexEngine' --include-in-header="`template'" `beamerlayout' -o "`output'""'
                    }
                    //It seems that Pandoc will need a ".pdf" extension to 
                    //produce PDF slides
                    
                    shell "$pandoc" `toc' -t beamer "`md'" `latexEngine'        ///
                    --include-in-header="`template'" `beamerlayout' -o "`output'" //"`out'.pdf"

                    quietly copy "`output'" "`convert'", replace
                    capture erase "`output'"
                    
                    *shell "$pandoc" -t beamer "`md'" -V theme:Boadilla -V      ///
                    *colortheme:lily `fontsize' -o "`convert'"  
                    
                    if !missing("`debug'") {                    
                        copy "`template'" 0template.txt, replace
                    }
                }               
                else {

                    local mathjax --mathjax
                    
                    if "`export'" == "dzslide" local mathjax -s --mathjax -i -t dzslides
                    if "`export'" == "slidy" local mathjax -s --mathjax -i -t slidy

                    if "`noisily'" == "noisily" {
                        di _n(2) "{title:Executing Pandoc Command}" _n
                        di `""$pandoc" `mathjax' `toc' "'               ///
                        `"`reference' "`md'" -o "`output'""'
                    }
                    
                    shell "$pandoc" `mathjax' `toc'         ///
                    `reference' "`md'" -o "`output'"            
            
                    quietly copy "`output'" "`convert'", replace
                    
                    if !missing("`debug'") {
                        copy "`md'" 0md2.md, replace
                        copy "`output'" 00output.txt, replace
                        copy "`convert'" 00convert.txt, replace
                    }
                }   
            }
            
                
            ****************************************************
            *CREATING THE TEXMASTER FILE
            ****************************************************
            //When exporting to LaTeX, the document is not ready 
            //  to be compiled by LaTeX compilers because it 
            //  only includes tex and markup and the required  
            //  packages and document details are not specified. 
            //  This option adds these formatting commands to 
            //  make the document runable. I already have 
            //  checked that texmaster should be used with "tex"
            
            
            if !missing("`master'")  & "`markup'" == "latex"                    ///
            & "`export'" != "slide"|                                            ///
            !missing("`master'")  & "`export'" == "tex"                         ///
            | missing("`master'") &                                             ///
            !missing("`template'") & "`markup'" == "latex"                      ///
            & "`export'" != "slide" {
                
                tempfile tmp
                tempfile tmp1
                if missing("`tex2pdf'") quietly copy "`convert'" `"`tmp'"', replace
                else quietly copy "`tex2pdf'" `"`tmp'"', replace
                qui cap erase "`convert'"
                
                //fix the toc
                if "`toc'" == "--toc" local toc2 toc
                
                // Add the document style
                // -------------------------------------------------------------
                markdocstyle , tmp("`tmp'") tmp1("`tmp1'") `master'         ///
                export("`export'") markup("`markup'") `debug' `noisily'         ///
                style(`style') template("`template'") `figure' `statax' `toc2'  ///
                title("`title'") author("`author'") affiliation("`affiliation'")    ///
                address("`address'") summary("`summary'") `date'
                                
                
                //REPLACE THE FILE
                if missing("`tex2pdf'") quietly copy `"`tmp1'"' "`convert'", replace
                else quietly copy `"`tmp1'"' "`tex2pdf'", replace   
                
                if !missing("`debug'") {
                    copy "`tmp1'" "0style3.txt", replace
                }   
            }
                
            ****************************************************
            *CREATING THE PDF FROM TEX
            ****************************************************                
            if !missing("`pdftex'") & "`export'" != "slide" {
                
                if !missing("`debug'") {
                    copy "`tex2pdf'"  0tex2pdf.tex, replace
                }
                
                
                // get the file name from the path
                if "`c(os)'" == "Windows" {
                    local name : subinstr local name "\" "/", all                
                }
                tokenize "`name'", parse("/")
                while !missing("`1'") {
                    if missing("`2'") local name = "`1'"    
                    macro shift
                } 
                
                if "`printer'" != "" {
                    if "`noisily'" == "noisily" {
                        di _n(2) "{title:Compiling LaTeX to PDF}" _n            ///
                        `""`printer'" -jobname "`name'" "`tex2pdf'""'
                    }   
                    `cap' shell "`printer'" -jobname "`name'" "`tex2pdf'" 
                }
                else {
                    if "`noisily'" == "noisily" {
                        di _n(2) "{title:Compiling LaTeX to PDF}" _n            ///
                        `""$printername" -jobname "`name'" "`tex2pdf'""'
                    }   
                    shell "$printername" -jobname "`name'" "`tex2pdf'"  
                }
            }
            
            
            ****************************************************
            *PRINTING THE OUTPUT NOTIFICATION
            ****************************************************
            if !missing("`pdftex'") & "`export'" != "slide" {
                cap confirm file "`name'.pdf"
                if _rc == 0 {
                    di as txt "(MarkDoc created "`"{bf:{browse "`name'.pdf"}})"' _n
                }
                else display as err "MarkDoc could not produce `name'.pdf" _n
            }
            
            else {
                cap confirm file "`convert'"
                if _rc == 0 {
                    di as txt "(MarkDoc created "`"{bf:{browse "`convert'"}})"' _n
                    if "`export'" != "md" cap qui erase "`md'"
                }
                else display as err "MarkDoc could not produce `convert'" _n
            }
        }
        
        if "`export'" == "" {

            cap confirm file "`md'"
            if ! _rc {
                di as txt "(MarkDoc created "`"{bf:{browse "`md'"}})"' _n
            }
        
            // IF THERE WAS NO PANDOC AND NO MARKDOWN FILE...
            else di as err "MarkDoc could not access Pandoc..." _n      
        }
            
        *change the md files to markdown
        if "`export'" == "md" local export markdown
        
        // INSTALLING LATEX STYLES
        // =======================
        
        // When exporting to LaTeX, if "stata" style is specified, MarkDoc 
        // copies Statapress files to the working directory to allow executing
        // the LaTeX files. 
        
        if "`export'" == "tex" & "`style'" == "stata" {
            
            // SEARCHING FOR LATEX STYLE DIFFERS BASED ON OS 
            
            if "`c(os)'" != "Windows" cap quietly findfile supplementary,       ///
            path("`c(sysdir_plus)'Weaver")
            
            if "`c(os)'" == "Windows" cap quietly findfile sj.sty,              ///
            path("`c(sysdir_plus)'Weaver\supplementary\stata")
                
            if "`r(fn)'" != "" {
                        
                // Create a list of files that should be copied     
                local listname doit.bat doit.sh pagedims.sty sj.bib             ///
                sj.bst sj.sty sj.version stata.sty statapress.cls               ///
                tl.eps tl.pdf tr.eps tr.pdf

                foreach lname in `listname' {
                    cap qui findfile `lname'
                    if "`r(fn)'" == "" {            
                        cap qui copy "`c(sysdir_plus)'Weaver/supplementary/stata/`lname'" ///
                        "`lname'", replace                  
                    }
                }
            }
        }
        
        //erase the temporary HTML when exporting pdf
        if "`pdfhtml'" == "pdfhtml" {
            cap quietly erase `"`html'"' 
        }   
        
        macro drop pandoc
        macro drop setpath                          //Path of the pdf printer
        macro drop printername
        macro drop printerpath
        
        //remove this!
        if !missing("`clinesize'") {
            qui set linesize `clinesize'
        }
    }
    
    if "`smclfile'" != "" & "`test'" == "" & "`export'" == "sthlp" |            ///
    "`smclfile'" != "" & "`test'" == "" & "`export'" == "smcl" {

        sthlp `smclfile', markup("`markup'") export("`export'")                 ///
        template("`template'") `replace' `date' title("`title'")                ///
        author("`author'") affiliation("`affiliation'") address("`address'")    ///
        summary("`summary'") `asciitable' version("`version'") `helplayout' `build'
    }   
    
    
    // Drop the global macros
    // -------------------------------------------------------------------------
    // this kills the live-preview. NOT A GOOD IDEA
    // if missing("$weaver") macro drop currentFigure
    macro drop CurrentMarkDocDofile                    
    
    // check for MarkDoc updates
    markdocversion
    
    
    ****************************************************************************
    *REOPEN THE LOG
    ****************************************************************************
    //quietly log query    
    //if !missing("`status'")  {
    //  qui log on  
    //}
        
end

// create the help file
// ====================
*markdoc markdoc.ado, exp(sthlp) replace build
