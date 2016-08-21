qui log using example, replace

/***
Use a single "\$" sign for writing inline mathematical notations. For example, 
$f(x)=\sum_{n=0}^\infty\frac{f^{(n)}(a)}{n!}(x-a)^n$ would be rendered inline 
with the text paragraph. Use double dollar signs "$$" for placing the notations 
on a separate lines:

$$Y_i = \beta_0 + \beta_1 X_i + \epsilon_i$$


1. Since the notations appear in comments, they will not be interpreted by 
Stata as global macros. 

2. Place a backslash before the "\$" if you are using them in the document, but 
not for rendering mathematical notations. The backslash will not appear in the 
dynamic document. 

3. You can also write dynamic mathematical notations using the __`txt`__ command. 
***/

local a = 10
txt "$$ \beta_1 = `a' $$"

/***
__Note__: when you write inline mathematical notations, there should be __NO SPACE__ 
between the dollar sign and the notation. However, if you are placing your 
notations on a separate line, 
***/

qui log c

local title `"title("Testing Mathematical Notations in MarkDoc")"'
local author `"author("E. F. Haghish")"'

markdoc example, export(html) replace `title' `author' date 
markdoc example, export(docx) replace `title' `author' date
markdoc example, export(odt) replace  `title' `author' date
markdoc example, export(tex) replace texmaster  `title' `author' date
