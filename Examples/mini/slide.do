/***


Title
=====

subtitle
--------

---

# Tables

Your documents, slides, and help files can include tables!

| Tables          | style of table       | Cool    |
| :-------------- |:-------------------- | :------ |
| col 3 is        | right-aligned        | $1600   |
| col 2 is        | centered             |   $12   |



You can also create your tables online. The website mentioned below produces 
the format that is "ideal" for MarkDoc

| __Website__        | __URL__                                         |
|--------------------|-------------------------------------------------|
| _Tables Generator_ | https://www.tablesgenerator.com/markdown_tables |

---

# Agenda

1. Introduction
2. Deep-dive
3. ...

or unordered list:

- Introduction
- Deep-dive
- ...


---



***/

sysuse auto, clear
summarize price mpg

/***

This will start an __asis__ mode, which remember, it does not recognize "tabs". 
So until Stata fixes this problem, style your code with spaces rather than tabs.

~~~
    
if main.r2.iseq(1) {
    call main.master.enable
}
else {
    call main.master.disable
}	
~~~


---

# Introduction
***/

reg price mpg

/***

---

### Listing observations

***/

list in 1/5
