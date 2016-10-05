/*

					   Developed by E. F. Haghish (2014)
			  Center for Medical Biometry and Medical Informatics
						University of Freiburg, Germany
						
						  haghish@imbi.uni-freiburg.de
								   
                       * MarkDoc comes with no warranty *

	
	
	MarkDoc Package
	===============
	
	This ado file is a part of MarkDoc package and is called within 
	markdoc.ado. It will connecto to http://haghish.com/ to obtain the latest 
	version of the MarkDoc package and notify the user, if the package is not 
	updated. 
*/


program define markdocversion
	version 11
	
	// make sure that Stata does not repeat this every time
	//if "$thenewestmarkdocversion" == "" {		
		cap qui do "http://www.haghish.com/packages/update.do"
	//}
		
	global markdocversion 3.79
	
	if "$thenewestmarkdocversion" > "$markdocversion" {	
		di _n(2)
		di as txt _n(2) "{hline}"
		
		di "  _   _           _       _                __  " _n ///
		" | | | |_ __   __| | __ _| |_ ___       _  \ \ " _n ///
		" | | | | '_ \ / _` |/ _` | __/ _ \     (_)  | |" _n ///
		" | |_| | |_) | (_| | (_| | ||  __/      _   | |" _n ///
		"  \___/| .__/ \__,_|\__,_|\__\___|     (_)  | |" _n ///
		"       |_|                                 /_/ "  _n ///

		di as text "{p}MarkDoc has a new update available! Click on " 	///
		`"{ul:{bf:{stata "adoupdate markdoc, update":Update MarkDoc Now}}} "' 	///
		"or alternatively type {ul: {bf: adoupdate markdoc, update}} to "		///
		"update the package."
				
		di as text "{p}For more information regarding the new features " 		///
		"of MarkDoc, visit "													///
		`"{browse "http://www.haghish.com/statistics/stata-blog/reproducible-research/markdoc.php":{it:http://www.haghish.com/markdoc}}{smcl}"'	
	}
	
end
