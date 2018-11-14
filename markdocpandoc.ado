/*

					   Developed by E. F. Haghish (2014)
			  Center for Medical Biometry and Medical Informatics
						University of Freiburg, Germany
						
						  haghish@imbi.uni-freiburg.de
								   
                       * MarkDoc comes with no warranty *

	
	
	MarkDoc Package
	===============
	
	This ado file is a part of MarkDoc package and is called within 
	markdoccheck.ado, the program that checks if Pandoc is installed on the 
	system correctly. If not, the current program is run to install Pandoc
	from http://www.haghish.com/

*/
	

	program define markdocpandoc
	syntax [, Test]
	version 11
	
	********************************************************************
	*MICROSOFT WINDOWS 32BIT & 64BIT
	********************************************************************
	if "`c(os)'" == "Windows" {
			
			*save the current working directory
			qui local location "`c(pwd)'"
		
			*CREATE WEAVER DIRECTORY
			qui cd "`c(sysdir_plus)'"
			cap qui mkdir Weaver
			qui cd Weaver
			local d : pwd
			
			di as txt "{hline}" _n
			di as txt ///
			" ____  _                      __        __    _ _   " _n ///
			"|  _ \| | ___  __ _ ___  ___  \ \      / /_ _(_) |_ " _n ///
			"| |_) | |/ _ \/ _` / __|/ _ \  \ \ /\ / / _` | | __|" _n ///
			"|  __/| |  __/ (_| \__ \  __/   \ V  V / (_| | | |_ " _n ///
			"|_|   |_|\___|\__,_|___/\___|    \_/\_/ \__,_|_|\__|" _n 
			
			di as txt "{p}{ul: {bf:Installing Pandoc Software}}" _n
			
			di as txt "{p}Required software packages are getting installed " ///
			"in {browse `d'} directory. make sure you are " ///
			"connected to internet. This may take a while. Pay attention to " ///
			"the download bar of Stata below and when the download is done, " ///
			"rerun MarkDoc command."_n
			
			//If the test option is not specified, print the test text
			if `"`test'"'  == "" {
					di as txt "{p}{ul: {bf:Test MarkDoc!}}" _n
			
					di as txt "{p}When the installation is over (look at the download bar " ///
					"at the buttom of Stata), you can test if Pandoc is installed on your " ///
					"machine correctly. The test will run an example do file from " ///
					`"{browse "http://www.haghish.com/":http://haghish.com/}  to ensure "' ///
					"MarkDoc is running smoothely on your machine." ///
					" {stata markdoc, test:{bf:{ul:Click Here To Test MarkDoc When The Download Is Over!}}} " _n
					}

			di as txt "{hline}" _n(4)
			
			
			
			*DOWNLOAD PANDOC AND UNZIP IT
			cap qui copy "http://www.haghish.com/software/pandoc_1.13.1.txt" ///
			"pandoc_1.13.1.txt", replace public 
			
			cap qui copy "http://www.haghish.com/software/Win/Pandoc.zip" ///
			"Pandoc.zip", replace public 
			
			cap qui copy "http://www.haghish.com/software/supplementary.zip" ///
			"supplementary.zip", replace public 
			
			cap qui unzipfile Pandoc, replace
			cap qui erase Pandoc.zip
			
			*GETTING THE PATH TO PANDOC
			cap qui cd Pandoc
			local d : pwd
			global pandoc : di "`d'\pandoc.exe"
			
			//Go back to the Working Directory
			qui cd "`location'"
		
			}
		
		
	********************************************************************
	*MAC 64BIT
	********************************************************************
	if "`c(os)'" == "MacOSX" {
			
			*save the current working directory
			qui local location "`c(pwd)'"
		
			*CREATE WEAVER DIRECTORY
			qui cd "`c(sysdir_plus)'"
			cap qui mkdir Weaver
			qui cd Weaver
			local d : pwd
			
			di as txt "{hline}" _n
			di as txt ///
			" ____  _                      __        __    _ _   " _n ///
			"|  _ \| | ___  __ _ ___  ___  \ \      / /_ _(_) |_ " _n ///
			"| |_) | |/ _ \/ _` / __|/ _ \  \ \ /\ / / _` | | __|" _n ///
			"|  __/| |  __/ (_| \__ \  __/   \ V  V / (_| | | |_ " _n ///
			"|_|   |_|\___|\__,_|___/\___|    \_/\_/ \__,_|_|\__|" _n 
			
			di as txt "{p}{ul: {bf:Installing Pandoc Software}}" _n
			
			di as txt "{p}Required software packages are getting installed " ///
			"in {browse `d'} directory. make sure you are " ///
			"connected to internet. This may take a while. Pay attention to " ///
			"the download bar of Stata below and when the download is done, " ///
			"rerun MarkDoc command."_n
			
			//If the test option is not specified, print the test text
			if `"`test'"'  == "" {
					di as txt "{p}{ul: {bf:Test MarkDoc!}}" _n
			
					di as txt "{p}When the installation is over (look at the download bar " ///
					"at the buttom of Stata), you can test if Pandoc is installed on your " ///
					"machine correctly. The test will run an example do file from " ///
					`"{browse "http://www.haghish.com/":http://haghish.com/}  to ensure "' ///
					"MarkDoc is running smoothely on your machine." ///
					" {stata markdoc, test:{bf:{ul:Click Here To Test MarkDoc When The Download Is Over!}}} " _n
					}

			di as txt "{hline}" _n(4)
			
			*DOWNLOAD PANDOC AND UNZIP IT
			cap qui copy "http://www.haghish.com/software/pandoc_1.13.1.txt" ///
			"pandoc_1.13.1.txt", replace public 
			cap qui copy "http://www.haghish.com/software/Mac/Pandoc.zip" ///
			"Pandoc.zip", replace public 
			
			cap qui copy "http://www.haghish.com/software/supplementary.zip" ///
			"supplementary.zip", replace public 
			
			cap qui unzipfile Pandoc, replace
			cap qui erase Pandoc.zip

			
			*GETTING THE PATH TO PANDOC
			cap qui cd Pandoc
			local d : pwd
			global pandoc : di "`d'/pandoc"
			
			*CHANGE CHMOD 
			cap qui shell chmod +x "$pandoc"
			
			//Go back to the Working Directory
			qui cd "`location'"
			
			}
		
		
	********************************************************************
	*UNIX 32BIT & 64BIT
	********************************************************************
	if "`c(os)'"=="Unix" {
			
			*save the current working directory
			qui local location "`c(pwd)'"
		
			*CREATE WEAVER DIRECTORY
			qui cd "`c(sysdir_plus)'"
			cap qui mkdir Weaver
			qui cd Weaver
			local d : pwd
			
			
			di as txt "{hline}" _n
			di as txt ///
			" ____  _                      __        __    _ _   " _n ///
			"|  _ \| | ___  __ _ ___  ___  \ \      / /_ _(_) |_ " _n ///
			"| |_) | |/ _ \/ _` / __|/ _ \  \ \ /\ / / _` | | __|" _n ///
			"|  __/| |  __/ (_| \__ \  __/   \ V  V / (_| | | |_ " _n ///
			"|_|   |_|\___|\__,_|___/\___|    \_/\_/ \__,_|_|\__|" _n 
			
			di as txt "{p}{ul: {bf:Installing Pandoc Software}}" _n
			
			di as txt "{p}Required software packages are getting installed " ///
			"in {browse `d'} directory. make sure you are " ///
			"connected to internet. This may take a while. Pay attention to " ///
			"the download bar of Stata below and when the download is done, " ///
			"rerun MarkDoc command."_n
			
			//If the test option is not specified, print the test text
			if `"`test'"'  == "" {
					di as txt "{p}{ul: {bf:Test MarkDoc!}}" _n
			
					di as txt "{p}When the installation is over (look at the download bar " ///
					"at the buttom of Stata), you can test if Pandoc is installed on your " ///
					"machine correctly. The test will run an example do file from " ///
					`"{browse "http://www.haghish.com/":http://haghish.com/}  to ensure "' ///
					"MarkDoc is running smoothely on your machine." ///
					" {stata markdoc, test:{bf:{ul:Click Here To Test MarkDoc When The Download Is Over!}}} " _n
					}

			di as txt "{hline}" _n(4)
		
			*DOWNLOAD PANDOC AND UNZIP IT
			cap qui copy "http://www.haghish.com/software/pandoc_1.13.1.txt" ///
			"pandoc_1.13.1.txt", replace public 
			
			if "`c(bit)'" == "32" {
					cap qui copy "http://www.haghish.com/software/Unix/32bit/Pandoc.zip" ///
					"Pandoc.zip", replace public 
					}
			
			if "`c(bit)'" == "64" {
					cap qui copy "http://www.haghish.com/software/Unix/64bit/Pandoc.zip" ///
					"Pandoc.zip", replace public 
					}
					
			
			
			cap qui unzipfile Pandoc, replace
			cap qui erase Pandoc.zip
		
			*GETTING THE PATH TO PANDOC
			cap qui cd Pandoc
			local d : pwd
			global pandoc : di "`d'/pandoc"
		
			*CHANGE CHMOD 
			cap qui shell chmod +x "$pandoc"
		
			//Go back to the Working Directory
			qui cd "`location'"		
			}
	
	end
