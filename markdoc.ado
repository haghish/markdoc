// documentation is written for markdoc package (github.com/haghish/markdoc) 
// . markdoc markdoc.ado, mini export(sthlp) replace

/***
_version 5.0.0_

markdoc
=======

__markdoc__ is a general-purpose literate programming package for Stata that
produces _dynamic analysis documents_, _presentation slides_, as well as Stata
package help files and package vignettes in various formats such as __pdf__, 
__docx__, __html__, and __sthlp__. 

for further information see:

- [markdoc homepage](http://haghish.com/markdoc)
- [journal article](https://journals.sagepub.com/doi/abs/10.1177/1536867X1601600409)
- [manual on Github wiki](https://github.com/haghish/markdoc/wiki)
- [package vignette (pdf)](https://github.com/haghish/markdoc/blob/master/vignette.pdf)
- [release notes on Github](https://github.com/haghish/markdoc/releases)
- [examples on GitHub](https://github.com/haghish/markdoc/tree/master/Examples)
- [please ask your questions on statalist.org](http://www.statalist.org/forums/forum/general-stata-discussion/general)

> from version _5.0_ forth, __markdoc__ is 
{err}fully functional without any third-party software{txt}, due to its new 
light-weight [mini engine](https://github.com/haghish/markdoc/wiki/mini). Yet, 
a full installation of __markdoc__ and its dependencies is recommended.

Syntax
------

the syntax of the package is simple and can be summarized as:

> __markdoc__ _filename_ [, _options_ ]

where _filename_ can be:

| Document format       | Description                                                                                |
|-----------------|--------------------------------------------------------------------------------------------|
| __.do__               | executes _do_ file, examines the analysis reproducibility, and produces a dynamic document |
| __.smcl__             | converts _smcl_ file to a dynamic document without testing the code reproducibility        |
| __.ado__ or __.mata__ | generates _sthlp_ help files or package vignettes from Markdown documentation              |


### Options

the main options are the following:

| Option                 | Description                                                                                      |
|-------------------|--------------------------------------------------------------------------------------------------|
| mini                   | runs markdoc independent of any third-party software                                             |
| statax                 | activates [statax](https://github.com/haghish/statax) syntax highlighter                         |
| replace                | replaces exported document, if exists                                                            |
| **e**xport(_name_)     | format; it can be __docx__, __pdf__, __html__, __sthlp__, __slide__, __md__, or __tex__ |

the supplementary options are the following:

| Option                 | Description                                                                                      |
|-------------------|--------------------------------------------------------------------------------------------------|
| **num**bered           | numbers Stata commands in the dynamic document                                                   |
| date                   | adds the current date in the document                                                            |
| **tit**le(_str_)       | specify the title of the document                                                                |
| **au**thor(_str_)      | specify the author of the document                                                               |
| **aff**iliation(_str_) | specify the author affiliation in the document                                                   |
| **add**ress(_str_)     | specify the author's contact information in the document                                         |
| **sum**mary(_str_)     | specify the summary of the document                                                              |
| **sty**le(_name_)      | specify the style of the document; it can be __simple__, __stata__, or __formal__                |


options related to software documentation:

| Option                 | Description                                                                                      |
|-------------------|--------------------------------------------------------------------------------------------------|
| helplayout             | appends a Markdown help layout template to a script file                                         |


and the following options are for communicating with the third-party software (not required in the __mini__ mode)

| Option                 | Description                                                                                      |
|-------------------|--------------------------------------------------------------------------------------------------|
| **instal**l            | installs the pandoc and wkhtmltopdf automatically, if they are not found                         |
| unc                    | specify that markdoc is being accessed from a Windows server with UNC file paths                 |
| **pan**doc(_str_)      | specify the path to Pandoc software on the operating system                                      |
| **print**er(_str_)     | specify the path to pdf driver on the operating system                                           |
| **mark**up(_name_)     | specify the markup language used for notation; the default is Markdown                           |
| master                 | automatically creates the layout for LaTeX and HTML documents                                    |
| template(_str_)        | renders the document using an external style sheet file or example docx file                     |
| **t**est               | examines markdoc third-party software with an example                                            |
| toc                    | creates table of content                                                                         |


Additional commands
-------------------

__markdoc__ includes a few commands that freatly simplify writing the workflow. you
may use the additioval commands to:

1. write dynamic text, while applying any display directive supported by the {help display} command:

> [__txt__](https://github.com/haghish/markdoc/wiki/txt) [_code_] [_display_directive_ [_display_directive_ [_..._]]]


2. capture and include the current image in the document automatically (if _filename_ is missing)

> [__img__](https://github.com/haghish/markdoc/wiki/img) [_filename_]
[, markup(_str_) **tit**le(_str_) **w**idth(_int_) **h**eight(_int_)
**m**arkup(_str_) left center ]


3. create and style a dynamic table in Markdown documents

> [__tbl__](https://github.com/haghish/markdoc/wiki/tbl) _(#[,#...] [\ #[,#...] [\ [...]]])_ [, **tit**le(_str_)]


furthermore, you can also call __pandoc__ or __wkhtmltopdf__ within Stata i.e. :

> [__pandoc__](https://github.com/haghish/markdoc/wiki/pandoc) _command_

> [__wkhtmltopdf__](https://github.com/haghish/markdoc/wiki/wkhtmltopdf) _command_

Installation
------------

The latest release as well as archived older versions of __markdoc__ are hosted on 
[GitHub](https://github.com/haghish/markdoc) website. the recommended method 
for installing the package is through [__github__ package](https://github.com/haghish/github)
package, which is used for building, searching, installing, and managing Stata 
packages hosted on GitHub. you can install __github__ by typing:

        . net install github, from("https://haghish.github.io/github/")

next, install the latest stable __markdoc__ release along with its Stata 
dependencies by typing:

        . github install haghish/markdoc, stable

Description
-----------

__markdoc__ is a general-purpose literate programming package for Stata that 
produces _dynamic analysis documents_, _package vignette documentation_, 
_dynamic presentation slides_, as well as dynamic _Stata package help files_. 
to improve applications of the package for developing educational materials 
and encouraging university lecturers to ask students to practice 
literate programming for taking notes or doing their semester projects, 
__markdoc__ was programmed to include unique features. These features make the package a 
complete tool for documenting data analysis, Stata packages, as well as a tool for 
producing educational materials within Stata Do-file editor. For example: 

- it includes a syntax highlighter
- it recognizes markdown, html, and latex markup languages
- it can render LaTeX mathematical notations in __pdf__, __docx__, __html__, __odt__, and __tex__ documents 
- it can automatically capture graphs from Stata and include them in the document
- it creates dynamic tables and supports writing dynamic text for interpretting the analysis
- it includes a user-friendly GUI interface (try __db markdoc__) to make using __markdoc__ easier for newbies.

Software Installation
---------------------

Without applying the __mini__ option, which uses the light-weight engine, 
the markdoc package requires additional software which can be installed manually or 
automatically. The required software are [Pandoc](http://pandoc.org/) and
[wkhtmltopdf](http://wkhtmltopdf.org). They are both 
opensource freeware, supported for any common operating system such as Microsoft Windows, 
Macintosh, and Linux. Naturally, users who wish to use LaTeX markup for writing 
the documentation, will need a [pdfLaTeX](https://latex-project.org). 

After a manual installation, the path to executable Pandoc should be specified in 
__pandoc__ option. similarly, the path to executable wkhtmltopdf or pdfLaTeX 
should be given to __printer__ option. Note that the __printer__ option 
is only needed for compiling PDF document. 

With automatic installation (i.e. using the __install__ option), Pandoc and 
Wkhtmltopdf are downloaded and placed
in Weaver directory which is located in __/ado/plus/Weaver/__ on your machine. To find the 
location of __ado/plus/__ directory on your machine use the 
[sysdir](help sysdir) command which returns the system directories. 

Set file paths permanently
--------------------------

After manual installation, the paths to the executable Pandoc, wkhtmltopdf, 
and pdfLaTeX can be permanently set using __weave setup__ command. This command 
will open _weaversetup.ado_ document, where you can define the files paths as global macros.

Software troubleshoot
---------------------

As mentioned, the required software can be installed manually or automatically. 
The optional automatic installation is expected to 
work properly in Microsoft Windows __XP__, Windows __7__, and Windows __8.1__, Macintosh  
__OSX 10.9.5__, Linux __Mint 17 Cinnamon__ (32bit & 64bit), Ubuntu __14__ (64bit), and 
__CentOS 7__ (64bit). Other operating systems may require manual software installation. 

However, if for some technical or permission reasons markdoc fails to download, access, or run 
Pandoc, install it manually and provide the 
file path to Pandoc using __PANDOC__ option. 

Calling Pandoc
--------------

[__PANDOC__](HELP PANDOC) commands can also be executed from Stata. This command takes the path to 
the executable Pandoc from markdoc and allows you to use Pandoc seamlessly for converting 
files within Stata. FOR EXAMPLE:

        . pandoc ./example.tex -o ./example.html

Writing mathematical notation
-----------------------------

__markdoc__ can render LaTeX mathematical notations not only when the document 
is exported to LaTeX __tex__, but also when the document is exported to 
__pdf__ document or __slide__, Microsoft Office __docx__, 
OpenOffice and LibreOffice __odt__, and __html__. 

mathematical notations can be inline a text paragraph or on a separate line. 
For writing inline notations, place the notation between single dollar signs, 
for example: $a^2 + b^2 = c^2$ 
For including notation on a separate line, place the 
notations between double dollar signs: $$a^2 + b^2 = c^2$$ 

Inserting an image or figure in the document
--------------------------------------------

Any of the supported markup languages can be used to insert a figure in the 
document. In general, there are two ways for inserting an image in the document. 
First, you can use Markdown, HTML, or LaTeX syntax for inserting an image - 
that is already saved in your hard drive - in the document. The other solution 
is using [__img__](https://github.com/haghish/markdoc/wiki/img) command. 
__img__ command can take the _filename_ of exsisting image on the hard 
drive and print the markup code (Markdown, HTML, or LaTeX. the default is 
Markdown) int he document. __img__ command can also auto-export the current 
graph and import it in the document. For more information in this regard see 
the [__img__](https://github.com/haghish/markdoc/wiki/img). 

Writing dynamic text
--------------------

the [__txt__](help txt) command is borrowed from {help weaver} package to print 
dynamic text in the the exported dynamic document. 
It can be used for interpreting the analysis results or dynamically referring to values of 
scalars or macros in the dynamic document. Writing dynamic text allows the content of 
the text to change by altering analysis codes and thus is the desirable way 
for explaining the analysis results. The text and 
macros can be styled using any of the supported markup languages in markdoc which are 
_markdown_, _LaTeX_, and _HTML_. This command is fully documented on 
[GitHub Wiki](https://github.com/haghish/markdoc/wiki/txt). 

Creating dynamic tables with tbl command
----------------------------------------

the [__tbl__](help tbl) command also belongs 
to [weaver](https://github.com/haghish/weaver) package. The syntax of this command
is similar to __matrix input__, however, it can include _string_, _digits_, 
_scalars_, and _macros_ to create a dynamic table. This command is fully documented 
on [__GitHub Wiki__](https://github.com/haghish/markdoc/wiki/tbl).

Markers
-------

__markdoc__ also introduces a few handy markers for annotating the 
document, regardless of the markup language you use to write the document 
(Markdown, Tex, HTML). These markers can be used to specify what 
parts of the code should or should not appear in the dynamic document. The 
table below provides a brief summary of these annotating markers. in general, 
comments - unless they appear after a command - will be ignored in the dynamic 
document. However, the markers mentioned below are _"special comments"_ that will 
influence the markdoc process. 

1. Creating text block

~~~
. /***
  creates a block of comments in the smcl file that will be interpreted 
  in the dynamic document. this sign is distinguished from the normal comment 
  signs, with one star.
. ***/
~~~

2. Hiding command or output

~~~
. /**/ only include the output in the dynamic document and hide the comment
. /**/ only include the command in the dynamic document and hide the output
~~~

3. Hiding a section. Anything placed after __//OFF__ until __//ON__ markers will be _ignored_ in the dynamic document

~~~
. //OFF
  Stata code
. //ON
~~~

4. Appending external text file (Markdown, HTML, LaTeX) to the dynamic document

~~~
. //IMPORT filename
~~~

Apart from the text block markers, the other markers _are not supported within loops_.  
Nonetheless, writing markup text within the loop is not recommended either because 
it only gets printed once. For active writing within the loop or a program, see the 
{help txt} command. 

Markers examples
----------------

### Example of riting text in the do-file
 
As noted, __markdoc__ package allows writing and styling text as a comment in 
the do-file, using special comment signs. here is an example:

~~~
. /***
  Text heading
  ============

  subheading
  ---------- 

  When you write a dynamic document in markdoc, place text between
  the "/***" and "***/" signs. But they should be placed on separate lines,
  as shown in this example.
. ***/
~~~

Dynamic Document Examples
-------------------------

~~~
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
~~~

When the log file is created, we can translate it with __markdoc__

~~~
. markdoc example, replace export(html) install
. markdoc example, replace export(docx)
. markdoc example, replace export(tex) master
. markdoc example, replace export(pdf)
. markdoc example, replace export(epub)
~~~

Dynamic Slide Examples
----------------------

this is an example of generating dynamic slides with __markdoc__

~~~
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
~~~

Supported markup languages
--------------------------

markdoc supports three markup languages which are Markdown, HTML, and LaTeX. 
Markup languages should not be used together in one document because 
__markdoc__ process each markup language differently.


Remarks
-------

If the log-file is closed exactly using __"qui log c"__ command, __markdoc__ 
automatically removes this command from the end of the file. 
Similarly, markdoc removes __"qui log off"__ from the logfile. Therefore __"qui log off"__ 
and __"qui log on"__ can be used to separate codes in the dofile that are not wanted in the 
dynamic document, but still required in for the analysis. Nonetheless, this is not a 
proper practice and can harm the transparency of the analytic session. The log-file 
should include as much information about the history of the analysis as possible. 
Use the "Markers" for hiding sections of the log-file in the dynamic document. 

Author
------

E. F. Haghish   
University of Göttingen    
_haghish@med.uni-goesttingen.de_  
[https://github.com/haghish](https://github.com/haghish)

See also
--------

- [Statax](https://github.com/haghish/statax), JavaScript & LaTeX syntax highlighter for Stata

License
-------

MIT License

- - -

This help file was dynamically produced by 
[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/) 
***/



*cap prog drop markdoc
program markdoc
    
    // -------------------------------------------------------------------------
    // NOTE:
    // Stata 14 introduces ustrltrim() function for removing Unicode whitespace 
    // characters and blanks. The previous trim() function cannot remove unicode 
    // whitespace. The program is updated to function for all versions of Stata, 
    // but yet, there is a slight chance of "unreliable" behavior from markdoc 
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
    mini             /// runs markdoc independent of Pandoc and wkhtmltopdf
    MARKup(name)     /// specifies the markup language used in the document
    Export(name)     /// specifies the exported format
	saving(str)      /// UNDOCUMENTED 
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
	suppress         /// UNDOCUMENTER, avoids unnecessary warnings
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
    macro drop currentmarkdocdofile
    
    // =========================================================================
    // CHANGED SYNTAX
    // =========================================================================    
    local mathjax mathjax
    if !missing("`mini'") {
		if !missing("`markup'") {
			if "`markup'" != "md" | "`markup'" != "markdown" | "`markup'" != "Markdown" {
				display as err "{bf:`markup'} markup language is not supported in markdoc {bf:mini}"
			}
		}
	}
    if "`style'"  == "" local style "simple" 
                    
    if !missing("`texmaster'") {
        di "The {bf:texmaster} option was renamed to {bf:master}, although it " ///
       "continues to work..." _n 
       local master master
    }   
    
    if !missing("`linesize'") {
        di "The {bf:linesize} option is discontinued. {bf:markdoc} auto-detects "   ///
       "the linesize..." _n 
       local linesize
    }
		
	// =========================================================================
    // check the path: make sure the file is executed from the working directory
    // ========================================================================= 
	if !missing("`mini'") {
		local currentwd : pwd
		capture abspath "`smclfile'"
		if _rc != 0 capture abspath `smclfile'
		if _rc == 0 {
			if "`currentwd'" != "`r(path)'" {
				if missing("`suppress'") di as err "{bf:WARNING}: make sure your source file is in your current working directory"
			}
		}		
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
	
	// Creating html slides with for he light-weight markdoc mini
    // -------------------------------------------------------------------------
	if !missing("`mini'") & "`export'" == "slide" {
		local export slidehtm
	}
 
    // Auto-correcting possible typos
    // -------------------------------------------------------------------------
    if "`markup'" == "HTML" local markup html
    if "`markup'" == "LATEX" local markup latex
    if "`markup'" == "Markdown" local markup markdown
    if "`export'" == "markdown" local export md
    if "`export'" == "PDF" local export pdf
    if "`export'" == "HTML" local export html
    if "`export'" == "LATEX" | "`export'" == "latex" local export tex
    if "`export'" == "SMCL" local export smcl
    if "`export'" == "STHLP" local export sthlp
    if "`export'" == "latex" local export tex
    
	// =========================================================================
	// MINI MODE
	//
	// mini mode is used to avoid depending on third-party software. It currently 
	// only allows generating markdown documents and html documents in Stata 15. 
	// later on supports for docx and pdf will be provided
	// -------------------------------------------------------------------------
	if !missing("`mini'") {
		if `c(stata_version)' < 15 & "`export'" != "sthlp" & "`export'" != "slidehtm" {
			di as err "the {bf:mini} option requires Stata 15 or above"
			di as txt "you could remove the {bf:mini} option and run markdoc in the full-version mode"
			err 1
		}
		
		if "`export'" != "md" & "`export'" != "html"          ///
		   & "`export'" != "docx" & "`export'" != "pdf"       ///
			 & "`export'" != "sthlp" & "`export'" != "slidehtm" {
			di as err "the {bf:mini} option currently only supports " ///
					  "{bf:md}, {bf:html}, {bf:docx}, {bf:pdf}, {bf:slide}, and {bf:sthlp} formats"
			err 198
		}
	}
        
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

    // should markdoc be quiet?
    // -------------------------------------------------------------------------
    if missing("`noisily'") {
        local cap cap
    }

    // The printer is used for creating PDF documents in markdoc. In general,
    // there are 2 printers available which are "wkhtmltopdf" & "pdflatex."
    // The default is "wkhtmltopdf" 
    // -------------------------------------------------------------------------
    if "`export'" == "pdf" &  "`markup'" != "latex" {
        global printername "wkhtmltopdf"        //printer for HTML and Markdown
        
        if missing("`printer'") & !missing("$pathWkhtmltopdf") {
            local printer "$pathWkhtmltopdf"
        }
    }

    // should markdoc create a layout master?
    // -------------------------------------------------------------------------
    if !missing("`style'") | !missing("`statax'") | "`export'" == "pdf" {
        if "`export'" == "pdf" | "`export'" == "html"  {
            local master master     
        }
    }
		if "`export'" == "tex" & !missing("`statax'") {
		  local master master 
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
            "markdoc attempts to access pdfLaTeX automatically)" _n             

            display "(warning! pdfLaTeX not found...)"
            //error 100
        }
    }
    
    // =========================================================================
    // STYLE
    // 
    // markdoc applies a number of styles for HTML, PDF, and LaTeX documents
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
    if missing("`mini'") & "`export'" != "sthlp" & "`export'" != "slidehtm" {
		markdoccheck , `install' `test' export(`export') style(`style')           ///
		markup(`markup') pandoc("$pandoc") printer("`printer'")
	}
        
    // -------------------------------------------------------------------------
    // TEST markdoc
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
        di as txt "{p}{ul: {bf:Running markdoc Test}}" _n
        di as txt "{p}The example do-file is successfully executed. Next, "                                 ///
        "markdoc attempts to compile a HTML and PDF document" _n
        
        markdoc example, export(html) statax replace                ///
        title(Testing markdoc Package) author(E. F. Haghish)                    ///
        affiliation("Medical Biometry and Medical Informatics, "                ///
        "University of Freiburg")                                               ///
        address(haghish@imbi.uni-freiburg.de) style(stata) pandoc("`pandoc'")   ///
        printer("`printer'") `noisily' `install'
        
        markdoc example, export(pdf) statax replace                 ///
        title(Testing markdoc Package) author(E. F. Haghish)                    ///
        affiliation("Medical Biometry and Medical Informatics, "                ///
        "University of Freiburg")                                               ///
        address(haghish@imbi.uni-freiburg.de) style(stata) pandoc("`pandoc'")   ///
        printer("`printer'") `noisily' `install'
        
        
        cap quietly findfile "example.html"
        if "`r(fn)'" != "" {
            cap quietly findfile "example.pdf"
            if "`r(fn)'" != "" {
                display as txt "{p}{bf: markdoc works properly. "               ///
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
        if missing("`mini'") & "`export'" != "slide" {
			display as txt "{p}(The {bf:statax} option is only used "           ///
			 "when exporting to {bf:html}, {bf:pdf}, or {bf:tex} formats)" _n
			 local statax                           //Erase the macro
		}
    }
	if !missing("`mini'") {
		if "`export'" != "html" & "`export'" != "slidehtm" {
			local statax
		}
	}

    // PDF PROCESSING
    // ==============
    // Create a local for processing the PDF. Then change the export to HTML
    // and later, change it to PDF using the "pdfhtml" local
    if missing("`mini'") & "`export'" == "pdf" & "`markup'" != "latex" {
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
        capture abspath "`smclfile'"
				if _rc != 0 capture abspath `smclfile'
        if _rc == 0 {
            local smclfile `r(abspath)'
        }
    }
    

    //If there is NO SMCL FILE and INSTALL or TEST options are not given, 
    //RETURN AN ERROR that the SMCL FILE IS NEEDED
        
    if "`smclfile'" == "" & "`test'" == "" & "`install'" == "" {
        
        di as txt _n(2) "{bf:markdoc requires...}" _n(2)                        ///
        "    smcl log-file to produce a dynamic document or PDF slides" _n      ///
        "    {cmd:. markdoc {it:smclname}, [options]}" _n(2)                    ///
        "    do, ado, or mata file to produce dynamic Stata help files" _n      ///
        "    {cmd:. markdoc {it:filename}, export(sthlp)}" _n(2)                ///
        "    the {bf:test} option to test the required third-party software" _n ///
        "    {cmd:. markdoc, test}" _n(2)                                       ///
        "see {help markdoc} for more details"
        exit 198
    }
                    
    //Avoid Syntax Error for TEST and INSTALL options, when there is no
    //SMCL file specified in the command. To do so, only run the engine
    //when the SMCL file is provided and the TEST option is NOT GIVEN. 
    //HOWEVER, IF THE USER WISHES TO RUN markdoc AND INSTALL IT AT THE SAME
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
			local extension smcl

			if "`export'" == "slidehtm" {
				local convert "`input'.htm"
				local output "`output'.htm"
			}
	
			else if "`export'" == "slide" {
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
						local extension ado
            *if "`export'" == "slide" local convert "`input'.pdf"
            *else if "`export'" == "dzslide" local convert "`input'.html"
            *else if "`export'" == "slidy" local convert "`input'.html"
            *else local convert "`input'.`export'"
            if "`export'" == "slidehtm" {
                local convert "`input'.htm"
                local output "`output'.htm"
            }
			else if "`export'" == "slide" {
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
			local extension mata
			if "`export'" == "slidehtm" {
                local convert "`input'.htm"
                local output "`output'.htm"
            }
            else if "`export'" == "slide" local convert "`input'.pdf"
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
						local extension do
			
						if "`export'" == "slidehtm" {
                local convert "`input'.htm"
                local output "`output'.htm"
            }
            else if "`export'" == "slide" {
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
            global rundoc "`input'"                 //allow rundoc get nested in the file
        }
		else if (index(lower("`input'"),".md")) {
			local extension md
            local input : subinstr local input ".md" ""
			
			if "`export'" == "slidehtm" {
                local convert "`input'.htm"
                local output "`output'.htm"
            }
            else if "`export'" == "slide" {
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
            
            local md  "`input'_.md"
            local html "`input'_.html"
            local pdf "`input'.pdf"
            local name "`input'"
            local input  "`input'.md"
            local scriptfile 1                     //define a scriptfile
            
        }
        else if (!index(lower("`input'"),".smcl")) { 
						
						if !missing("`debug'") di as err "FILE TYPE UNKNOWN"
			
						if "`export'" == "slidehtm" {
                local convert "`input'.htm"
                local output "`output'.htm"
            }
            else if "`export'" == "slide" {
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
		
		// ??? update this in the documentation after testing
		if !missing("`saving'") local convert `saving'

        
    
        quietly copy "`tempput'" "`output'", replace

     
        // =========================================================================
        // Execute rundoc for the do-files
        //
        // execute rundoc with the `name' which does not have the ".do"
        // =========================================================================
        if !missing("`rundoc'") {
            
			if !missing("`noisily'") di as err "{title:INITIATING RUNDOC.ado}"			
            if !missing("`pdfhtml'") local export "pdf"
			if !missing("`pdfmd'")   local export "pdf"
            
            rundoc "`name'",                                                    ///
            `replace'                                                           ///
            `mini'                                                              ///
            markup(`markup')                                                    ///
            export(`export')                                                    ///
			saving(`saving')                                                  	///
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
            `debug'                                                         	///
			`suppress'                                                     		///
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
            
			macro drop currentmarkdocdofile  
            exit
        }
    

        
        
        
        
    // -------------------------------------------------------------------------
    // RUN THE ENGINE FOR LOG FILES
    // =========================================================================
    if missing("`scriptfile'") {
    
    
        **************************************************** 
        *
        * MAIN ENGINE : Log to Document
        * -----------
        * Part 0- Correcting grave accents in the end of the line
        * Part 1- Correcting the SMCL file
        * Part 2- Processing the SMCL file
        * Part 3- Converting the SMCL file
        *   A: Convert to TXT
        *   B: Process the TXT file
        * Part 4- Converting TXT to Markdown / HTML / LaTeX
        * Part 5- Exporting dynamic document
        ****************************************************   
        
        ****************************************************
		* PART 0. CORRECTING THE SMCL FILE FROM GRAVE ACCENTS
		*         - the grave accents are common markdown
			*           syntax. If the accents appear as the last
		*           character of the line, they crash Stata
		*           with an error of "too few quotes". I have 
			*           found a workaround, but is not 100% secure
			*           If you have better suggestions, please 
			*           go ahead and submit your code on GitHub
		****************************************************
        tempfile tmp00                     //DEFINE tmp00 FOR THE FIRST TIME
        tempname hitch knot 
        qui file open `hitch' using `"`input'"', read
        qui file open `knot' using `"`tmp00'"', write replace
        file read `hitch' line
                
        while r(eof) == 0 { 
            capture if substr("`macval(line)'",-1,.) == "`" local graveaccent 1
            else local graveaccent ""
            
            if "`graveaccent'" == "1" {
                local line "`macval(line)' " 
                local graveaccent ""
            }
            
            local line : subinstr local line "``" "\`", all
            
            capture file write `knot' `"`macval(line)'"' _n
            file read `hitch' line
        }
                
        file write `knot' `"`macval(line)'"' _n
        file close `hitch'
        file close `knot'
        if !missing("`debug'") {
            capture erase 0process0.smcl
            copy "`tmp00'" 0process0.smcl , replace         //For debugging
        }
                
        
        ****************************************************
        * PART 1. CORRECTING THE SMCL FILE 
        *         - Removing indents before special notations
        *         - Loop correction
        *         - Changing "." to "{com}."
        ****************************************************
        tempfile tmp //DEFINE tmp FOR THE FIRST TIME
        tempname hitch knot 
                *qui file open `hitch' using `"`input'"', read
        qui file open `hitch' using `"`tmp00'"', read
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
            
            //remove markdoc output text
            if substr(trim(`"`macval(line)'"'),1,16) == "(markdoc created"      ///
            | substr(trim(`"`macval(line)'"'),1,19) == "{p}(markdoc created" {
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
                    di as err _n(2) "{title:Warning}"
                    di as err "{p}your documentation has a width of "           ///
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
				
				if !missing("`scriptfile'") {
				  translator set smcl2txt linesize 255
				}
        
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
        if "`export'" != "tex" & "`export'" != "pdf" & "`export'" != "html" & "`export'" != "slidehtm" {
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
        
                if missing("`mini'") & "`export'" == "docx" | "`export'" == "odt" {
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
                                    capture if substr("`macval(line)'",-1,.) == "`" local graveaccent 1
                              else local graveaccent ""
                                        if "`graveaccent'" == "1" {
                                            local line "`macval(line)' " 
                                            local graveaccent ""
                                        }
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
                                local graveaccent ""
                                capture if substr("`macval(line)'",-2,.) == "` " local graveaccent 1
                                if missing("`graveaccent'") {
                                *if !missing(`"`macval(clue)'"') {
                                  if `"`macval(clue)'"' == "***" & substr(`"`macval(line)'"',1,4) != "    " {
                    local line : subinstr local line "***" ""
                                    }
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
				
				
		// If a Markdown file was given, replace the processed file
		// -----------------------------------------------------------------
		if "`extension'" == "md" {
		  quietly copy "`input'" "`tmp1'" , replace public
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
                                        
                    if missing("`mini'") & "`noisily'" == "noisily" {
                        di _n(2) "{title:Executing Pandoc Command}" _n
                        di `""$pandoc" `mathjax' `toc' "'               ///
                        `"`reference' "`md'" -o "`output'""'
                    }
                    
				// ---------------------------------------------------------
				// rendering the markdown with pandoc or mini mode
				// ---------------------------------------------------------
				if missing("`mini'") {
					shell "$pandoc" `mathjax' `toc'         ///
                    `reference' "`md'" -o "`output'"            
                    quietly copy "`output'" "`convert'", replace       
				} 
				else {
					if "`noisily'" == "noisily" di _n(2) "{title:Applying mini mode}" _n
					if "`export'" == "md" {
						quietly copy "`md'" "`output'", replace
						if missing("`mini'") {
						  quietly copy "`md'" "`convert'", replace 
						}
						else {
							capture quietly copy "`md'" "`convert'", replace public  // this was a bug on Windows
							if _rc local convert "`md'"
						}
					}
					else if "`export'" == "html" {
						quietly markdown "`md'", saving("`output'") replace
						quietly copy "`output'" "`convert'", replace
					}
					else if "`export'" == "docx" {
						local version = int(`c(stata_version)')
						if `version' < 16  {
						  quietly mdconvert using "`md'", export(docx) name("`output'") replace
						  quietly copy "`output'" "`convert'", replace
						}
						
						// on Stata 16, first export a styled HTML file and then 
						// :: call the html2docx command to ceate the Docx file
						else {
						  tempfile tempo
						  global tempo "`tempo'"
						  quietly markdoc "`md'", mini export(html) saving("$tempo") replace suppress
						  quietly html2docx "$tempo", saving("`output'") replace //base("`currentwd'")
						  quietly capture rm "$tempo"
						  quietly copy "`output'" "`convert'", replace public
						}
					}
					else if "`export'" == "pdf" {
						local version = int(`c(stata_version)')
						if `version' < 16  {
						  quietly mdconvert using "`md'", export(pdf) name("`output'") replace
						  quietly copy "`output'" "`convert'", replace
						}
						else {
							tempfile tempo
							tempfile tempo2
							global tempo "`tempo'"
							global tempo2 "`tempo2'"
							quietly markdoc "`md'", mini export(html) saving("$tempo") replace suppress
							quietly html2docx "$tempo", saving("$tempo2") replace //base("`currentwd'")
							quietly docx2pdf "$tempo2", saving("`output'") replace 
							quietly capture rm "$tempo"
							quietly capture rm "$tempo2"
							quietly copy "`output'" "`convert'", replace public
						}

					}
					
				}
                    
                    
				if !missing("`debug'") {
					copy "`md'" 0md2.md, replace
					if "`export'" != "slidehtm" {
						copy "`output'" 00output.txt, replace
						copy "`convert'" 00convert.txt, replace
					}
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
                    di as txt "(markdoc created "`"{bf:{browse "`name'.pdf"}})"' _n
                }
                else display as err "markdoc could not produce `name'.pdf" _n
            }
            
            else if "`export'" != "slidehtm" {
                cap confirm file "`convert'"
                if _rc == 0 {
                    di as txt "(markdoc created "`"{bf:{browse "`convert'"}})"' _n
                    if "`export'" != "md" cap qui erase "`md'"
					if "`extension'" == "md" cap qui erase "`md'"
                }
                else display as err "markdoc could not produce `convert'" _n
            }
        }
        
        if "`export'" == "" {

            cap confirm file "`md'"
            if ! _rc {
                di as txt "(markdoc created "`"{bf:{browse "`md'"}})"' _n
            }
        
            // IF THERE WAS NO PANDOC AND NO MARKDOWN FILE...
            else di as err "markdoc could not access Pandoc..." _n      
        }
            
        *change the md files to markdown
        if "`export'" == "md" local export markdown
        
        // INSTALLING LATEX STYLES
        // =======================
        
        // When exporting to LaTeX, if "stata" style is specified, markdoc 
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
    
	// =========================================================================
	// Generate Stata Help Files 
	// =========================================================================
	if "`export'" == "sthlp" | "`export'" == "smcl" {
		if "`smclfile'" != "" & "`test'" == "" {

		sthlp `smclfile', markup("`markup'") export("`export'")                  ///
			template("`template'") `replace' `date' title("`title'")             ///
			author("`author'") affiliation("`affiliation'") address("`address'") ///
			summary("`summary'") `asciitable' version("`version'")               ///
			`helplayout' `build' `debug'
		}
	}
	
	// =========================================================================
	// Generate Stata Help Files 
	// =========================================================================
	if "`export'" == "slidehtm" {
		//https://github.com/gnab/remark
		tempfile tmp
		tempname hitch knot 
		qui file open `hitch' using `"`md'"', read 
		qui cap file open `knot' using "`tmp'", write replace
		
		file write `knot' `"<!DOCTYPE html>"' _n
		file write `knot' `"<html>"' _n
		file write `knot' `"  <head>"' _n
		file write `knot' `"    <title>`title'</title>"' _n
		file write `knot' `"    <meta charset="utf-8">"' _n
		file write `knot' `"    <style>"' _n
		file write `knot' `"      @import url(https://fonts.googleapis.com/css?family=Yanone+Kaffeesatz);"' _n
		file write `knot' `"      @import url(https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic);"' _n
		file write `knot' `"      @import url(https://fonts.googleapis.com/css?family=Ubuntu+Mono:400,700,400italic);"' _n
		
		if "`style'" == "stata" {
			file write `knot' "      body { font-family: 'Droid Serif'; }" _n
			file write `knot' "      h1, h2, h3 {" _n
			file write `knot' "        font-family: 'Yanone Kaffeesatz';" _n
			file write `knot' "        font-weight: normal;" _n
			file write `knot' "      }" _n
			file write `knot' "      .sh_stata {font-size:60%;; background-color:#EAF2F3;}" _n
		}
		else if "`style'" == "formal" {
			file write `knot' "      body { font-family: 'time'; }" _n
			file write `knot' "      h1, h2, h3 {" _n
			file write `knot' "        font-family: 'time';" _n
			file write `knot' "        font-weight: normal;" _n
			file write `knot' "      }" _n
			file write `knot' "      .sh_stata {font-size:60%;font-weight: bold;}" _n
		}
		else {
			file write `knot' "      body { font-family: 'Droid Serif'; }" _n
			file write `knot' "      h1, h2, h3 {" _n
			file write `knot' "        font-family: 'Yanone Kaffeesatz';" _n
			file write `knot' "        font-weight: normal;" _n
			file write `knot' "      }" _n
			file write `knot' "      .sh_stata {font-size:60%;}" _n
		}
		
		file write `knot' "      .remark-code, .remark-inline-code { font-family: 'Ubuntu Mono'; font-size:60%;}" _n
		file write `knot' "    </style>" _n
		file write `knot' "    <script type='text/javascript' src='http://haghish.com/statax/Statax.js'></script>" _n
		
		

		file write `knot' `"  </head>"' _n
		file write `knot' `"  <body>"' _n
		file write `knot' `"    <textarea id="source">"' _n(3)
		
		
		file write `knot' "class: center, middle" _n(2)
		
		if !missing("`title'") file write `knot' "# `title'" _n(2)
		if !missing("`author'") file write `knot' "## `author'" _n(2)
		if !missing("`affiliation'") file write `knot' "_`affiliation'_  " _n
		if !missing("`address'") file write `knot' "_`address'_  " _n(2)
		
		if !missing("`affiliation'") & missing("`address'") file write `knot' _n
		
		if !missing("`summary'") file write `knot' "`summary'" _n
		
		if !missing("`title'") | !missing("`author'") | !missing("`affiliation'") | ///
		   !missing("`address'") | !missing("`summary'") {
			 file write `knot' _n(2) "---" _n(2)
		}


		
		file read `hitch' line  
		
		if substr(trim(`"`macval(line)'"'),1,8) ==  "Rundoc 1"  {
			file read `hitch' line
		}
    
		local codeblock //reset
		
		while r(eof) == 0 {
			
			local jump //reset
			
			if !missing("`statax'") {
				
				// check for code block
				if missing("`codeblock'") & substr(`"`macval(line)'"',1,3) == "~~~" {
					local codeblock 1
					file write `knot' "<pre class='sh_stata'>" _n
					file read `hitch' line
					local jump 1
				}
				if !missing("`codeblock'") & substr(`"`macval(line)'"',1,3) == "~~~" {
					local codeblock //reset
					file write `knot' "</pre>" _n
					file read `hitch' line
					local jump 1
				}
			
				if missing("`jump'") {
					if substr(`"`macval(line)'"',1,12) == "          . " {
						file write `knot' "<pre class='sh_stata'>"
						file write `knot' `"`macval(line)'</pre>"' _n
						
						//make sure next line is empty
						file read `hitch' line
						if trim(`"`macval(line)'"') != "" {
							file write `knot' _n
							local jump 1
						}
						else {
							file write `knot' `"`macval(line)'"' _n
						}
					}
					else {
						file write `knot' `"`macval(line)'"' _n
					}
				}
				
			}
			else {
				file write `knot' `"`macval(line)'"' _n
			}
		
			if missing("`jump'") file read `hitch' line
		}
		
		file write `knot' `"    </textarea>"' _n
		file write `knot' `"    <script src="https://remarkjs.com/downloads/remark-latest.min.js">"' _n
		file write `knot' `"    </script>"' _n
		file write `knot' `"    <script>"' _n
		file write `knot' `"      var slideshow = remark.create();"' _n
		file write `knot' `"    </script>"' _n
		file write `knot' `"  </body>"' _n
		file write `knot' `"</html>"' _n
		
		file close `knot'
		file close `hitch'


		if !missing("`debug'") {
			copy "`tmp'" 05B.txt    , replace
		}
		
		qui copy "`tmp'" "`convert'", `replace'
		cap confirm file "`convert'"
		if _rc == 0 {
			di as txt "(markdoc created "`"{bf:{browse "`convert'"}})"' _n
			if "`export'" != "md" cap qui erase "`md'"
			if "`extension'" == "md" cap qui erase "`md'"
		}
		else display as err "markdoc could not produce `convert'" _n
	}   
    
    // Drop the global macros
    // -------------------------------------------------------------------------
    // this kills the live-preview. NOT A GOOD IDEA
    // if missing("$weaver") macro drop currentFigure
		
	if !missing("`noisily'") {
	  di as err "removing global macros in markdoc.ado"
	}          
    
    // check for markdoc updates
    *markdocversion
		
	macro drop currentmarkdocdofile  
  
end
