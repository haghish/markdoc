
clear
sysuse auto

/***
Dealining with the returned values
-----------------------------------

Use the `return list` command to list the returned values. Most of the 
estimations are stored in a matrix. Therefore, we copy the matrix 
and use it to extract the values dynamically. 
***/

regress price mpg foreign

/***
return the rclass objects
***/

return list
mat A = r(table)
mat list A

/***
Stata returns the estimations in the __eclass__ 
***/
ereturn list
mat B = e(b)
mat list B

/***
Creating the dynamic table
==========================

In the workshop the following question came up. How can we use the returned values 
from Stata and create a dynamic table. 

We are trying to create a __dynamic table__ that includes the variables and 
$\beta_0$. We need to get the stored values from returned matrices in Stata in the 
following procedure:

1. save the Stata matrix with a new name
2. extract the scalars of interest
3. get the name of the columns of the matrix
	1. parse the names of each column
	2. change the /_const name to $\beta_0$ 
4. use the __`tbl`__ command to generate the dynamic table. 

***/


scalar scal1 = A[1,1]
scalar scal2 = A[1,2]
scalar scal3 = A[1,3] 

local colnms: coln A
di "`colnms'"

tokenize "`colnms'"
display "`1'  `2'  `3'"

local n = 1
while "`1'" != "" {
	if "`1'" == "_cons" {
		local m`n' "$\\beta_0$"
	}
	else {
		local m`n' `1'
	}	
	local n = `n' + 1
	macro shift
}

display "`m1' `m2' `m3'"



tbl ("`m1'", "`m2'", "`m3'" \ scal1 , scal2, scal3 )
