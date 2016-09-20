{smcl}
{right:version 3.7.9}
{title:Title}

{phang}
{cmd:markdoc} {hline 2} a general-purpose literate programming package for Stata that produces {it:dynamic analysis documents} and {it:package vignette documentation} in various formats 
 ({bf:pdf}, {bf:docx}, {bf:html}, {bf:odt}, {bf:epub}, {bf:markdown}), 
 pdf or html-based {it:dynamic presentation slides} ({bf:slide}, {bf:slidy}, 
 {bf:dzslide}), as well as dynamic 
 {it:Stata package help files} ({bf:sthlp}).    {break}
 
{p 8 8 2}
To improve applications of the package for developing educational materials 
and encouraging university lecturers to ask students to practice 
literate programming for taking notes or doing their semester projects, 
MarkDoc was programmed to include unique features. For example, it includes a syntax highlighter, 
it recognizes markdown, html, and latex markup languages, it can render latex mathematical 
notations in {bf:pdf}, {bf:docx}, {bf:html}, {bf:odt}, and {bf:tex} documents, 
automatically capture graphs from Stata and include them in the document, creates dynamic tables, and 
supports writing dynamic text for interpretting the analysis. Moreover, a user-friendly 
GUI interface was developed for the package (try {bf:{stata db markdoc}}) to make using {bf:MarkDoc} easier for newbies.
These features make the package a 
complete tool for documenting data analysis, Stata packages, as well as a tool for 
producing educational materials within Stata Do-file editor. 

{p 8 8 2}
The source code of the project 
{browse "https://github.com/haghish/MarkDoc":is hosted on GitHub} 
and also, the package documentation
{browse "https://github.com/haghish/MarkDoc/wiki":is hosted on GitHub wiki}. all 
contributions to the package, including improving the documentation or providing 
further examples are welcome. further resources are available in the webpages below. 

{p 8 8 2}
{browse "http://haghish.com/markdoc":Homepage}     {break}
{browse "http://haghish.com/resources/pdf/Haghish_MarkDoc.pdf":Journal Article}     {break}
{browse "https://github.com/haghish/MarkDoc/wiki":MarkDoc Documentation Manual}    {break}
{browse "https://github.com/haghish/MarkDoc/releases":Release Notes}    {break}
{browse "https://github.com/haghish/MarkDoc/tree/master/Examples":Examples}    {break}
{browse "http://www.statalist.org/forums/forum/general-stata-discussion/general":Please ask your questions on statalist.org} 


{title:Syntax}

{p 4 4 2}
produce dynamic {it:documents}, {it:presentation slides}, or {it:help files} interactively

{p 8 13 2}
{cmdab:markdoc} {help filename} [{cmd:,} 
{opt pan:doc(str)} {opt print:er(str)} {opt instal:l} {opt t:est} {opt replace} 
{opt e:xport(name)} {opt mark:up(name)} {opt num:bered} {opt sty:le(name)} 
{opt template(str)} {opt toc}
{opt linesize(int)} {opt tit:le(str)} {opt au:thor(str)} {opt aff:iliation(str)} {opt add:ress(str)} 
{opt sum:mary(str)} {opt d:ate} {opt tex:master} {opt statax} {opt noi:sily}
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


{p 4 4 2}
{bf:MarkDoc} package also includes a few more commands that can be used to 
facilitate writing the dynamic document or dynamic slides. These commands are 
briefly described below, while the 
{browse "https://github.com/haghish/MarkDoc/wiki":complete documentation is available on GitHub wiki}:

{p 4 4 2}
write dynamic text using any of the supported markup languages. You can also 
use this command to write text within a loop or a program. 

{p 8 13 2}
{bf:{browse "https://github.com/haghish/MarkDoc/wiki/txt":txt}} [{help txt:{ul:{bf:c}}{bf:ode}}] [{it:display_directive} [{it:display_directive} [{it:...}]]]


{p 4 4 2}
include an image in the document. if {it:filename} is missing, {bf:img} command
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


{p 4 4 2}
execute {bf:pandoc} commands directly from Stata

{p 8 13 2}
{bf:{browse "https://github.com/haghish/MarkDoc/wiki/pandoc":pandoc}} {it:command} ]


{p 4 4 2}
convert html files to pdf using {bf:wkhtmltopdf} software

{p 8 13 2}
{bf:{browse "https://github.com/haghish/MarkDoc/wiki/wkhtmltopdf":wkhtmltopdf}} {it:command} ]


{synoptset 20 tabbed}{...}
{synopthdr:MarkDoc options}
{synoptline}
{syntab:}
{synopt:{opt pan:doc(str)}}specify the path to Pandoc software on the operating system{p_end}

{synopt:{opt print:er(str)}}specify the path to PDF driver on the operating system{p_end}

{synopt:{opt instal:l}}Installs the required packages and software automatically on the user{c 39}s machine, if they are not accessible {p_end}

{synopt:{opt t:est}}examines if MarkDoc is working properly by creating a test document{p_end}

{synopt:{opt replace}}replace the exported file if already exists{p_end}

{synopt:{opt e:xport(name)}}exports the {it:smclfile} to any of the supported document formats
which are {bf:pdf}, {bf:slide} (i.e. pdf slides), {bf:docx}, {bf:odt}, {bf:tex}, {bf:html}, {bf:epub}, and {bf:md}{p_end}

{synopt:{opt mark:up(name)}}specify the markup language used for writing the document and the default is Markdown{p_end}

{synopt:{opt num:bered}}numbers Stata commands in the dynamic document.{p_end}

{synopt:{opt linesize(int)}}change the {help linesize} for the {help log}, which can range from 80 to 255. {bf:MarkDoc} also evaluates the linesize of the document and applies the actual linesize automatically, if the linesize is not specified.{p_end}

{synopt:{opt sty:le(name)}}specify the style of the document for HTML, PDF, Docx, and LaTeX documents. 
The available styles are {bf:simple} and {bf:stata}. If the document is exported 
in LaTeX format, the {bf:stata} option (also if used with {cmd: texmaster} option) 
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

{synopt:{opt add:ress(str)}}specify the author{c 39}s contact information in the document{p_end}

{synopt:{opt sum:mary(str)}}specify the summary of the document{p_end}

{synopt:{opt d:ate}}specify the current date in the document{p_end}

{synopt:{opt tex:master}}while creating a LaTeX document, MarkDoc only translates the 
content of the smcl file to tex and since the document does not include the formatting and 
required LaTeX packages, it cannot be compiled (although it can be imported in a document). 
This option create a "main" file in LaTeX to allow compiling the document.{p_end}

{synopt:{opt statax}}highlights the syntax of Stata codes in the HTML and PDF 
documents using {help Statax}, which is a JavaScript syntax highlighter engine for Stata{p_end}

{synopt:{opt noi:sily}}enables extended log for debugging markdoc{p_end} 

{synoptline}
{p2colreset}{...}
{* *! {synopt:{opt ascii:table}}converts ascii and figures tables to smcl. This feature can be used for adding ascii models of a program or tables in Stata help file.}


{title:Installation}

{p 4 4 2}
{bf:markdoc} is hosted both on 
{browse "https://github.com/haghish/MarkDoc":GitHub} 
and SSC. MarkDoc receives weekly updates on GitHub but only occasion updates on SSC. 
Therefore, users are recommended to install the package from GitHub:

        . net install markdoc, force  from([https://raw.githubusercontent.com/haghish/markdoc/master/)

{p 4 4 2}
To install the package from SSC server type:

        . ssc install markdoc

{p 4 4 2}
After installing MarkDoc, install {help Weaver} and {help Statax} packages. If the {cmd:install}
option is specified, MarkDoc checkes for the required packages and installs 
them automatically, if they{c 39}re not already installed. 

        . ssc install weaver
        . ssc install statax


{title:Description}

{p 4 4 2}
{bf:markdoc} is a general-purpose literate programming package for Stata that 
produces {it:dynamic analysis documents}, {it:package vignette documentation}, 
{it:dynamic presentation slides}, as well as dynamic 
{it:Stata package help files}. 

{p 4 4 2}
For creating a dynamic document or presentation slides, MarkDoc requires a smcl 
log-file as input and converts it to other formats. For generating dynamic Stata 
help files or package vignette documentation, MarkDoc requires a Stata script-file 
(do, ado, mata) as input and exports the documentations written within the source. 
Visit MarkDoc homepage for documentation about generating 
{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/markdoc.php#sthlp":{bf:dynamic Stata help files and documentations}}. 

{p 4 4 2}
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
in the document, respectively. MarkDoc also    {break}
{help statax:requires the Statax package} which provides 
{browse "http://www.haghish.com/statax/statax.php":a JavaScript syntax highlighter for Stata and Mata code}
 in HTML and PDF documents.

{p 4 4 2}
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

{p 4 4 2}
MarkDoc supports both Stata and {help Mata:Mata} languages. Therefore, advanced users who work or 
program in Mata, can use Markdoc - with the same syntax and markup notation - 
to produce a dynamic document or slides, or document their programs. The same source 
that is used for generating dynamic Stata {bf:sthlp} help files, can be used to 
produce Microsoft Word {bf:docx}, {bf:pdf}, etc.

{p 4 4 2}
For a more detailed documentation and examples, visit 
{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/markdoc.php":{bf:MarkDoc Homepage}}. 


{title:Writing mathematical notation}

{p 4 4 2}
{bf:markdoc} can render LaTeX mathematical notations not only when the document 
is exported to LaTeX {bf:tex}, but also when the document is exported to 
{bf:pdf} document or {bf:slide}, Microsoft Office {bf:docx}, 
OpenOffice and LibreOffice {bf:odt}, and {bf:html}. 

{p 4 4 2}
Mathematical notations can be inline a text paragraph or on a separate line. 
For writing inline notations, place the notation between single dollar signs 
(e.g. ^2 + b^2 = c^2$). For including notation on a separate line, place the 
notations between double dollar signs (e.g. $^2 + b^2 = c^2$$). The example 
below demonstrates how to export a PDF presentation slides with notations:

    . qui log using example, replace
	
        /***

{title:        Writing mathematical notations}

        Mathematical notations can be inline a text paragraph e.g. $a^2 + b^2 = c^2$
        or on a separate line such as:
	
        $$a^2 + b^2 = c^2$$
	
    . qui log c
    . markdoc example, export(slide) printer("/usr/texbin/pdflatex") 
	

{title:Inserting an image or figure in the document}

{p 4 4 2}
Any of the supported markup languages can be used to insert a figure in the 
document. In general, there are two ways for inserting an image in the document. 
First, you can use Markdown, HTML, or LaTeX syntax for inserting an image {hline 2} 
that is already saved in your hard drive {hline 2} in the document. The other solution is using {help img} command. 
{bf:img} command can take the {help filename} of exsisting image on the hard 
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
    {bf:    {hline 12}} 

    {bf:    subheading}
    {bf:    {hline 10}} 

    {bf:    When you write a dynamic document in MarkDoc, place text between}
    {bf:    the "/***" and "***/" signs. But they should be placed on separate lines,}
    {bf:    as shown in this example.}
		
    {bf:    ***/}

{pstd}    {break}
	
	
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
and LaTeX), writing with HTML or LaTeX requires exporting the document in {bf:PDF} or {bf:html} and    {break}
{bf:tex} format respectively. Markup languages hould not be used together in one document because 
MarkDoc process each markup language differently.


{title:Markdown syntax}

{pstd}
Writing with Markdown can make your script files appealing. It is a fairly minimalistic 
language which makes your text distinguishable from the computer code, in contrast 
to HTML and LaTeX, which add to the complexity of the code. 
To learn about using Markdown syntax for styling text and importing graphs, see 
{browse "http://haghish.com/statistics/stata-blog/reproducible-research/dynamic_documents/markdown.php":Writing with Markdown in Stata}.


{title:Linesize}

{pstd}
Users can alter the linesize of the dynamic document using the {opt linesize(int)}
option. The value of the linesize can range from 80 to 255. 
If you wish to export your smcl logfile to {bf:Microsoft Word docx} format, note that 
Microsoft Word documents have a large left and right margin and you should reduce the 
margins of the Word document manually or alternatively reduce the font size. 


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
paths to the Weaver directory are shown below. Note that username refers to your machine{c 39}s username.

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
work properly in Microsoft Windows {bf:XP}, Windows {bf:7}, and Windows {bf:8.1}, Macintosh    {break}
{bf:OSX 10.9.5}, Linux {bf:Mint 17 Cinnamon} (32bit & 64bit), Ubuntu {bf:14} (64bit), and 
{bf:CentOS 7} (64bit). Other operating systems may require manual software installation. 

{pstd}
However, if for some technical or permission reasons MarkDoc fails to download, access, or run 
Pandoc, install it manually and provide the 
file path to Pandoc using {opt pan:doc(str)} option. visit 
{browse "http://www.haghish.com/packages/pandoc.php":Installing Pandoc for Stata packages}    {break}
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
    {bf:         {hline 35}} 

    {bf:         Using Markdown (heading 2)}
    {bf:         {hline 26}} 

    {bf:         Writing with __markdown__ syntax allows you to add text and graphs to}
    {bf:         _smcl_ logfile and export it to a editable document format. I will demonstrate}
    {bf:         the process by using the __Auto.dta__ dataset.}

    {bf:         ###Get started with MarkDoc (heading 3)}
    {bf:         I will open the dataset, list a few observations, and export a graph.}
    {bf:         Then I will export the logfile to Microsoft Office docx format.}
    {bf:         ***/}

    {bf:  /***/ sysuse auto, clear} 
    {bf:  /**/  list in 1/5	}	   
    {bf:  histogram price}
    {bf:  graph export graph.png,  width(400) replace}

    {bf:         /***} 
    {bf:         Adding a graph or image in the report} 
    {bf:         {hline 38}} 

    {bf:         Adding a graph using Markdown}
    {bf:         {hline 29}}

    {bf:         In order to add a graph using Markdown, I export the graph in PNG format.}
    {bf:         You can explain the graph in the "brackets" and define the file path in parentheses}
    {bf:         }
    {bf:         ![explain the graph](./graph.png)}
    {bf:         ***/}

{phang}{c 29}{cmd: qui log c}

    {bf:  markdoc example, replace export(html) install}			
    {bf:  markdoc example, replace export(docx)}
    {bf:  markdoc example, replace export(tex) texmaster}
    {bf:  markdoc example, replace export(pdf)}
    {bf:  markdoc example, replace export(epub)}


{title:Dynamic Slide Examples}

{phang}{cmd:{c 29}  qui log using example, replace}

    {bf:         /***} 
	{bf:     {hline 3}} 
	{bf:     title:MarkDoc Dynamic Slides} 
	{bf:     author: E. F. Haghish} 
	{bf:     {hline 3}}
	
    {bf:         Slide 1} 
    {bf:         {hline 7}} 

    {bf:         - Writing with __markdown__ syntax allows you to add text and graphs }
    {bf:         to _smcl_ logfile and export it to a editable document format. I will demonstrate}
    {bf:         the process by using the __Auto.dta__ dataset.}

    {bf:         - I will open the dataset, list a few observations, and export a graph.}
    {bf:         Then I will export the logfile to Microsoft Office docx format.}
	
    {bf:         Adding commands and output} 
    {bf:         {hline 26}}
    {bf:         ***/}
	
	

	
{p 4 4 2}
	{bf:{c 29} sysuse auto, clear}	     {break}
	{bf:{c 29} histogram price}
	{bf:{c 29} graph export graph.png,  width(400) replace}
	
    {bf:         /***} 
    {bf:         Adding image in a slide} 
    {bf:         {hline 23}} 

    {bf:         ![Histogram of the price variable](./graph.png)}
    {bf:         ***/}
	
{p 4 4 2}
	{bf:  qui log c}
	{bf:  markdoc example, replace export(slide) install printer("/usr/texbin/pdflatex") }


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
Package Updates on  {browse "http://www.twitter.com/Haghish":Twitter}    {break}


{title:Also see}

{psee}
{space 0}{bf:{help Weaver}}: HTML & PDF Dynamic Report producer

{psee}
{space 0}{bf:{help Statax}}: JavaScript syntax highlighter for Stata     {break}

    {hline}

{p 4 4 2}
This help file was dynamically produced by {help markdoc:MarkDoc Literate Programming package}

