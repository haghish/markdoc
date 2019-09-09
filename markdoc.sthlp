{smcl}
{it:version 5.0.0}


{title:markdoc}

{p 4 4 2}
{bf:markdoc} is a general-purpose literate programming package for Stata that
produces {it:dynamic analysis documents}, {it:presentation slides}, as well as Stata
package help files and package vignettes in various formats such as {bf:pdf}, 
{bf:docx}, {bf:html}, and {bf:sthlp}. 

{p 4 4 2}
for further information see:

{break}    -  {browse "http://haghish.com/markdoc":markdoc homepage}
{break}    -  {browse "https://journals.sagepub.com/doi/abs/10.1177/1536867X1601600409":journal article}
{break}    -  {browse "https://github.com/haghish/markdoc/wiki":manual on Github wiki}
{break}    -  {browse "https://github.com/haghish/markdoc/blob/master/vignette.pdf":package vignette (pdf)}
{break}    -  {browse "https://github.com/haghish/markdoc/releases":release notes on Github}
{break}    -  {browse "https://github.com/haghish/markdoc/tree/master/Examples":examples on GitHub}
{break}    -  {browse "http://www.statalist.org/forums/forum/general-stata-discussion/general":please ask your questions on statalist.org}

{p 8 8 2} from version {it:5.0} forth, {bf:markdoc} is 
{err}fully functional without any third-party software{txt}, due to its new 
light-weight  {browse "https://github.com/haghish/markdoc/wiki/mini":mini engine}. Yet, 
a full installation of {bf:markdoc} and its dependencies is recommended.


{title:Syntax}

{p 4 4 2}
the syntax of the package is simple and can be summarized as:

{p 8 8 2} {bf:markdoc} {it:filename} [, {it:options} ]

{p 4 4 2}
where {it:filename} can be:

{col 5}Document format{col 22}Description
{space 4}{hline}
{col 5}{bf:.do}{col 22}executes {it:do} file, examines the analysis reproducibility, and produces a dynamic document
{col 5}{bf:.smcl}{col 22}converts {it:smcl} file to a dynamic document without testing the code reproducibility
{col 5}{bf:.ado} or {bf:.mata}{col 22}generates {it:sthlp} help files or package vignettes from Markdown documentation
{space 4}{hline}

{p 4 4 2}{bf:Options}

{p 4 4 2}
the main options are the following:

{col 5}Option{col 24}Description
{space 4}{hline}
{col 5}mini{col 24}runs markdoc independent of any third-party software
{col 5}statax{col 24}activates  {browse "https://github.com/haghish/statax":statax} syntax highlighter
{col 5}replace{col 24}replaces exported document, if exists
{col 5}{ul:e}xport({it:name}){col 24}format; it can be {bf:docx}, {bf:pdf}, {bf:html}, {bf:sthlp}, {bf:slide}, {bf:md}, or {bf:tex}
{space 4}{hline}

{p 4 4 2}
the supplementary options are the following:

{col 5}Option{col 24}Description
{space 4}{hline}
{col 5}{ul:num}bered{col 24}numbers Stata commands in the dynamic document
{col 5}date{col 24}adds the current date in the document
{col 5}{ul:tit}le({it:str}){col 24}specify the title of the document
{col 5}{ul:au}thor({it:str}){col 24}specify the author of the document
{col 5}{ul:aff}iliation({it:str}){col 24}specify the author affiliation in the document
{col 5}{ul:add}ress({it:str}){col 24}specify the author{c 39}s contact information in the document
{col 5}{ul:sum}mary({it:str}){col 24}specify the summary of the document
{col 5}{ul:sty}le({it:name}){col 24}specify the style of the document; it can be {bf:simple}, {bf:stata}, or {bf:formal}
{space 4}{hline}

{p 4 4 2}
options related to software documentation:

{col 5}Option{col 24}Description
{space 4}{hline}
{col 5}helplayout{col 24}appends a Markdown help layout template to a script file
{space 4}{hline}

{p 4 4 2}
and the following options are for communicating with the third-party software (not required in the {bf:mini} mode)

{col 5}Option{col 24}Description
{space 4}{hline}
{col 5}{ul:instal}l{col 24}installs the pandoc and wkhtmltopdf automatically, if they are not found
{col 5}unc{col 24}specify that markdoc is being accessed from a Windows server with UNC file paths
{col 5}{ul:pan}doc({it:str}){col 24}specify the path to Pandoc software on the operating system
{col 5}{ul:print}er({it:str}){col 24}specify the path to pdf driver on the operating system
{col 5}{ul:mark}up({it:name}){col 24}specify the markup language used for notation; the default is Markdown
{col 5}master{col 24}automatically creates the layout for LaTeX and HTML documents
{col 5}template({it:str}){col 24}renders the document using an external style sheet file or example docx file
{col 5}{ul:t}est{col 24}examines markdoc third-party software with an example
{col 5}toc{col 24}creates table of content
{space 4}{hline}


{title:Additional commands}

{p 4 4 2}
{bf:markdoc} includes a few commands that freatly simplify writing the workflow. you
may use the additioval commands to:

{break}    1. write dynamic text, while applying any display directive supported by the {help display} command:

{p 8 8 2}  {browse "https://github.com/haghish/markdoc/wiki/txt":{bf:txt}} [{it:code}] [{it:display_directive} [{it:display_directive} [{it:...}]]]


{break}    2. capture and include the current image in the document automatically (if {it:filename} is missing)

{p 8 8 2}  {browse "https://github.com/haghish/markdoc/wiki/img":{bf:img}} [{it:filename}]
[, markup({it:str}) {ul:tit}le({it:str}) {ul:w}idth({it:int}) {ul:h}eight({it:int})
{ul:m}arkup({it:str}) left center ]


{break}    3. create and style a dynamic table in Markdown documents

{p 8 8 2}  {browse "https://github.com/haghish/markdoc/wiki/tbl":{bf:tbl}} {it:(#[,#...] [\ #[,#...] [\ [...]]])} [, {ul:tit}le({it:str})]


{p 4 4 2}
furthermore, you can also call {bf:pandoc} or {bf:wkhtmltopdf} within Stata i.e. :

{p 8 8 2}  {browse "https://github.com/haghish/markdoc/wiki/pandoc":{bf:pandoc}} {it:command}

{p 8 8 2}  {browse "https://github.com/haghish/markdoc/wiki/wkhtmltopdf":{bf:wkhtmltopdf}} {it:command}


{title:Installation}

{p 4 4 2}
The latest release as well as archived older versions of {bf:markdoc} are hosted on 
{browse "https://github.com/haghish/markdoc":GitHub} website. the recommended method 
for installing the package is through  {browse "https://github.com/haghish/github":{bf:github} package}
package, which is used for building, searching, installing, and managing Stata 
packages hosted on GitHub. you can install {bf:github} by typing:

        . net install github, from("https://haghish.github.io/github/")

{p 4 4 2}
next, install the latest stable {bf:markdoc} release along with its Stata 
dependencies by typing:

        . github install haghish/markdoc, stable


{title:Description}

{p 4 4 2}
{bf:markdoc} is a general-purpose literate programming package for Stata that 
produces {it:dynamic analysis documents}, {it:package vignette documentation}, 
{it:dynamic presentation slides}, as well as dynamic {it:Stata package help files}. 
to improve applications of the package for developing educational materials 
and encouraging university lecturers to ask students to practice 
literate programming for taking notes or doing their semester projects, 
{bf:markdoc} was programmed to include unique features. These features make the package a 
complete tool for documenting data analysis, Stata packages, as well as a tool for 
producing educational materials within Stata Do-file editor. For example: 

{break}    - it includes a syntax highlighter
{break}    - it recognizes markdown, html, and latex markup languages
{break}    - it can render LaTeX mathematical notations in {bf:pdf}, {bf:docx}, {bf:html}, {bf:odt}, and {bf:tex} documents 
{break}    - it can automatically capture graphs from Stata and include them in the document
{break}    - it creates dynamic tables and supports writing dynamic text for interpretting the analysis
{break}    - it includes a user-friendly GUI interface (try {bf:db markdoc_}) to make using {bf:markdoc} easier for newbies.


{title:Software Installation}

{p 4 4 2}
Without applying the {bf:mini} option, which uses the light-weight engine, 
the markdoc package requires additional software which can be installed manually or 
automatically. The required software are  {browse "http://pandoc.org/":Pandoc} and
{browse "http://wkhtmltopdf.org":wkhtmltopdf}. They are both 
opensource freeware, supported for any common operating system such as Microsoft Windows, 
Macintosh, and Linux. Naturally, users who wish to use LaTeX markup for writing 
the documentation, will need a  {browse "https://latex-project.org":pdfLaTeX}. 

{p 4 4 2}
After a manual installation, the path to executable Pandoc should be specified in 
{bf:pandoc} option. similarly, the path to executable wkhtmltopdf or pdfLaTeX 
should be given to {bf:printer} option. Note that the {bf:printer} option 
is only needed for compiling PDF document. 

{p 4 4 2}
With automatic installation (i.e. using the {bf:install} option), Pandoc and 
Wkhtmltopdf are downloaded and placed
in Weaver directory which is located in {bf:/ado/plus/Weaver/} on your machine. To find the 
location of {bf:ado/plus/} directory on your machine use the 
{browse "help sysdir":sysdir} command which returns the system directories. 


{title:Set file paths permanently}

{p 4 4 2}
After manual installation, the paths to the executable Pandoc, wkhtmltopdf, 
and pdfLaTeX can be permanently set using {bf:weave setup} command. This command 
will open {it:weaversetup.ado} document, where you can define the files paths as global macros.


{title:Software troubleshoot}

{p 4 4 2}
As mentioned, the required software can be installed manually or automatically. 
The optional automatic installation is expected to 
work properly in Microsoft Windows {bf:XP}, Windows {bf:7}, and Windows {bf:8.1}, Macintosh    {break}
{bf:OSX 10.9.5}, Linux {bf:Mint 17 Cinnamon} (32bit & 64bit), Ubuntu {bf:14} (64bit), and 
{bf:CentOS 7} (64bit). Other operating systems may require manual software installation. 

{p 4 4 2}
However, if for some technical or permission reasons markdoc fails to download, access, or run 
Pandoc, install it manually and provide the 
file path to Pandoc using {bf:PANDOC} option. 


{title:Calling Pandoc}

{p 4 4 2}
{browse "HELP PANDOC":{bf:PANDOC}} commands can also be executed from Stata. This command takes the path to 
the executable Pandoc from markdoc and allows you to use Pandoc seamlessly for converting 
files within Stata. FOR EXAMPLE:

        . pandoc ./example.tex -o ./example.html


{title:Writing mathematical notation}

{p 4 4 2}
{bf:markdoc} can render LaTeX mathematical notations not only when the document 
is exported to LaTeX {bf:tex}, but also when the document is exported to 
{bf:pdf} document or {bf:slide}, Microsoft Office {bf:docx}, 
OpenOffice and LibreOffice {bf:odt}, and {bf:html}. 

{p 4 4 2}
mathematical notations can be inline a text paragraph or on a separate line. 
For writing inline notations, place the notation between single dollar signs, 
for example: ^2 + b^2 = c^2$ 
For including notation on a separate line, place the 
notations between double dollar signs: $^2 + b^2 = c^2$$ 


{title:Inserting an image or figure in the document}

{p 4 4 2}
Any of the supported markup languages can be used to insert a figure in the 
document. In general, there are two ways for inserting an image in the document. 
First, you can use Markdown, HTML, or LaTeX syntax for inserting an image - 
that is already saved in your hard drive - in the document. The other solution 
is using  {browse "https://github.com/haghish/markdoc/wiki/img":{bf:img}} command. 
{bf:img} command can take the {it:filename} of exsisting image on the hard 
drive and print the markup code (Markdown, HTML, or LaTeX. the default is 
Markdown) int he document. {bf:img} command can also auto-export the current 
graph and import it in the document. For more information in this regard see 
the  {browse "https://github.com/haghish/markdoc/wiki/img":{bf:img}}. 


{title:Writing dynamic text}

{p 4 4 2}
the  {browse "help txt":{bf:txt}} command is borrowed from {help weaver} package to print 
dynamic text in the the exported dynamic document. 
It can be used for interpreting the analysis results or dynamically referring to values of 
scalars or macros in the dynamic document. Writing dynamic text allows the content of 
the text to change by altering analysis codes and thus is the desirable way 
for explaining the analysis results. The text and 
macros can be styled using any of the supported markup languages in markdoc which are 
{it:markdown}, {it:LaTeX}, and {it:HTML}. This command is fully documented on 
{browse "https://github.com/haghish/markdoc/wiki/txt":GitHub Wiki}. 


{title:Creating dynamic tables with tbl command}

{p 4 4 2}
the  {browse "help tbl":{bf:tbl}} command also belongs 
to  {browse "https://github.com/haghish/weaver":weaver} package. The syntax of this command
is similar to {bf:matrix input}, however, it can include {it:string}, {it:digits}, 
{it:scalars}, and {it:macros} to create a dynamic table. This command is fully documented 
on  {browse "https://github.com/haghish/markdoc/wiki/tbl":{bf:GitHub Wiki}}.


{title:Markers}

{p 4 4 2}
{bf:markdoc} also introduces a few handy markers for annotating the 
document, regardless of the markup language you use to write the document 
(Markdown, Tex, HTML). These markers can be used to specify what 
parts of the code should or should not appear in the dynamic document. The 
table below provides a brief summary of these annotating markers. in general, 
comments - unless they appear after a command - will be ignored in the dynamic 
document. However, the markers mentioned below are {it:"special comments"} that will 
influence the markdoc process. 

{break}    1. Creating text block

{asis}
     . /***
       creates a block of comments in the smcl file that will be interpreted 
       in the dynamic document. this sign is distinguished from the normal comment 
       signs, with one star.
     . ***/
{smcl}

{break}    2. Hiding command or output

{asis}
     . /**/ only include the output in the dynamic document and hide the comment
     . /**/ only include the command in the dynamic document and hide the output
{smcl}

{break}    3. Hiding a section. Anything placed after {bf://OFF} until {bf://ON} markers will be {it:ignored} in the dynamic document

{asis}
     . //OFF
       Stata code
     . //ON
{smcl}

{break}    4. Appending external text file (Markdown, HTML, LaTeX) to the dynamic document

{asis}
     . //IMPORT filename
{smcl}

{p 4 4 2}
Apart from the text block markers, the other markers {it:are not supported within loops}.    {break}
Nonetheless, writing markup text within the loop is not recommended either because 
it only gets printed once. For active writing within the loop or a program, see the 
{help txt} command. 


{title:Markers examples}

{p 4 4 2}{bf:Example of riting text in the do-file}

{p 4 4 2}
As noted, {bf:markdoc} package allows writing and styling text as a comment in 
the do-file, using special comment signs. here is an example:

{asis}
     . /***
       Text heading
       ============
     
       subheading
       ---------- 
     
       When you write a dynamic document in markdoc, place text between
       the "/***" and "***/" signs. But they should be placed on separate lines,
       as shown in this example.
     . ***/
{smcl}


{title:Dynamic Document Examples}

{asis}
     qui log using example, replace
     
     . /*** 
     Introduction to markdoc (heading 1)
     ===================================
     
     Using Markdown (heading 2)
     --------------------------
     
     Writing with __markdown__ syntax allows you to add text and graphs to
     _smcl_ logfile and export it to a editable document format. I will demonstrate
     the process by using the __Auto.dta__ dataset.
     
     ### Get started with markdoc (heading 3)
     I will open the dataset, list a few observations, and export a graph.
     Then I will export the logfile to Microsoft Office docx format.
     . ***/
     
     . /***/ sysuse auto, clear
     . /**/  list in 1/5 
     . histogram price
     . graph export graph.png,  width(400) replace
     
     . /***
     Adding a graph or image in the report
     ======================================
     
     Adding a graph using Markdown
     -----------------------------
         
     In order to add a graph using Markdown, I export the graph in PNG format.
     You can explain the graph in the "brackets" and define the file path in parentheses
     
     ![explain the graph](./graph.png)
     . ***/
{smcl}

{p 4 4 2}
When the log file is created, we can translate it with {bf:markdoc}

{asis}
     . markdoc example, replace export(html) install
     . markdoc example, replace export(docx)
     . markdoc example, replace export(tex) master
     . markdoc example, replace export(pdf)
     . markdoc example, replace export(epub)
{smcl}


{title:Dynamic Slide Examples}

{p 4 4 2}
this is an example of generating dynamic slides with {bf:markdoc}

{asis}
     . qui log using example, replace
     
     . /***
     ---
     title:markdoc Dynamic Slides
     author: E. F. Haghish
     ---
         
     Slide 1 
     =======
         
     - Writing with __markdown__ syntax allows you to add text and graphs 
     to _smcl_ logfile and export it to a editable document format. I will demonstrate
     the process by using the __Auto.dta__ dataset.
     
     - I will open the dataset, list a few observations, and export a graph.
     Then I will export the logfile to Microsoft Office docx format.
         
     Adding commands and output
     ==========================
     . ***/
     
     
     
     . sysuse auto, clear
     . histogram price
     . graph export graph.png,  width(400) replace
     
     . /***
     Adding image in a slide
     =======================
     
     ![Histogram of the price variable](./graph.png)
     . ***/
     
     . qui log c
     . markdoc example, replace export(slide) install printer("/usr/texbin/pdflatex")
{smcl}


{title:Supported markup languages}

{p 4 4 2}
markdoc supports three markup languages which are Markdown, HTML, and LaTeX. 
Markup languages should not be used together in one document because 
{bf:markdoc} process each markup language differently.



{title:Remarks}

{p 4 4 2}
If the log-file is closed exactly using {bf:"qui log c"} command, {bf:markdoc} 
automatically removes this command from the end of the file. 
Similarly, markdoc removes {bf:"qui log off"} from the logfile. Therefore {bf:"qui log off"} 
and {bf:"qui log on"} can be used to separate codes in the dofile that are not wanted in the 
dynamic document, but still required in for the analysis. Nonetheless, this is not a 
proper practice and can harm the transparency of the analytic session. The log-file 
should include as much information about the history of the analysis as possible. 
Use the "Markers" for hiding sections of the log-file in the dynamic document. 


{title:Author}

{p 4 4 2}
E. F. Haghish     {break}
University of Göttingen     {break}
{it:haghish@med.uni-goesttingen.de}    {break}
{browse "https://github.com/haghish":https://github.com/haghish}


{title:See also}

{break}    -  {browse "https://github.com/haghish/statax":Statax}, JavaScript & LaTeX syntax highlighter for Stata


{title:License}

{p 4 4 2}
MIT License

{space 4}{hline}

{p 4 4 2}
This help file was dynamically produced by 
{browse "http://www.haghish.com/markdoc/":MarkDoc Literate Programming package} 


