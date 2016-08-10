
// -----------------------------------------------------------------------------
// Test Header
// =============================================================================
cap erase myprogram.ado
copy ./Torture_test/sthlp/myprogram.do myprogram.ado, replace
markdoc myprogram.ado, replace export(sthlp) date

/*template(empty)  title("myprogram")		///
summary("a module for literate programming") date author("me") aff("you") add("SHSD")

