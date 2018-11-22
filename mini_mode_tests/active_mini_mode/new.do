
//OFF
sysuse auto, clear
summarize foreign 
scalar c = "Dynamic" 
local min = `r(min)'
scalar max = r(max)
matrix Mat = (`r(min)', `r(max)')
//ON

/***
###<!c!> text

The 24^th^ observation in the data is `<!make[24]!>` with a `price` of 
<!price[24]!>. The values of the `foreign` variable range between <!`min'!> to 
<!max!>. The same values can also be extracted from matrices, for example, 
<!Mat[1,1]!> and <!Mat[1,2]!>. 
***/


