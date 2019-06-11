// the 'make.do' file is automatically created by 'github' package.
// execute the code below to generate the package installation files.
// DO NOT FORGET to update the version of the package, if changed!
// for more information visit http://github.com/haghish/github

make markdoc, replace toc pkg  version(5.0.0)                                   ///
     license("MIT")                                                             ///
     author("E. F. Haghish")                                                    ///
     affiliation("University of Goettingen")                                    ///
     email("haghish@med.uni-goettingen.de")                                     ///
     url("https://github.com/haghish/github")                                   ///
     title("a general-purpose literate programming package")                    ///
     description("generate dynamic document, slides, stata help files, "        ///
		             "and package vignette in various formats")                     ///
     install("markdoc_formal.docx;markdoc_minimal.docx;markdoc_simple.docx;"    ///
		         "markdoc_stata.docx;markdoc_title.dlg;markdoc.ado;markdoc.dlg;"    ///
						 "markdoc.sthlp;markdoccheck.ado;markdocpandoc.ado;"                ///
						 "markdocstyle.ado;markdocversion.ado;markdocwkhtmltopdf.ado;"      ///
						 "markup.ado;mdconvert.ado;mdconvert.sthlp;mdminor.ado;"            ///
						 "mdminor.sthlp;mini.ado;mini.dlg;mini.sthlp;pandoc.ado;"           ///
						 "pandoc.sthlp;rundoc.ado;sthlp.ado;sthlp.sthlp;wkhtmltopdf.ado;"   ///
						 "wkhtmltopdf.sthlp")                                               ///
     ancillary("")                                                        



/*
Generating the package documentation
====================================

The package documentation is written in Markdown language. The MARKDOC package 
extract these documentation and create the Stata help files as well as Markdown 
documentation for GitHub Wiki. Learn more about MARKDOC here: 
https://github.com/haghish/markdoc

Generating Stata Help Files
---------------------------
*/

markdoc "markdoc.ado",     mini export(sthlp) replace
markdoc "mini.ado",        mini export(sthlp) replace
markdoc "mdconvert.ado",   mini export(sthlp) replace
markdoc "mdminor.ado",     mini export(sthlp) replace
markdoc "pandoc.ado",      mini export(sthlp) replace
markdoc "wkhtmltopdf.ado", mini export(sthlp) replace

// generate the Markdown documentation for GitHub
markdoc "markdoc.ado",     mini export(md) replace
markdoc "mini.ado",        mini export(md) replace
markdoc "mdconvert.ado",   mini export(md) replace
markdoc "mdminor.ado",     mini export(md) replace
markdoc "pandoc.ado",      mini export(md) replace
markdoc "wkhtmltopdf.ado", mini export(md) replace

markdoc "vignette.do", export(tex) toc replace master                        ///
        title("markdoc v. 5.0 package vignette")                             ///
				author("E. F. Haghish")
