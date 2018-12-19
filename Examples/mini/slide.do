/***
class: center, middle

Title
=====

subtitle
--------

---

# Title

---

# Agenda

1. Introduction
2. Deep-dive
3. ...

---



***/

sysuse auto, clear
summarize price mpg

/***
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