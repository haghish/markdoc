//cap prog drop markdoc
cap erase example.pdf

   
qui log using example, replace

             /*** 
			 
			 
---
title: "Habits"
output:
  beamer_presentation:
	
	
    includes:
      in_header: body.tex
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
        
             ***/
        
        

        
        sysuse auto, clear       
        histogram price
        graph export graph.png,  width(400) replace
		summarize price
		
		txt "# Regression"
        regress price mpg
		

		
		txt "#missings"
		misstable summarize
		
		
		txt "#sum"
		misstable summarize
        
	/*** 
	Adding image in a slide 
	======================= 
    
	![Histogram of the price variable](./graph.png)

	***/
        
qui log c

markdoc example, replace export(slide)  /*printer("/usr/texbin/pdflatex")*/ nonumber /*template("body.tex")*/

exit
markdoc example, replace export()
		
