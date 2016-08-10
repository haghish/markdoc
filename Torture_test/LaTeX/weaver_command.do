// -----------------------------------------------------------------------------
// template with a TXT & Textmaster command
// =============================================================================
qui log using example, replace smcl
txt \section{This is a text heading}
if 100 > 12 {
	local m  `n'
}
  qui log c 
markdoc example, replace markup(latex) exp(tex) //nonumber texmaster


qui log using example2, replace smcl
sysuse auto, clear
txt \section{This is a text heading}
qui log c 
markdoc example2, replace markup(latex) exp(tex) texmaster

