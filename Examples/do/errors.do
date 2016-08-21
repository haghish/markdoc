
/***
Making the source code really reproducible
==========================================

To make the do-file really reproducible, we have to make sure it does not 
access the data that is already loaded in Stata. Think about it, if you execute 
a do-file on a data that is already loaded and you have been working on it, can 
you ensure that re-executing the do-file creates the same results again? 
you might have done some changes outside of the do-file on the data 
- such as droping a record - which makes the results ireproducible. 

The solution would be to __run the do-file in a cleared workspace__ to ensure 
the do-file does not access the data that is already loaded. __MarkDoc__ can 
take a do-file and execute the code in a cleared workspace and produce the dynamic 
document. This is a very different engine compared to rendering a smcl-log 
to a dynamic document. 

If the do-file return an error, __MarkDoc__ still create the dynamic document 
until the point the error occured. To run this do-file, first load the __auto__ 
dataset in Stata. Then call __`markdoc`__ to produce the dynamic document. You 
should get an error the `no variables defined`, which means your do-file does 
not load the data, although the data are loaded in your Stata. 


***/

display "the next command will be an error"

regress price mpg

display "Thi will not be printed..."
