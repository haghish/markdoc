
cap erase example.html

cap qui log c
qui log using example, smcl replace
/***

      
# HTML Slides
      
- portable
- light
- fit many devices

***/

sysuse auto
summarize price
regress price mpg

forvalues n = 1/5 {
	local m  12.3
	global sm 23
}

/***     
# In the evening
      
- Eat spaghetti
- Drink wine
      
# Conclusion
      
- And the answer is...
- $f(x)=\sum_{n=0}^\infty\frac{f^{(n)}(a)}{n!}(x-a)^n$  
***/	  
qui log c

*cap prog drop markdoc

cap qui log c
qui log using example, smcl replace
/***

      
# HTML Slides
      
- portable
- light
- fit many devices

***/

sysuse auto
summarize price
regress price mpg

forvalues n = 1/5 {
	local m  12.3
	global sm 23
}

/***     
# In the evening
      
- Eat spaghetti
- Drink wine
      
# Conclusion
      
- And the answer is...
- $f(x)=\sum_{n=0}^\infty\frac{f^{(n)}(a)}{n!}(x-a)^n$  
***/	  
qui log c

*cap prog drop markdoc


markdoc example.smcl, exp(dzslide) replace


