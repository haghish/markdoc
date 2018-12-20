/***
_version 4.4.0_

Title
=====

__markdoc__ - a general-purpose literate programming package for Stata that
produces _dynamic analysis documents_, _presentation slides_, as well as Stata
package help files and package vignettes in various formats such as __pdf__, 
__docx__, __html__, and __sthlp__.

_for further information see:__

- [markdoc homepage](http://haghish.com/markdoc)
- [markdoc journal article](http://haghish.com/resources/pdf/Haghish_MarkDoc.pdf)
- [markdoc manual on Github wiki](https://github.com/haghish/MarkDoc/wiki)
- [markdoc release notes on Github](https://github.com/haghish/MarkDoc/releases)
- [markdoc examples on GitHub](https://github.com/haghish/MarkDoc/tree/master/Examples)
- [please ask your questions on statalist.org](http://www.statalist.org/forums/forum/general-stata-discussion/general)

Syntax
------

the syntax of the package is simple and can be summarized as:

> __markdoc__ _filename_ [, _options_ ]

where {help filename} can be:

| Document format   | Description                                                                                |
|-------------------|--------------------------------------------------------------------------------------------|
| _.do_             | executes _do_ file, examines the analysis reproducibility, and produces a dynamic document |
| _.smcl_           | converts _smcl_ file to a dynamic document without testing the code reproducibility        |
| _.ado_ or _.mata_ | generates _sthlp_ help files or package vignettes from Markdown documentation              |



and the _options_ are:

| Option                 | Description                                                                                      |
|-------------------|--------------------------------------------------------------------------------------------------|
| mini                   | runs markdoc independent of any third-party software                                             |
| statax                 | activates the built-in [syntax highlighter](https://github.com/haghish/statax)                   |
| replace                | replace the exported file if already exists                                                      |
| **e**xport(_name_)     | document format; it can be __md__, __html__, __docx__, __pdf__, __slide__, __tex__, or __sthlp__ |
| **num**bered           | numbers Stata commands in the dynamic document                                                   |
| date                   | adds the current date in the document                                                            |
| **tit**le(_str_)       | specify the title of the document                                                                |
| **au**thor(_str_)      | specify the author of the document                                                               |
| **aff**iliation(_str_) | specify the author affiliation in the document                                                   |
| **add**ress(_str_)     | specify the author's contact information in the document                                         |
| **sum**mary(_str_)     | specify the summary of the document                                                              |
| **sty**le(_name_)      | specify the style of the document; it can be __simple__, __stata__, or __formal__                |
|                        |                                                                                                  |


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

> [__txt__](https://github.com/haghish/MarkDoc/wiki/txt) [_code_] [_display_directive_ [_display_directive_ [_..._]]]


2. capture and include the current image in the document automatically (if _filename_ is missing)

> [__img__](https://github.com/haghish/MarkDoc/wiki/img) [_filename_]
[, markup(_str_) **tit**le(_str_) **w**idth(_int_) **h**eight(_int_)
**m**arkup(_str_) left center ]


3. create and style a dynamic table in Markdown documents

> [__tbl__](https://github.com/haghish/MarkDoc/wiki/tbl) _(#[,#...] [\ #[,#...] [\ [...]]])_ [, **tit**le(_str_)]


furthermore, you can also call __pandoc__ or __wkhtmltopdf__ within Stata i.e. :

> [__pandoc__](https://github.com/haghish/MarkDoc/wiki/pandoc) _command_

> [__wkhtmltopdf__](https://github.com/haghish/MarkDoc/wiki/wkhtmltopdf) _command_


Installation
------------

The latest release as well as archived older versions of __markdoc__ are hosted on 
[GitHub](https://github.com/haghish/MarkDoc) website. the recommended method 
for installing the package is through [__github__ package](https://github.com/haghish/github)
package, which is used for building, searching, installing, and managing Stata 
packages hosted on GitHub. you can install __github__ by typing:

        . net install github, from("https://haghish.github.io/github/")

next, install __markdoc__ along with its Stata dependencies by typing either
 
        . gitget markdoc

_or alternatively_

        . github install haghish/markdoc





***/

*cap prog drop mini
prog mini
	
	tokenize `"`macval(0)'"', parse(",")
	
	if "`2'" == "," {
		markdoc `0' mini
	}
	else {
		markdoc `0', mini
	}

end

