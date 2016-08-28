
qui log using 0, replace

/***
Creating dynamic tables using the `txt` command
===============================================

When you use the `tbl` command for creating a dynamic table, you __MUST__ add an 
empty line below the table. Otherwise, the next chunk of text will be appended to 
the table, causing the table to loos its structure. 

### Example:

In the example below, note that there is an empty line between the last line of the 
table and the ending sign:

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3

***/


//OFF
local l1 Cat
local l2 Dog
local l3 Soccer
local l4 Basketball
local l5 Apple 
local l6 Orange
//ON

txt 										    ///
"| __Animals__ | __Sports__ | __Fruits__ |"  _n ///
"|-------------|------------|------------|"  _n ///
"| `l1'        | `l3'       | `l5'       |"  _n ///
"| `l2'        | `l4'       | `l6'       |"  _n



txt 							///
"Animals | Sports | Fruits " _n ///
"---- | ---- | ---- "        _n ///
"`l1' | `l3' | `l5' "        _n ///
"`l2' | `l4' | `l6' "        _n 



qui log c
markdoc 0, expor(pdf) replace 
