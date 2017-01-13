# MarkDoc : a general-purpose literate programming package for Stata

<a href="http://haghish.com/markdoc"><img src="./Resources/images/MD150.png" align="left" width="140" hspace="10" vspace="6"></a>

**MarkDoc** is a general-purpose literate programming package for Stata. **MarkDoc** is very simple and intuitive to use, yet a powerful software for creating dynamic documents interactively in a variety of formats such as *sthlp*, *pdf*, *docx*, *tex*, *html*, *odt*, *epub*, and *markdown*. The software has a considerable focus on making literate programming easy-to-learn and practice for newbies. Therefore, it can be taught to undergraduate students in introductory courses to document code and practice statistical reporting. [**Continue to MarkDoc documentation**...](https://github.com/haghish/MarkDoc/wiki)

## Resources

* [Homepage](http://haghish.com/markdoc)
* [Journal Article](http://www.stata-journal.com/article.html?article=pr0064)
* [Manual](https://github.com/haghish/MarkDoc/wiki)
* [Release Notes](https://github.com/haghish/MarkDoc/releases)
* [Examples](https://github.com/haghish/MarkDoc/tree/master/Examples)
* [Torture tests](https://github.com/haghish/MarkDoc/tree/master/Torture_test)

Installing
----------

__MarkDoc__ requires a few other Stata packages. The [__`github package`__](https://github.com/haghish/github) can be used to install __MarkDoc__ and all of its dependencies as shown below:

```js
github install haghish/markdoc
```

 

<!--
The major releases of __MarkDoc__ are also hosted on SSC server. However, installing from SSC is not recommended because the SSC package is only updated occasionly on SSC. 

```js
ssc install markdoc
```
-->



MarkDoc also requires 3 third-party software, which are:

- [__Pandoc__](http://pandoc.org/installing.html)
- [__wkhtmltopdf__](http://wkhtmltopdf.org/downloads.html)
- [__pdfLaTeX__](https://www.latex-project.org/get/)

The __pdfLaTeX__ is optional, but required for generating PDF slides and typesetting documents written in LaTeX. 


Dialog box
----------

<center>
<a href="https://github.com/haghish/MarkDoc/wiki/GUI"><img src="https://raw.githubusercontent.com/wiki/haghish/MarkDoc/images/gui_markdoc.png"  width="300" hspace="10" vspace="6"></a>
</center>

To further facilitate using __MarkDoc__ in classrooms, a dialog box was written for Stata, which also shows the options and features of MarkDoc. The dialog box supports all three engines of MarkDOc for creating 
_dynamic document_, _dynamic presentation slides_, and _package vignette (e.g. Stata help files, package manual, etc)_. 

To use the dialog box, type:

    db markdoc


Author
------
  **E. F. Haghish**    
  Center for Medical Biometry and Medical Informatics    
  University of Freiburg, Germany       
  _and_   
  Department of Mathematics and Computer Science   
  Univesity of Southern Denmark, Odense, Denmark    

  _haghish@imbi.uni-freiburg.de_  
  _http://www.haghish.com/markdoc_  
  _[@Haghish](https://twitter.com/Haghish)_   
  
  
  
 
