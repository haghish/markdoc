// this document produces the dynamic document passively, because a log-file is 
// used to generate the PDF file, instead of a do-file!



qui log using summary, replace

/***

Notes
--------

Here are a few important notes

1. As I noted, I have a book about `markdoc` that is nearly finished. I will 
send the PDF of the book to Dennis and kindly ask him to put send it to all 
of participants of the course. The book is very detailed and has many examples, 
and giving it to you is the least I can do to appologize from those few who 
had issues with installing the software on their computer and could not fully  
benefit from the course. I am certain that the book will provide much more  
details as well as examples about MarkDoc and will get everyone going. 

2. `markdoc` has an option named `noisily`. If you are using the GUI, make sure 
the box that says `Execute MarkDoc noisily` is not checked. If you check this
box, your report will be very noisy with information you did not ask for, 
because this option is for debugging. I remember some people asked me why they 
get extra information while others do not...

3. On Mac and Linux, the file path is specified with slash. On Microsoft Windows,
with backslash. Therefore, anyone with Microsoft Windows who could not execute 
my example of `markdoc ./filename, ...` hat to actually type 
`markdoc .\filename, ...` on Microsoft Windows. This was so obvious, yet at the 
time of the presentation it didn't occure to me.


Summary of Workshop
===================

In the workshop, we covered multiple topics regarding `markdoc` package. Most 
notably, we learned about:

1. Markdown markup language. We also practiced the syntax at John Gruber's 
website which was <https://daringfireball.net/projects/markdown/dingus>. 

2. We talked about writing dynamic text and adding figures in the document 
automatically. If you would like to know more about the `txt` and `img` commands, 
type:
 
     help txt
     help img

3. We also talked about the `tbl` command for building and styling dynamic tables 
that can be exported to any document format. To learn more about the `tbl` command 
type:

     help tbl

4. We also talked about using `markdoc` for generating presentation slides. 

5. Most of the participants were interested in using `markdoc` for writing dynamic 
tables. Therefore, I have prepared additional examples for writing and styling 
dynamic tables. These examples will be available on markdoc's manual website soon. 
<https://github.com/haghish/markdoc/wiki/tbl>

Resources
---------


There are several resources that you can practice `markdoc`  package. These 
resources are:

- [markdoc's journal article](https://www.stata-journal.com/article.html?article=pr0064)
- [markdoc's GitHub Wiki](https://github.com/haghish/markdoc/wiki)
- [markdoc's vignette](https://github.com/haghish/markdoc/raw/master/Help/Help.pdf)

---


If you have any question regarding `markdoc`, please kindly post it on 
<https://www.statalist.org/>, there is a rather big community of markdoc users 
there and I also regularly respond to the questions on this website. 
You can also reach me via email <haghish@med.uni-goettingen.de> 

***/


qui log c
markdoc summary.smcl, export(pdf) replace style("formal")         ///
        title("Summary of the workshop") author("E. F. Haghish")  ///
        affiliation("University of Göttingen")                    ///
		address("haghish@med.uni-goettingen.de")
