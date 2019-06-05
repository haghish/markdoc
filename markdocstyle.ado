
*capture program drop markdocstyle
program markdocstyle

version 11
syntax [anything] , export(str) tmp(str) tmp1(str) [master] [markup(str)]	///
[STYle(name)]  [debug] [noisily] [figure] [toc]	[date] [title(str)] 			///
[affiliation(str) author(str) address(str) summary(str) ] 						///
[template(str)] [mathjax] [statax] ///
[Font(str)] [LANDscape] [css(str)] ///
[texmaster]
	
	
	// =========================================================================
	// GENERAL STYLES
	// =========================================================================
	if "`export'" == "html" {
		
		if "`style'" == "simple" {
			
			// FONT
			local fontfamily `""Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif"'
			local headerfontsize "28px"
			
			// BACKGROUND % STYLE COLOR 
			local pgbackground "white"
			local codebackground "#f3f6fa"
			local prebackground "#f3f6fa"
			local prebordercolor "#dce6f0"
			local bqbordercolor "#dce6f0"
			local hrcolor "#eff0f1"
			
			//FONT COLOR
			local h1color "#17365D"
			local h2color "#345A8A"
			local h3color "#4F81BD"
			local h4color "#4F81BD"
			local h5color "#17365D"
			local h6color "#17365D"
			local pcolor "black"
			local bqcolor "#819198"
			local precolor "#567482"
			local precodecolor "#567482"
			local codecolor "#383e41"
			local linkcolor "#1e6bb8"
			
			if !missing("`statax'") {
				local precodecolor "#6D6D6D"
			}
		}
		
		if "`style'" == "stata" {
			
			// FONT
			local fontfamily `""Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif"'
			local headerfontsize "28px"
			
			// BACKGROUND % STYLE COLOR 
			local pgbackground "white"
			local codebackground "#EAF2F3"
			local prebackground "#EAF2F3"
			local prebordercolor "#E8F0F1"
			local bqbordercolor "#E8F0F1"
			local hrcolor "#eff0f1"
			
			//FONT COLOR
			local h1color "#343F44"
			local h2color "#4A5A60"
			local h3color "#4A5A60"
			local h4color "#4A5A60"
			local h5color "#4A5A60"
			local h6color "#4A5A60"
			local pcolor "black"
			local bqcolor "#819198"
			local precolor "#567482"
			local precodecolor "#567482"
			local codecolor "#383e41"
			local linkcolor "#5A727C"
			
			if !missing("`statax'") {
				local precodecolor "#6D6D6D"
			}
		}	
		
		if "`style'" == "formal" {
			
			// FONT
			local fontfamily `""Times New Roman", Times, serif"'
			local headerfontsize "28px"
			
			// BACKGROUND % STYLE COLOR 
			local pgbackground "white"
			//local codebackground "#EAF2F3"
			//local prebackground "#EAF2F3"
			local prebordercolor "white"
			local bqbordercolor "#eff0f1"
			local hrcolor "#eff0f1"
			
			//FONT COLOR
			local h1color "black"
			local h2color "black"
			local h3color "black"
			local h4color "black"
			local h5color "black"
			local h6color "black"
			local pcolor "black"
			local bqcolor "black"
			local precolor "#567482"
			local precodecolor "#6D6D6D"
			local codecolor "#383e41"
			local linkcolor ""
			
			if !missing("`statax'") {
				local precodecolor "#6D6D6D"
			}
		}
	}
	
	
	
	
	
	
	
	

	
	
	
	// LaTeX Styling
	// =========================================================================
	if !missing("`master'")  & "`markup'" == "latex" 					///
	& "`export'" != "slide" | 											///
	!missing("`master'")  & "`export'" == "tex" 						///
	| missing("`master'") & 											///
	!missing("`template'") & "`markup'" == "latex" 						///
	& "`export'" != "slide" {
		
		tempname hitch knot 
		qui file open `hitch' using "`tmp'", read 
		qui cap file open `knot' using "`tmp1'", write replace
		file write `knot'  _newline
		file read `hitch' line
	
		if !missing("`statax'") {			
			local d : pwd
			cap qui cd "`c(sysdir_plus)'/s"
			local tempPath : pwd
			*local template "`tempPath'/Statax.tex"	
			local mytheme "`tempPath'/Statax.tex"	
			confirm file "`mytheme'"
			cap qui cd "`d'"

			local stataxcode "\include{Statax}              %included in your working dorectory"
		}
		
		// GENERAL STYLE 
		// ---------------------------------------------------------------------
		file write `knot' 											///
		"\documentclass{article}" _n								
		
		if !missing("`statax'") file write `knot'  "`stataxcode'" _n		
		
		file write `knot' 											///
		"\usepackage{epsfig}" _n									///
		"\usepackage{hyperref}         %use hyperlink" _n 			///
		"\usepackage{booktabs}         %for tables" _n				///
		"\usepackage{longtable}        %for long tables" _n			///
		"\usepackage{fixltx2e}         % for \textsubscript" _n     ///
		"\usepackage{graphicx}" _n									///
		
		
		
		**************
		* SIMPLE STYLE
		**************			
		if !missing("`master'") & "`style'" != "stata" {
			file write `knot' 											///
			"\usepackage{geometry} " _n									///
			"%\geometry{letterpaper} " _n								///
			"\usepackage{lmodern}" _n									///
			"\usepackage{amssymb}" _n									///
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
			
			if !missing("`toc'") {
				file write  `knot' "\clearpage" _n						///
				"\tableofcontents" _n									///
				"\clearpage" _n(2)		
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
						
			file write `knot' 													///
			"\usepackage[article,notstatapress]{sj}" _n							///
			"\usepackage{stata}" _n												///
			"\usepackage{shadow}" _n											///
			"\usepackage{natbib}" _n											///
			"\usepackage{chapterbib}" _n										///
			"\providecommand{\tightlist}{\setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}" ///
			"\bibpunct{(}{)}{;}{a}{}{,}" _n(2)
					
			// Append external template file
			if !missing("`template'") {
				confirm file "`template'"
				tempname latexstyle
				file open `latexstyle' using "`template'", read
				file read `latexstyle' line
				while r(eof)==0 & substr(trim(`"`macval(line)'"'),1,16) != 		///
					"\begin{document}"{
					cap file write `knot' `"`macval(line)'"' _n
					cap file read `latexstyle' line
				}
				file close `latexstyle'
			}	
					
			file write `knot' "\begin{document}" _n
			if !missing("`toc'") {
				file write  `knot' "\clearpage" _n								///
				"\tableofcontents" _n											///
				"\clearpage" _n(2)		
			}
			file write `knot' "\inserttype[st0001]{article}" _n
			file write `knot' "\author{Short article author list}"				///
			"{`author' `affiliation' `address' `date' \and}" _n
			file write `knot' "\title[Short toc article title]{`title'}" _n
			//if "`date'" != "" file write `knot' "\date{\today}" _n
			file write `knot' "\maketitle" _n(2)
						
			if "`summary'" != "" {
				file write `knot' "\begin{abstract}" _n							///
				"`summary'" _n													///
				"%\keywords{\inserttag, command name(s), "						///
				"keyword(s)} %Add keywords" _n									///
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
			while r(eof)==0 & substr(trim(`"`macval(line)'"'),1,16) != 			///
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
			
			// STATA JOURNAL
			if "`style'" == "stata" {
				

				if substr(trim(`"`macval(line)'"'),1,16) == 					///
					"\begin{verbatim}" {
					local line : subinstr local line 							///
					"\begin{verbatim}" "\begin{stlog}"
					local codeverb 1
					local jump 1
					local linenumber 0
				}
				
				if substr(trim(`"`macval(line)'"'),1,14) == 					///
					"\end{verbatim}" {
					local line : subinstr local line 							///
					"\end{verbatim}" "\end{stlog}"
					local codeverb 
					local linenumber 0
				}
				
				
				if !missing("`codeverb'") {
					if "`linenumber'" > "1" {
						local line : subinstr local line 						///
						"\" "\\", all
					}	
					local linenumber `++linenumber'
				}
				

			}
			
			
			// STATAX
			// ======
			// THIS IS A QUICK WAY TO FIX A BUG. IMPROVE IT TO MAKE MARKDOC FASTER
			// -----------------------------------------------------------------
			else if "`style'" != "stata" & !missing("`statax'") {
				
				if substr(trim(`"`macval(line)'"'),1,16) == 					///
					"\begin{verbatim}" {
					file read `hitch' line
					local activate 1
				}	
				if substr(trim(`"`macval(line)'"'),1,14) == 	"\end{verbatim}" {
					file read `hitch' line
					local activate 0
				}	
				
				
				local jump2 //RESET
				
				// BEGIN THE PROCESS
				if "`activate'" == "1" {	
					
					
					if substr(trim(`"`macval(line)'"'),1,1) == "." {
						file write `knot' "\begin{statax}" _n
						while missing("`endverb'") & trim(`"`macval(line)'"') != "" {
							if trim(`"`macval(line)'"') != "\end{verbatim}" {
								file write `knot' `"`macval(line)'"' _n
							}	
							else {
								local endverb 1
								file read `hitch' line
							}
							if missing("`endverb'") file read `hitch' line
						}
						file write `knot' "\end{statax}" _n
					}
					
					if missing("`endverb'") {
						di as err `"`macval(line)'"'
						file write `knot' "\begin{verbatim}" _n
						
						while substr(trim(`"`macval(line)'"'),1,1) != "." 		///
						& r(eof) == 0 {
							if trim(`"`macval(line)'"') != "\end{verbatim}" {
								file write `knot' `"`macval(line)'"' _n
							}	
							file read `hitch' line
							local jump2 1
						}
						file write `knot' "\end{verbatim}" _n
					}
					else  {
						
						local activate 0
						file read `hitch' line
						local jump2
					}
					local endverb //
				}
			}
			
			if missing("`jump2'") & missing("`jump'") file write `knot' `"`macval(line)'"' _n  
			if !missing("`jump'") {
				file write `knot' `"`macval(line)'"' _n(2) 
				local jump  //RESET
			}	
			if missing("`jump2'") file read `hitch' line
		}
				
				
				
				
		// END THE DOCUMENT
		//--------------------------------------------------------------
		if !missing("`master'") & "`style'" == "stata" {
			file write `knot' "\bibliographystyle{sj}" _n						///
			"\bibliography{sj}" _n												///
			"%\begin{aboutauthors}" _n											///
			"%% Write some background "											///
			"information about the author(s)." _n								///
			"%\end{aboutauthors}" _n
		}	
		
		file write `knot'  _n "\end{document}" _n(4)	
		file close `hitch'
		file close `knot'
		
		
		// CORRECTION STATAX 2
		// THIS IS A QUICK WAY TO FIX A BUG. IMPROVE IT TO MAKE MARKDOC FASTER
		// --------------------------------------------------------------
		if "`style'" != "stata" & !missing("`statax'") {
			tempfile tmp
			qui copy "`tmp1'" "`tmp'", replace 
			tempname hitch knot 
			qui file open `hitch' using "`tmp'", read 
			qui cap file open `knot' using "`tmp1'", write replace
			file write `knot'  _newline
			file read `hitch' line
			
			while r(eof) == 0 {
				if trim(`"`macval(line)'"') == "\end{statax}" {
					file read `hitch' line
					if trim(`"`macval(line)'"') == "\begin{verbatim}" {
						file read `hitch' line
						if trim(`"`macval(line)'"') == "" {
							file read `hitch' line
							if trim(`"`macval(line)'"') == "\end{verbatim}" {
								file read `hitch' line
								if trim(`"`macval(line)'"') == "\begin{statax}" {
									file read `hitch' line
								}
								else {
									file write `knot' "\end{statax}" _n
									file write `knot' `"`macval(line)'"' _n
								}	
							}
							else {
								file write `knot' "\end{statax}" _n
								file write `knot' "\begin{verbatim}" _n
								file write `knot' "" _n
								file write `knot' `"`macval(line)'"' _n
							}	
						}
						else {
							file write `knot' "\end{statax}" _n
							file write `knot' "\begin{verbatim}" _n
							file write `knot' `"`macval(line)'"' _n
						}
					}
					else {
						file write `knot' "\end{statax}" _n
					}
				}
		
				file write `knot' `"`macval(line)'"' _n  
				file read `hitch' line
			}
			file close `hitch'
			file close `knot'
		}
	}
	
	
	
	
					
	// HTML Styling
	// =========================================================================
	if !missing("`master'") & "`export'" == "html" {
		
		tempname hitch knot 
		qui file open `hitch' using `"`tmp'"', read 
		qui cap file open `knot' using "`tmp1'", write replace
		
		
		if !missing("`master'") & "`markup'" == "" | !missing("`master'") & "`markup'" == "markdown" {
			file write `knot' "<!doctype html>" _n								///
			"<html>" _n															/// 
			"<head>" _n 														///
			`"<meta http-equiv="Content-Type" "'								///
			`"content="text/html; charset=utf-8" />"' _n
				
			if !missing("`mathjax'") {
				file write `knot' `"<script type="text/javascript" async "' _n 	///
				`"src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?"'		///
				`"config=TeX-MML-AM_CHTML">"' _n								///
				`"</script>"' _n(3)
			}
				
			if !missing("`figure'") 											///
			file write `knot' _n `"<script type="text/javascript" "' _n 		///
			`"src="http://www.haghish.com/software/viz.js">"' _n				///	
			`"</script>"' _n(3)
					
			file write `knot' _n "<!-- SYNTAX HIGHLIGHTING CLASSES  -->" _n(2) 	///
			`"<style type="text/css">"' _n	
			
			
			// BODY, HEADINGS, A, 
			// -----------------------------------------------------------------
			file write `knot' 													///
			"body {" _n 														///
				_skip(4) `"font-family: `fontfamily';"' _n 						///
				_skip(4) "text-align:justify;" _n								///
				_skip(4) "margin: 0 8%;" _n 									///
				_skip(4) "font-size: 14px;" _n 									///
				_skip(8) "background-color:`pgbackground'; " _newline 			///
			"}" _newline(2)														///	 						
			"a {" _n 															///
				"   color: `linkcolor';" _n 									///
				"	text-decoration: none;" _n 									///
			"}" _n 																///
			"a:hover {" _n 														///
				"	text-decoration: underline;" _n 							///
			"}" _n(2) 															
			
			// BODY, HEADINGS, A, 
			// -----------------------------------------------------------------
			file write `knot' 													///
			"h1, h2, h3, h4, h5, h6 {" _n 										///
				_skip(4) "line-height: 1.5;" _n 								///
			"}" _n(2)															///
			"h1, h1 > a, h1 > a:link {" _newline 								///
			_skip(8) "margin:0.67em 0;" _newline 								///
			_skip(8) "padding: 0;" _newline 									///
			_skip(8) "font-family: `font';" _newline 							///
			_skip(8) "color:`h1color';" _newline 								///
			_skip(8) "font-size: 22px;" _newline 								///
			_skip(8) "}" _newline(2) 											///
			"h1 > a:hover, h1 > a:hover{" _newline 								///
			"color:#345A8A;" _newline 											///
			"} " _newline(2) 													///
			"h2, h2 > a, h2 > a, h2 > a:link {" _newline 						///
			_skip(8) "margin:14px 0px 2px 0px;" _newline 						///
			_skip(8) "padding: 0;" _newline 									///
			_skip(8) "color:`h2color';" _newline 								///
			_skip(8) "font-size: 18px;" _newline 								///
			_skip(8) "font-weight:bold;" _newline 								///
			_skip(8) "}" _newline(2) 											///	
			"h3, h3 > a,h3 > a, h3 > a:link,h3 > a:link {" _newline 			///
			_skip(8) "margin:14px 0px 0px 0px;" _newline 						///
			_skip(8) "padding: 0;" _newline 									///
			_skip(8) "color:`h3color';" _newline 								///
			_skip(8) "font-size: 16px;" _newline 								///
			_skip(8) "font-weight:bold;" _newline 								///
			_skip(8) "}" _newline(2) 											///
			"h4 {" _newline 													///
			_skip(8) "margin:10px 0px 0px 0px;" _newline 						///
			_skip(8) "padding: 0;" _newline 									///
			_skip(8) "font-family: `font';" _newline 							///
			_skip(8) "font-size: 16px;" _newline 								///
			_skip(8) "color:`h4color';" _newline 								///
			_skip(8) "font-weight:bold;" _newline 								///
			_skip(8) "font-style:italic;" _newline 								///
			_skip(8) "}" _newline(2) 											///
			"h5  {" _newline 													///
			_skip(8) "font-size: 14px;" _newline 								///
			_skip(8) "font-weight:normal;" _newline 							///
			_skip(8) "color:#4F81BD;" _newline 									///
			_skip(8) "}" _newline(2) 											///			
			"h6  {"  _newline 													///
			_skip(8) "font-size:14px;" _newline 								///
			_skip(8) "font-weight:normal;" _newline 							///
			_skip(8) "font-style:italic;" _newline 								///
			_skip(8) "color:#4F81BD;" _newline 									///
			_skip(8) "}" _newline(2) 											///
			"p {" _newline 														///
			_skip(8) "font-weight:normal;" _newline 							///
			_skip(8) "font-size:14px;" _newline 								///
			_skip(8) "line-height: 16px;" _newline 								///
			_skip(8) "text-align:justify;" _n  									///
			_skip(8) "text-justify:inter-word;" _n 								///
			_skip(8) "margin:0 0 14px 0;" _n 									///
			_skip(8) "}" _newline(2) 
				
			// Author, Date, and Center CLASSES
			// -----------------------------------------------------------------
			file write `knot' 													///		
			".author {display:block;text-align:center;"							///
			"font-size:16px;margin-bottom:3px;}" _newline
			file write `knot' ".date {display:block;text-align:center;"			///
			"font-size:12px;margin-bottom:3px;}" _newline
			file write `knot' ".center, #center {" _newline 					///
			_skip(4) "display: block;" _newline 								///
			_skip(4) "margin-left: auto;" _newline 					    		///
			_skip(4) "margin-right: auto;" _newline 				    		///
			_skip(4) "-webkit-box-shadow: 0px 0px 2px rgba( 0, 0, 0, 0.5 );" _n ///
			_skip(4) "-moz-box-shadow: 0px 0px 2px rgba( 0, 0, 0, 0.5 );" _n 	///
			_skip(4) "box-shadow: 0px 0px 2px rgba( 0, 0, 0, 0.5 );" _n(2) 		///
			_skip(4) "padding: 0px;" _newline 						    		///
			_skip(4) "border-width: 0px;" _newline 					    		///
			_skip(4) "border-style: solid;" _newline 				    		///
			_skip(4) "cursor:-webkit-zoom-in;" _newline 			    		///
			_skip(4) "cursor:-moz-zoom-in;" _newline 				    		///
			_skip(4) "}" _newline(2) 								    			
			
			file write `knot' "td > p {padding:0; margin:0;}" _newline
					
			// HEADER
			// -----------------------------------------------------------------
			file write `knot' _n(2) 								    		///
			"header {" _newline 									    		///
			_skip(8) "font-size:`headerfontsize';" _newline 					///
			_skip(8) "padding-bottom:5px; " _newline 				    		///
			_skip(8) "margin:0;" _newline 							    		///
			_skip(8) "padding-top:150px; " _newline 				    		///
			_skip(8) `"font-family: `fontfamily';"' _newline 				    ///
			_skip(8) "text-align:center;" _newline 					    		///
			_skip(8) "display:block;" _newline 						    		///
			_skip(8) "font-weight:bold;" _newline 								///
			_skip(8) "}" _newline(2) 								    			
			
			// TABLE
			// -----------------------------------------------------------------
			file write `knot' _n(2) 								    		///
			"table {" _n 											    		///
			_skip(8) "border-collapse: collapse;" _n 				    		///
			_skip(8)"border-bottom:1px solid black;" _n 			    		///
			_skip(8)"padding:5px;" _n 								    		///
			_skip(8)"margin-top:5px;" _n						    	    	///
			_skip(8)"margin-bottom: 16px;" _n(2) 					    		///
			"}" _n 													    		///
			".tble {" _n 											    		///
			_skip(8)"display:block;" _n 							    		///
			_skip(8)"margin-top: 10px;" _n 							    		///
			_skip(8)"margin-bottom: 0px;" _n 						    		///
			_skip(8)"margin-bottom: 0px;" _n 						    		///
			"}" _n(2) 												    		///
			".tblecenter {" _n 										    		///
			_skip(8)"display:block;" _n 							    		///
			_skip(8)"margin-top: 10px;" _n 							    		///
			_skip(8)"margin-bottom: 0px;" _n 						    		///
			_skip(8)"margin-bottom: 0px;" _n 						    		///
			_skip(8)"text-align:center;" _n 						    		///
			"}" _n(2) 												    		///
			"span.tblecenter + table, span.tble + table, span.tble + img {" _n 	///
			_skip(8)"margin-top: 2px;" _n 										///
			"}" _n(2)
			
				
			//Margin left will KEEP the table in the left and won't center it
			
			// FIGURE STYLW
			// -----------------------------------------------------------------
			file write `knot' 													///
			".figure, .caption {" _n											///
				_skip(8)"text-align: center" _n									///
			"}" _n(2)
	
			
			/*
			if "`style'" == "stata" {
				file write `knot' "margin-left:0px;" _n
			}
			*/
				
			file write `knot' "th {" _n 										///
			_skip(8) "border-bottom:1px solid black;" _n 						///
			_skip(8) "border-top:1px solid black;" _n 							///
			_skip(8) "padding-right:20px;" _n 									///
			"}" _n(2) 															///
			"td {" _n 															///
			_skip(8) "padding-right:20px;" _n 									///
			"}" _n(2)															///
			
			// PRE CODE
			// -----------------------------------------------------------------
			file write `knot' "pre code {" _n 									///
			"	color: `precodecolor';" _n 										///
			"	font-size: 10px;" _n 											///
			"	padding-top: 0;" _n 											///
			"	padding-bottom: 0;" _n 											///
			"	margin-top: 0;" _n 												///
			"	margin-bottom: 0;" _n 											///
			`"	font-family: "menlo-regular","Consolas", "Liberation Mono", "'  /// 
			`"Menlo, Courier, monospace;"' _n									///
			"   display: block;" _n 											///
			"}" _n(2)
			
			// Statax
			// -----------------------------------------------------------------
			if !missing("`statax'") {
				file write `knot' 												///
				".sh_stata {" _n 												///
				"   font-size: 0.7rem;" _n 										///
				"	padding-top: 0;" _n 										///
				"	padding-bottom: 0;" _n 										///
				"	margin-top: 0;" _n 											///
				"	margin-bottom: 0;" _n 										///
				"   display: block;" _n											///
				"   line-height: 1.5;" _n 										///
			    "}" _newline(2)													///
				"pre > code {" _n 												///
				"   padding: 0;" _n 											///
				"	margin: 0;" _n 												///
				"	word-break: normal;" _n 									///
				"   display: block;" _n 										///
			    "}" _n(2)														///
				".sh_stata + pre code {" _n										///
				"    margin:-10px 0 0 -10px;" _n								///
				"    line-height:8px;" _n 										///
				"}" _n(2)
			}
			else {
				file write `knot' 												///
				"code {" _n 													///
				"   padding: 2px 4px;" _n 										///
				`"	font-family: Consolas, "Liberation Mono", Menlo, "'			///
					`"Courier, monospace;"' _n 									///
				"	font-size: 0.9rem;" _n 										///
				"	color: `codecolor';" _n 									///
				"	background-color: `codebackground';" _n 					///
				"   border-radius: 0.3rem; " _n									///
			    "}" _n(2)														///
				"pre {" _n 														///
				"   padding: 0.8rem ;" _n 										///
				`"	font: 1rem Consolas, "Liberation Mono", Menlo,  "'			///
					`"Courier, monospace;"' _n 									///
				"	margin-top: 0;" _n 											///
				"	margin-bottom: 1rem;" _n 									///
				"	color: `precolor';" _n 										///
				"   word-wrap: normal;" _n										///
				"   background-color: `prebackground';" _n 						///
				"   border: solid 1px `prebordercolor';" _n 					///
				"   border-radius: 0.3rem; " _n									///
			    "}" _n(2)														///
				"pre > code {" _n 												///
				"   padding: 0;" _n 											///
				"   margin: 0;" _n 												///
				"   word-break: normal;" _n 									///
			    "}" _n(2)
			}
			
			// QUOTE BLOCK
			// -----------------------------------------------------------------
			file write `knot' 													///
			"blockquote {" _n 													///
			"	padding: 0 1rem;" _n 											///
			"	margin-left: 0;" _n 											///
			"	color: `bqcolor';" _n 											///
			"	border-left: 0.3rem solid `bqbordercolor';" _n 					///	
			"}" _n(2)
			
			// img ???
			// -----------------------------------------------------------------
			file write `knot' 													///
			"img {" _newline 													///
				_skip(8) "margin: 5px 0 5px 0;" _newline 						///
				_skip(8) "padding: 0px;" _newline 								///
				_skip(8) "cursor:-webkit-zoom-in;" _newline 					///
				_skip(8) "cursor:-moz-zoom-in;" _newline 						///
				_skip(8) "display:inline-block;" _newline 						///
				_skip(8) "clear: both;" _newline 								///
				_skip(8) "}" _newline(2) 
			
			// HR
			// -----------------------------------------------------------------
			file write `knot' 													///
			"hr {" _n 															///
			"	height: 2px;" _n 												///
			"	margin: 1rem 0;" _n 											///
			"	background-color: `hrcolor';" _n 								///
			"	border: 0; " _n 												///	
			"}" _n(2)
			
			// UL LI
			// -----------------------------------------------------------------
			file write `knot' 													///
			"ul li {" _n 														///
			"	font-size:14px;" _n 											///				
			"}" _n(2)
			

			file write `knot' "</style>" _n(4)
			
			
			 
		
			
			
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

