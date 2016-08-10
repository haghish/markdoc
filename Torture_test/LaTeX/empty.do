// -----------------------------------------------------------------------------
// empty template
// =============================================================================
qui log using example, replace smcl
qui log c 
markdoc example, replace markup(latex) exp(tex) //texmaster

qui log using example2, replace smcl
qui log c 
markdoc example2, replace markup(latex) exp(tex) texmaster
