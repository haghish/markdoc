
qui log using 0, replace


/***

| $\beta$     | __Sports__ | __Fruits__ |
|-------------|------------|------------|
| num1        | soccer     | banana     |
| num2        | basketball | apple      |

***/

tbl ({l}"$$\\beta$$", {c}"Centered", {r}"Right" \ c(os),  c(machine_type), c(username))

/***
---

Using inline mathematical notations
-----------------------------------
***/


tbl ("$\\beta$", "$\\epsilon$" \ 3.5, 1.3 \ 2.3 , 1.23)


tbl ("$\\beta$", "$\\epsilon$" \ "$\\sum$", "$\\prod$")


tbl ("$\\beta$", "$95\\%$ Confidence Interval" \ "values...", "values...")


qui log c
markdoc 0, expor(html) replace 
