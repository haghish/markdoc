//!!!CHANGE THIS PATH ON YOUR COMPUTER!!!
cd "/Users/haghish/Documents/Packages/markdoc/Examples/Workshops/2018/passive"




set linesize 80 
capture quietly log close
qui log using example, replace

/*
THIS IS A COMMENT AND WILL NOT BE IN THE DYNAMIC DOCUMENT
*/

/***

Introduction to MarkDoc (heading 1) 
=================================== 

__MarkDoc__ package provides a convenient way to write dynamic document 
within Stata dofile editor. Before starting, remember that there are a few 
things that ___you must absolutely avoid___ while using MarkDoc. 

1. Use only one markup language. While you are writing with _Markdown_ you 
may also use _HTML_ tags, but __avoid__ _LaTeX_ in combination of _HTML_ or 
_Markdown_.

2. Only use English letters. Any unsual character (Chinese, French, or 
special characters) should be avoided. 

3. Please make sure you that you have the __permission to write and remove 
files__ in your current working directory. Especially if you are a 
__Microsoft Windows__ user. Ideally, you should be the adminster of 
your system or at least, you should be able to run Stata as an adminstrator 
or superuser. Also pay attension to your current working directory.

Using Markdown (heading 2)
-------------------------- 

Writing with _Markdown_ syntax allows you to add text and graphs to
_smcl_ logfile and export it to a editable document format. I will 
demonstrate the process by using the __auto.dta__ dataset.

###Get started with MarkDoc (heading 3)

I will open the dataset, list a few observations, and export a graph.
Then I will export the log file to _HTML_ format. 
***/


quietly sysuse auto, clear
list in 1/5
histogram price
graph export graph.png, replace width(350)

/***
Adding a graph using Markdown
-----------------------------

In order to add a graph using Markdown, I export the graph in PNG format. 
You can explain the graph in the brackets and define the file path in 
parentheses using Markdown syntax. Note that Markdown format cannot resize the 
figure and it will include it at its full size. Therefore, when you write with 
Markdown you should resize the graphs. Of course, if you write with _LaTeX_ or 
_HTML_ you will be able to do anything you wish! But _Markdown_ is convertable 
to any format and thus is the prefered markup language for writing dynamic 
documents. In addition, it is a very minimalistic language. And perhaps that's 
what makes it so good, because it does not include numerous rules and tags to 
learn, compared to _HTML_ and _LaTeX_. It's simple, easy to learn, and appealing 
to use. 

![](./graph.png)
 
 
Writing Dynamic Text 
--------------------
 
The __txt__ command can be used to write dynamic text in MarkDoc. 
To do so, put the value that you want to print in a Macro and then 
explain it using the __txt__ command. Or instead, I use the stored values 
that Stata returns after particular commands by typinc __return list__. 

In the example below, I use the summarize command, and print the r(N), r(mean), 
r(sd), r(min), and r(max) which are returned after the __summarize__ command. 
***/

summarize price 

//OFF
return list 
//ON

txt The dataset used for this analysis includes `r(N)' observations for 		///
the __price__ variable, with mean of `r(mean)' and SD of `r(sd)'. The 			///
price of cars' ranged from `r(min)' to `r(max)'.

//And thi is how a regression analysis looks like in the file.
regress price mpg

/***
[You will find more information in this regard on my website](http://haghish.com/). 
You can also [Follow The Package Updates On TWITTER!](http://twitter.com/Haghish)


E. F. Haghish   
Center for Medical Biometry and Medical Informatics   
University of Freiburg, Germany   
_haghish@imbi.uni-freiburg.de_

***/

qui log c 

markdoc example, replace export(html) statax linesize(120)				//Running MarkDoc command
