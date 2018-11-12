cd "/Users/haghish/Documents/Packages/markdoc/Examples/Workshops/2018"

/***
Workshop Examples 
===============================

This document includes some of the examples of the workshop. I have organized 
them in separate do files and the dynamic document will include all of the 
examples. 

Help
----

If you need help about working with __MarkDoc__ package, probably the 
best place to begin is the 
[MarkDoc GitHub Wiki](https://github.com/haghish/MarkDoc/wiki), which is the 
package manual. If you have questions, post them on <www.statalist.org> and I 
get back to you shortly. 


> NOTE that all of the examples below are being executed in active mode.

***/

// navigate to the directory where the do-files are located
cd dofiles


// the main example of the package
/**/ markdoc "./example.do", export(html) replace

// mathematics notation
/**/ markdoc "./math.do", export(html) replace

// load the data set
/**/ markdoc "./prepare.do", export(html) replace

// descriptive stats
/**/ markdoc "./descriptive.do", export(html) replace

// Regression
/**/ markdoc "./regression.do", export(html) replace


