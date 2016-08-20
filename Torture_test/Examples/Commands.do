cd "C:\Users\haghish\Dropbox\STATA\MY PROGRAMS\MarkDoc\MarkDoc 3.6.5"

********************************************************************************

cap qui prog drop markdoc
cap qui log c
qui log using torture, replace

clear
sysuse auto
reg price mpg

/***
       This is a text chunk! 
	   =====================

	![alt text](graph.png "thitle")

				[hypertext](http://haghish.com "Title")
				
		This is a text paragraph. This is a text paragraph. 
		This is a text paragraph. This is a text paragraph.
***/
		
		//Problem Discovered which merges the text output
		/**/ display as text "this is a text paragraph"
		/**/ display as text "this is a text paragraph"
		/**/ display as text "this is a text paragraph"

				/***/ display as text "this is a text paragraph"
				/***/ display as text "this is a text paragraph"
				/***/ display as text "this is a text paragraph"

local n `m' $thisthat

/***
The TXT Command
===============
***/

txt this is the txt command that can be used for writing dynamic text.  	///
	this is the txt command that can be used for writing dynamic text.  	///
	this is the txt command that can be used for writing dynamic text.  	///
	this is the txt command that can be used for writing dynamic text.  	///
	
txt this is the txt command that can be used for writing dynamic text.  		///
	this is the txt command that can be used for writing dynamic text.  		///
	this is the txt command that can be used for writing dynamic text.  		///
	this is the txt command that can be used for writing dynamic text.  		///
	

txt "this is the txt command that can be used for writing dynamic text."  	///
	"this is the txt command that can be used for writing dynamic text."  	///
	"this is the txt command that can be used for writing dynamic text."  	///
	"this is the txt command that can be used for writing dynamic text."  	///

txt "this is a text paragraph" _n "yeah " ///
"newline?" _s(5) "skipped? :-)  "  _dup(2) "yo"

txt "this is a text paragraph" _n(2) "yeah " ///
"**newline?**" _s(5) "skipped? :-)  "  _dup(2) "yo"

local nn 123456789.1234
txt "this is a text paragraph " mm " or " %9.3f mm " or " `nn' " and more text" _n(4)
txt "this is a text paragraph " mm " or " `nn' " and more text" _n(4)

txt c "CODE " mm " or " `nn' " and more text" _n(4)

qui log c


cap qui prog drop markdoc
markdoc torture, replace linesize(100)
markdoc torture, replace linesize(100) export(pdf) 
markdoc torture, replace linesize(100) export(docx) 

markdoc torture, replace linesize(100) export(docx) template(markdoc_simple.docx)
markdoc torture, replace linesize(100) export(odt) template(markdoc_simple.odt)

markdoc torture, replace linesize(100) export(odt) template(torture2.odt)
exit







//creating PDF 
cap erase example.pdf
markdoc example, exp(pdf) markup(html) replace
markdoc example, exp(pdf) replace statax
markdoc example, exp(pdf) replace
markdoc example, exp(pdf) markup(latex) texmaster replace
markdoc example, exp(pdf) markup(latex) printer("C:\program Files\MiKTeX 2.9\miktex\bin\x64\pdflatex.exe") texmaster replace
markdoc example, exp(pdf) markup(latex) printer("/usr/texbin/pdflatex") texmaster replace

//HTML
cap erase example.html
markdoc example, exp(html) replace
markdoc example, exp(html) replace statax


********************************************************************************
* LATEX
********************************************************************************

//empty log
//=========
cap log close
qui log using torture_latex, replace
            
			
qui log c
markdoc torture_latex, export(tex) markup(latex) replace




//Stata command ONLY
//=========================
cap log close
qui log using torture_latex, replace  
		sysuse auto, clear
		summarize price
qui log c
markdoc torture_latex, export(tex) markup(latex) replace


// COMMENT ONLY
// =========================
cap log close
qui log using torture_latex, replace  
		/***
		\section {SECTION}
		This is a comment
		***/
qui log c
markdoc torture_latex, export(tex) markup(latex) replace




//Start with Comment
//=========================
cap log close
qui log using torture_latex, replace  
		/***
		This is a comment
		***/
		sysuse auto, clear
		summarize price
qui log c
markdoc torture_latex, export(tex) markup(latex) replace


//Start AND END with Comment
//=========================
cap log close
qui log using torture_latex, replace  
		/***
		This is a comment
		***/
		sysuse auto, clear
		summarize price
		/***
		This is a comment
		***/
qui log c
markdoc torture_latex, export(tex) markup(latex) replace



//LaTeX Heading
//=========================
cap log close
qui log using torture_latex, replace  
		/***
		This is a comment
		***/
		sysuse auto, clear
		summarize price
		/***
		This is a comment
		***/
qui log c
markdoc torture_latex, export(tex) markup(latex) replace ///
template(Torture_test/LaTeX/latexHeading.tex) texmaster

markdoc torture_latex, export(tex) markup(latex) replace texmaster


set linesize 80
cap log close
qui log using torture_latex, replace
		/***
		\documentclass[a4paper]{article}
		\usepackage{amsmath}
	\usepackage[english]{babel}
		\usepackage{blindtext}
 
          \begin{document}
                     ***/ 
			display "{p}this is a text"
			
                 summarize mpg
       
            txt "Loop number `x'"
			
			
			display "this is a text"
			
			/***
			this is a text paragraph. this is a text paragraph.
			this is a text paragraph. this is a text paragraph
			***/
			
			summarize mpg

             /***
              \blinddocument    
               \end{document}
              ***/


qui log c
markdoc torture_latex, export(tex) markup(latex) replace
markdoc torture_latex, export(tex) markup(latex) style(empty) replace



//test option
markdoc, test	
			
markdoc, test pandoc("C:\ado\plus\Weaver 2\Pandoc\pandoc.exe") ///
printer("C:\ado\plus\Weaver 2\wkhtmltopdf\bin\wkhtmltopdf.exe")

local pandoc "C:\ado\plus\Weaver 2\Pandoc\pandoc.exe"
local printer "C:\ado\plus\Weaver 2\wkhtmltopdf\bin\wkhtmltopdf.exe"
markdoc example, export(html) statax linesize(120) replace pandoc("`pandoc'") 
markdoc example, export(pdf) statax linesize(120) replace pandoc("`pandoc'") printer("`printer'")

