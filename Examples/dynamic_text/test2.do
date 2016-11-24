

sysuse auto, clear
summarize foreign 
scalar c = "Dynamic" 
local min = `r(min)'
scalar max = r(max)

/***
###<!c!> text

The documentation can include numeric and string macros and scalars. For example, 
the values of the `foreign` variable range between <!`min'!> to <!max!>. 
***/


