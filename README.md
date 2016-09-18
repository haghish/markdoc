# MarkDoc : a general-purpose literate programming package for Stata

<a href="http://haghish.com/markdoc"><img src="./Resources/images/MD150.png" align="left" width="140" hspace="10" vspace="6"></a>

**MarkDoc** is a general-purpose literate programming package for Stata. **MarkDoc** is very simple and intuitive to use, yet a powerful software for creating dynamic documents interactively in a variety of formats such as *sthlp*, *pdf*, *docx*, *tex*, *html*, *odt*, *epub*, and *markdown*. The software has a considerable focus on making literate programming easy-to-learn and practice for newbies. Therefore, it can be taught to undergraduate students in introductory courses to document code and practice statistical reporting. [**Continue to MarkDoc documentation**...](https://github.com/haghish/MarkDoc/wiki)

## Resources

* [Homepage](http://haghish.com/markdoc)
* [Journal Article](http://haghish.com/resources/pdf/Haghish_MarkDoc.pdf)
* [Manual](https://github.com/haghish/MarkDoc/wiki)
* [Release Notes](https://github.com/haghish/MarkDoc/releases)
* [Examples](https://github.com/haghish/MarkDoc/tree/master/Examples)
* [Torture tests](https://github.com/haghish/MarkDoc/tree/master/Torture_test)

Installing
----------

__MarkDoc__ receives constant updates on GitHub and users are recommended to follow the updates from GitHub. To install __MarkDoc__ from GitHub on Stata, type:

```js
net install markdoc, replace  from("https://raw.githubusercontent.com/haghish/markdoc/master/")
```

<!--
The major releases of __MarkDoc__ are also hosted on SSC server. However, installing from SSC is not recommended because the SSC package is only updated occasionly on SSC. 

```js
ssc install markdoc
```
-->

__MarkDoc__ requires two other packages for highlighting the syntax of Stata commands in the documents and creating dynamic tables which can be installed from SSC as well:

```js
ssc install weaver
ssc install statax
```

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
  
  
  
 
