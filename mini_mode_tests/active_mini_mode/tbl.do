qui log using tbl, replace

sysuse auto, clear

//OFF
foreach var of varlist weight price mpg {
	summarize `var'
	local `var'_mean : display %9.2f r(mean)
	local `var'_sd   : display %9.2f r(sd)
}
//ON

tbl ("Variable Name", "Mean", "SD" \              ///
     "__weight__", `weight_mean', `weight_sd' \   ///
     "__price__", `price_mean', `price_sd' \      ///
	 "__mpg__", `mpg_mean', `mpg_sd')             ///
    , title("Table 1. Summary of __weight__, __price__, and __mpg__ variables")
	
qui log c
markdoc tbl, mini export(docx) replace 
