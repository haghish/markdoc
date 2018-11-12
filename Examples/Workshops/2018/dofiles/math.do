/***
Writing mathematical notations 
==============================

The text paragraph can include mathematical notations. For example, this 
formula $Y_i = \beta_0 + \beta_1 X_i + \epsilon_i$ will be displayed within 
the text paragraph, whereas this next formula will be placed on a separate 
line: $$Y_i = \beta_0 + \beta_1 X_i + \epsilon_i$$
		
***/
		
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
Note that when you write inline mathematical notations, there should be __NO SPACE__ 
between the dollar sign and the notation. However, if you are placing your 
notations on a separate line, there should be no problem. 
***/


