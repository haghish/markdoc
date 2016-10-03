
*capture program drop markdocstyle
program markdocstyle

version 11
syntax [anything] , export(str) tmp(str) tmp1(str) [master] [markup(str)]	///
[STYle(name)]  [debug] [noisily] [figure] [toc]	[date] [title(str)] 			///
[affiliation(str) author(str) address(str) summary(str) ] 						///
[template(str)] [mathjax] [statax] ///
[Font(str)] [LANDscape] [css(str)] ///
[texmaster]
	
	
	// LaTeX Styling
	// =========================================================================
	if !missing("`master'") | missing("`master'") & 						///
	!missing("`template'") & "`markup'" == "latex" 								///
	& "`export'" != "slide" {
		
		tempname hitch knot 
		qui file open `hitch' using "`tmp'", read 
		qui cap file open `knot' using "`tmp1'", write replace
		file write `knot'  _newline
		file read `hitch' line
		
		**************
		* SIMPLE STYLE
		**************			
		if !missing("`master'") & "`style'" == "simple" {
			file write `knot' 											///
			"\documentclass{article}" _n								///
			"\usepackage{geometry} " _n									///
			"\usepackage{booktabs}         %for tables" _n				///
			"%\geometry{letterpaper} " _n								///
			"\usepackage{graphicx}" _n									///
			"\usepackage{amssymb}" _n									///
			"\usepackage{hyperref}         %use hyperlink" _n			///
			"\usepackage{epstopdf}" _n 									///
			"\DeclareGraphicsRule{.tif}{png}{.png}"						///
			"{`convert #1 `dirname #1`/`basename #1 .tif`.png}" _n		///	
			"\providecommand{\tightlist}{\setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}" ///
			"\makeatletter" _n											///
			"\def\verbatim@font{\ttfamily\scriptsize}" _n				///
			"\makeatother" _n									
					
			// Append external template file
			if !missing("`template'") {
				confirm file "`template'"
				tempname latexstyle
				file open `latexstyle' using "`template'", read
				file read `latexstyle' line
				while r(eof)==0 & substr(trim(`"`macval(line)'"'),1,16) != 	///
				"\begin{document}"{
					cap file write `knot' `"`macval(line)'"' _n
					cap file read `latexstyle' line
				}
				file close `latexstyle'
			}	
					
			file write `knot' "\begin{document}" _n
					
			if !missing("`toc'") {
				file write  `knot' "\clearpage" _n						///
				"\tableofcontents" _n									///
				"\clearpage" _n(2)		
			}
				
			if "`title'" != "" | !missing("`author'") {
				file write `knot' "\title{`title'}" _n
			}
					
			if "`author'" != "" | "`affiliation'" 						///
			!= "" |  "`address'" != "" {
							
				file write `knot' "\author{"
				if "`author'" != "" {
					file write `knot' "`author' " 
				}	
				if "`affiliation'" != "" {
					file write `knot' "\\ \small{`affiliation'} " 
				}
				if "`address'" != "" {
					file write `knot' "\\ \small{\textit{`address'}} " 
				}				
				file write `knot' "} " _n		
			}	
									
			if "`title'" != "" | "`author'" != "" {
				if "`title'" == "" local title "\hphantom"
				file write `knot' "\maketitle" _n	
			}	
						
			if "`summary'" != "" {
				file write `knot' "\begin{abstract}" _n
				file write `knot' "`summary'" _n
				file write `knot' "\end{abstract}" _n(2)
			}					
			file write `knot' "" _n
			file write `knot' "" _n				
		}
								
		*************
		* STATA STYLE
		*************
		if !missing("`master'") & "`style'" == "stata" {
			//change style for affiliation and address
			if "`affiliation'" != "" local affiliation "\\\`affiliation'" //one additional "\" 
			if "`address'"     != "" local address "\\\`address'"
			if "`date'" != "" local date "\\\`c(current_date)'"
						
			file write `knot' 											///
			"\documentclass{article}" _n								///
			"\usepackage[article,notstatapress]{sj}" _n					///
			"\usepackage{epsfig}" _n									///
			"\usepackage{stata}" _n										///
			"\usepackage{booktabs}         %for tables" _n				///
			"\usepackage{hyperref}         %use hyperlink" _n 			///
			"\usepackage{shadow}" _n									///
			"\usepackage{natbib}" _n									///
			"\usepackage{chapterbib}" _n								///
			"\providecommand{\tightlist}{\setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}" ///
			"\bibpunct{(}{)}{;}{a}{}{,}" _n(2)
					
			// Append external template file
			if !missing("`template'") {
				confirm file "`template'"
				tempname latexstyle
				file open `latexstyle' using "`template'", read
				file read `latexstyle' line
				while r(eof)==0 & substr(trim(`"`macval(line)'"'),1,16) != 	///
					"\begin{document}"{
					cap file write `knot' `"`macval(line)'"' _n
					cap file read `latexstyle' line
				}
				file close `latexstyle'
			}	
					
			file write `knot' "\begin{document}" _n
			if !missing("`toc'") {
				file write  `knot' "\clearpage" _n						///
				"\tableofcontents" _n									///
				"\clearpage" _n(2)		
			}
			file write `knot' "\inserttype[st0001]{article}" _n
			file write `knot' "\author{Short article author list}"		///
			"{`author' `affiliation' `address' `date' \and}" _n
			file write `knot' "\title[Short toc article title]{`title'}" _n
			//if "`date'" != "" file write `knot' "\date{\today}" _n
			file write `knot' "\maketitle" _n(2)
						
			if "`summary'" != "" {
				file write `knot' "\begin{abstract}" _n					///
				"`summary'" _n											///
				"%\keywords{\inserttag, command name(s), "				///
				"keyword(s)} %Add keywords" _n							///
				"\end{abstract}" _n(2)
			}
		}
		
		
		
		// Append external template file
		// ------------------------------------------------------------
		if missing("`master'") & !missing("`template'") {
			confirm file "`template'"
			tempname latexstyle
			file open `latexstyle' using "`template'", read
			file read `latexstyle' line
			while r(eof)==0 & substr(trim(`"`macval(line)'"'),1,16) != 	///
			"\begin{document}"{
				cap file write `knot' `"`macval(line)'"' _n
				cap file read `latexstyle' line
			}
			file close `latexstyle'
		}
				
				
		// -------------------------------------------------------------
		// CORRECT STATA STYLE by replacing stlog instead of verbatim
		// =============================================================
		while r(eof) == 0 {
			if "`style'" == "stata" {
				if substr(trim(`"`macval(line)'"'),1,16) == 			///
					"\begin{verbatim}" {
					local line : subinstr local line 					///
					"\begin{verbatim}" "\begin{stlog}"
				}
				if substr(trim(`"`macval(line)'"'),1,14) == 			///
					"\end{verbatim}" {
					local line : subinstr local line 					///
					"\end{verbatim}" "\end{stlog}"
				}
			}
			file write `knot' `"`macval(line)'"' _n  
			file read `hitch' line
		}
								
		// END THE DOCUMENT
		//--------------------------------------------------------------
		if !missing("`master'") & "`style'" == "stata" {
			file write `knot' "\bibliographystyle{sj}" _n				///
			"\bibliography{sj}" _n										///
			"%\begin{aboutauthors}" _n									///
			"%% Write some background "									///
			"information about the author(s)." _n						///
			"%\end{aboutauthors}" _n
		}	
					
		file write `knot'  _n "\end{document}" _n(4)	
		file close `hitch'
		file close `knot'
		
		
	}
	
	
	
	
					
	// HTML Styling
	// =========================================================================
	if "`export'" == "html" {
		
		tempname hitch knot 
		qui file open `hitch' using `"`tmp'"', read 
		qui cap file open `knot' using "`tmp1'", write replace
		
		
		if !missing("`master'") | "`markup'" == "" | "`markup'" == "markdown" {
			file write `knot' "<!doctype html>" _n									///
			"<html>" _n																/// 
			"<head>" _n 															///
			`"<meta http-equiv="Content-Type" "'									///
			`"content="text/html; charset=utf-8" />"' _n
				
			if !missing("`mathjax'") {
				file write `knot' `"<script type="text/javascript" async "' _n 		///
				`"src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?"'			///
				`"config=TeX-MML-AM_CHTML">"' _n									///
				`"</script>"' _n(3)
			}
				
			if !missing("`figure'") 												///
			file write `knot' _n `"<script type="text/javascript" "' _n 			///
			`"src="http://www.haghish.com/software/viz.js">"' _n					///	
			`"</script>"' _n(3)
					
			file write `knot' _n "<!-- SYNTAX HIGHLIGHTING CLASSES  -->" _n(2) 		///
			`"<style type="text/css">"' _n	
				
			file write `knot' ".author {display:block;text-align:center;"			///
			"font-size:16px;margin-bottom:3px;}" _newline
			file write `knot' ".date {display:block;text-align:center;"				///
			"font-size:12px;margin-bottom:3px;}" _newline
			file write `knot' ".center, #center {" _newline 						///
			_skip(4) "display: block;" _newline 									///
			_skip(4) "margin-left: auto;" _newline 					    			///
			_skip(4) "margin-right: auto;" _newline 				    			///
			_skip(4) "-webkit-box-shadow: 0px 0px 2px rgba( 0, 0, 0, 0.5 );" _n 	///
			_skip(4) "-moz-box-shadow: 0px 0px 2px rgba( 0, 0, 0, 0.5 );" _n 		///
			_skip(4) "box-shadow: 0px 0px 2px rgba( 0, 0, 0, 0.5 );" _n(2) 			///
			_skip(4) "padding: 0px;" _newline 						    			///
			_skip(4) "border-width: 0px;" _newline 					    			///
			_skip(4) "border-style: solid;" _newline 				    			///
			_skip(4) "cursor:-webkit-zoom-in;" _newline 			    			///
			_skip(4) "cursor:-moz-zoom-in;" _newline 				    			///
			_skip(4) "}" _newline(2) 								    			///
			"pagebreak {" _newline 									    			///
			_skip(8) "page-break-before: always;" _newline 			    			///
			_skip(8) "}" _newline(2) 								    			///
			".pagebreak, #pagebreak {" _newline 					    			///
			_skip(8) "page-break-before: always;" _newline 			    			///
			_skip(8) "}" _newline(2) 
			
			file write `knot' "td > p {padding:0; margin:0;}" _newline
					
			// TABLES STYLE
			// ============
			file write `knot' _n(4) 								    			///
			"header {" _newline 									    			///
			_skip(8) "font-size:28px;" _newline 					    			///
			_skip(8) "padding-bottom:5px; " _newline 				    			///
			_skip(8) "margin:0;" _newline 							    			///
			_skip(8) "padding-top:150px; " _newline 				    			///
			_skip(8) "font-family: `font';" _newline 				    			///
			_skip(8) "background-color:white; " _newline 			    			///
			_skip(8) "text-align:center;" _newline 					    			///
			_skip(8) "display:block;" _newline 						    			///
			_skip(8) "}" _newline(2) 								    			///
			"table {" _n 											    			///
			_skip(8) "border-collapse: collapse;" _n 				    			///
			_skip(8)"border-bottom:1px solid black;" _n 			    			///
			_skip(8)"padding:5px;" _n 								    			///
			_skip(8)"margin-top:5px;" _n(2) 						    			///
			"}" _n 													    			///
			".tble {" _n 											    			///
			_skip(8)"display:block;" _n 							    			///
			_skip(8)"margin-top: 10px;" _n 							    			///
			_skip(8)"margin-bottom: 0px;" _n 						    			///
			_skip(8)"margin-bottom: 0px;" _n 						    			///
			"}" _n(2) 												    			///
			".tblecenter {" _n 										    			///
			_skip(8)"display:block;" _n 							    			///
			_skip(8)"margin-top: 10px;" _n 							    			///
			_skip(8)"margin-bottom: 0px;" _n 						    			///
			_skip(8)"margin-bottom: 0px;" _n 						    			///
			_skip(8)"text-align:center;" _n 						    			///
			"}" _n(2) 												    			///
			"span.tblecenter + table, span.tble + table, span.tble + img {" _n 		///
			_skip(8)"margin-top: 2px;" _n ///
			"}" _n(2)
			
				
			//Margin left will KEEP the table in the left and won't center it
			/*
			if "`style'" == "" | "`style'" == "simple" {
				file write `knot' "margin-left:0px;" _n
			}
				
			if "`style'" == "stata" {
				file write `knot' "margin-left:0px;" _n
			}
			*/
				
			file write `knot' "th {" _n 											///
			"border-bottom:1px solid black;" _n 									///
			"border-top:1px solid black;" _n 										///
			"padding-right:20px;" _n 												///
			"}" _n(2) 																///
			"td {" _n 																///
			"padding-right:20px;" _n 												///
			"}" _n(2)

			file write `knot' "</style>" _n(4)
			
					
			
			// Stata (DEFAULT) STYLE
			//======================	
			if "`style'" == "stata" {
				file write `knot' _n(2) "<!-- Stata Style  -->" _newline(2) ///
				`"<style type="text/css">"' _newline ///
				"body {" _newline(2) ///
				_skip(8) "margin:10px 30px 10px 30px;" _newline /// 
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "}" _newline(2) ///
				"@page {" _newline ///
				_skip(8) "size: auto;" _newline ///
				_skip(8) "margin: 10mm 20px 15mm 20px;" _newline ///
				_skip(8) "color:#828282;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				`" @top-left "' ///
				`"{ content: "`runhead'" ; font-size:11px; margin-top:5px; } "' _n /// 
				"@bottom {" _newline ///
				_skip(8) `"content: "Page " counter(page); font-size:14px; "' _n ///
				_skip(8) "}" _newline ///
				_skip(8) "}" _newline(2) ///		
				"@page:first {" _newline ///
				"@top-left {" _newline ///
				_skip(8) "content: normal" _newline ///
				_skip(8) "}" _newline ///
				"@bottom {" _newline ///
				_skip(8) "content: normal" _newline ///
				_skip(8) "}" _newline ///
				_skip(8) "}" _newline(2) ///		
				"header {" _newline ///
				_skip(8) "font-size:28px;" _newline ///
				_skip(8) "padding-bottom:5px; " _newline ///
				_skip(8) "margin:0;" _newline ///
				_skip(8) "padding-top:150px; " _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "background-color:white; " _newline ///
				_skip(8) "text-align:center;" _newline ///
				_skip(8) "display:block;" _newline ///
				_skip(8) "}" _newline(2) ///
				"ul {"	_skip(8) "list-style:circle;" _newline ///
				_skip(8) "margin-top:0;" _newline ///				
				_skip(8) "margin-bottom:0;" _newline ///
				_skip(8) "}" _newline(2) ///
				"div ul a {" _newline ///
				_skip(8) "color:black;" _newline ///
				_skip(8) "text-decoration:none;" _newline ///
				_skip(8) "}" _newline(2) ///
				"div ul {" _newline ///
				_skip(8) "list-style: none;" _newline ///
				_skip(8) "margin: 0px 0 10px -15px;" _newline ///
				_skip(8) "padding-left:15px;" _newline ///
				_skip(8) "}" _newline(2) /// 
				"div ul li {" _newline ///
				_skip(8) "font-weight:bold;" _newline ///
				_skip(8) "margin-top:20px;" _newline ///
				_skip(8) "}" _newline(2) ///	
				"div ul li ul li {" _newline ///
				_skip(8) "font-weight: normal;" _newline ///
				_skip(8) "margin-left:20px;" _newline ///
				_skip(8) "margin-top:5px;" _newline ///
				_skip(8) "}" _newline(2) ///
				"div ul li ul li ul li {" _newline ///
				_skip(8) "font-weight: normal;" _newline ///
				_skip(8) "font-style:none;" _newline ///
				_skip(8) "margin-top:5px;" _newline ///
				_skip(8) "}" _newline(2) ///
				"div ul li ul li ul li ul li {" _newline ///
				_skip(8) "font-weight: normal;" _newline ///
				_skip(8) "font-style:italic;" _newline ///
				_skip(8) "margin-top:5px;" _newline ///
				_skip(8) "}" _newline(2) ///		
				"img {" _newline ///
				_skip(8) "margin: 5px 0 5px 0;" _newline ///
				_skip(8) "padding: 0px;" _newline ///
				_skip(8) "cursor:-webkit-zoom-in;" _newline ///
				_skip(8) "cursor:-moz-zoom-in;" _newline ///
				_skip(8) "display:inline-block;" _newline ///
				_skip(8) "text-align: left;" _newline ///
				_skip(8) "clear: both;" _newline ///
				_skip(8) "}" _newline(2) ///		
				"h1, h1 > a, h1 > a:link {" _newline ///
				_skip(8) "margin:24px 0px 2px 0px;" _newline ///
				_skip(8) "padding: 0;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "color:#17365D;" _newline ///
				_skip(8) "font-size: 22px;" _newline ///
				_skip(8) "}" _newline(2) ///
				"h1 > a:hover, h1 > a:hover{" _newline ///
				"color:#345A8A;" _newline ///
				"} " _newline(2) ///
				"h2, h2 > a, h2 > a, h2 > a:link {" _newline ///
				_skip(8) "margin:14px 0px 2px 0px;" _newline ///
				_skip(8) "padding: 0;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "color:#345A8A;" _newline ///
				_skip(8) "font-size: 18px;" _newline ///
				_skip(8) "font-weight:bold;" _newline ///
				_skip(8) "}" _newline(2) ///	
				"h3, h3 > a,h3 > a, h3 > a:link,h3 > a:link {" _newline ///
				_skip(8) "margin:14px 0px 0px 0px;" _newline ///
				_skip(8) "padding: 0;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "color:#4F81BD;" _newline ///
				_skip(8) "font-size: 14px;" _newline ///
				_skip(8) "font-weight:bold;" _newline ///
				_skip(8) "}" _newline(2) ///
				"h4 {" _newline ///
				_skip(8) "margin:10px 0px 0px 0px;" _newline ///
				_skip(8) "padding: 0;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "font-size: 14px;" _newline ///
				_skip(8) "color:#4F81BD;" _newline ///
				_skip(8) "font-weight:bold;" _newline ///
				_skip(8) "font-style:italic;" _newline ///
				_skip(8) "}" _newline(2) ///
				"h5  {" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "font-size: 14px;" _newline ///
				_skip(8) "font-weight:normal;" _newline ///
				_skip(8) "color:#4F81BD;" _newline ///
				_skip(8) "}" _newline(2) ///				
				"h6  {"  _newline ///
				_skip(8) "font-size:14px;" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "font-weight:normal;" _newline ///
				_skip(8) "font-style:italic;" _newline ///
				_skip(8) "color:#4F81BD;" _newline ///
				_skip(8) "}" _newline(2) ///
				"p {" _newline ///
				_skip(8) "font-family: `font';" _newline ///
				_skip(8) "font-weight:normal;" _newline ///
				_skip(8) "font-size:14px;" _newline ///
				_skip(8) "line-height:14px;" _n ///
				_skip(8) "line-height: 16px;" _newline ///
				_skip(8) "text-align:justify;" _n  ///
				_skip(8) "text-align: left;" _newline ///
				_skip(8) "text-justify:inter-word;" _n ///
				_skip(8) "margin:0 0 14px 0;" _n ///
				_skip(8) "}" _newline(2) ///				
				".code {" _newline ///
				_skip(8) "white-space:pre;" _newline ///
				_skip(8) "color: black;" _newline ///
				_skip(8) "padding:5px;" _n   /// 
				_skip(8) "display:block;" _newline ///
				_skip(8) "font-size:12px;" _newline ///
				_skip(8) "line-height:14px;" _newline ///
				_skip(8) "background-color:#E1E6F0;" _newline ///
				_skip(8) `"font-family:"Lucida Console", Monaco, monospace, "Courier New", Courier, monospace;"' _newline ///
				_skip(8) "font-weight:normal;" _n  ///
				_skip(8) "text-shadow:#FFF;" _newline ///
				_skip(8) "border:thin;" _newline ///
				_skip(8) "border-color: #345A8A; " _newline ///
				_skip(8) "border-style: solid;" _newline ///
				_skip(8) "unicode-bidi: embed;" _newline ///
				_skip(8) "margin:20px 0 0px 0;" _n   ///
				_skip(8) "}" _newline(2) ///		
				".output {" _newline ///
				_skip(8) "white-space:pre;" _newline ///
				_skip(8) "display:block;" _n  ///
				_skip(8) `"font-family:monospace,"Lucida Console", Monaco, "Courier New", Courier, monospace;"' _newline ///
				_skip(8) "font-size:12px; " _newline ///
				_skip(8) "line-height: 12px;" _newline ///
				_skip(8) "margin:0 0 14px 0;" _n  ///
				_skip(8) "border:thin; " _newline ///
				_skip(8) "unicode-bidi: embed;" _newline ///
				_skip(8) "border-color: #345A8A; " _newline ///
				///_skip(8) "border-style: solid; " _newline ///
				_skip(8) "padding:14px 5px 0 5px;" _n  ///
				///_skip(8) "border-top-style:none;" _newline /// 
				_skip(8) "background-color:transparent;" _n ///
				_skip(8) "}" _newline(2) 
		
				//if "$printername" == "prince" | "$printername" == "princexml" {
				//	file write `knot' "@media print {" _n ///
				//	_skip(8) ".code {line-height:8px;padding:6px;}" _n ///	
				//	_skip(8) "}" _n(2) 	
				//}
				file write `knot' "</style>" _newline(4)	
			}	
					

			if !missing("`statax'") {
				file write `knot' `"<script type="text/javascript" src='http://haghish.com/statax/Statax.js'></script>"' _n
			}
			
			if !missing("`template'") {	
				file write `knot' `"<link rel="stylesheet" type="text/css" href="`template'">"' _n
			}
			
			
			file write `knot' "</head>" _n ///

			*writing the header
			if "`title'" != "" {
				file write `knot' `"<header>`title'</header>"' _n
			}
			
			file write `knot' "<body>" _n 
					
			if "`author'" != "" {
				file write `knot' `"<span class="author">`author'</span>"' _n
			}		
					
			if "`affiliation'" != "" {
				file write `knot' `"<span class="author">`affiliation'</span>"' _n
			}
			
			if "`address'" != "" {
				file write `knot' `"<span class="author">`address'</span>"' _n
			}	
					
			if "`date'" != "" {
				file write `knot' `"<span class="date">`c(current_date)'</span>"' _n
			}	
					
			if "`summary'" != "" {
				file write `knot' 												///
				`"<p style="padding-right:15%; "' 								///
				`"padding-left:15%;padding-top:100px;"'							///
				`"text-align: justify;text-justify:"'							///
				`"inter-word;">`summary'</p><br />"' _n
			}	
					
			/* adding the date in the fitst page */
			//if "`date'" == "date" {
			//		file write `knot' ///
			//		`"<span style="font-size: 12px;text-align:center;"' ///
			//		`"display:block; padding: 0 0 30px 0;">"' ///
			//		`"<span id="spanDate"></span></span>"' _n(2)
			//		}
		}			
		
		//Copy the rest of the document
		file write `knot'  _newline
		file read `hitch' line	
				
		while r(eof) == 0 {
					
			local word1 : word 1 of `"`macval(line)'"'
					
			// replace <pre><code>
			//local line : subinstr local line "<pre><code>" "<result>", all
			//local line : subinstr local line "</pre></code>" "</result>", all
					
			file write `knot' `"`macval(line)'"' _n  
			file read `hitch' line
		}
					
		//ending
		if !missing("`master'") | "`markup'" == "" | "`markup'" == "markdown" {					
			file write `knot' "</body>" _n 
			file write `knot' "</html>" _n
		}	
				
		file close `knot'
		file close `hitch'	
	}
	
	
	if !missing("`noisily'") {
		display as txt _n "Document Style was appended successfully..." _n(2)	
	}	
		
	if !missing("`debug'") {
		copy "`tmp1'" "0style.txt", replace	
	}
		
end
