/***
MarkDoc can be executed in 2 seperate modes, which are:

1. Active mode, examining a do-file in a fresh environment
2. Passive mode, converting a smcl log-file to a document

Accordingly, I will create 2 sets of examples to examine 
each engine

***/


/***
Active Mode
-----------

Navigate to the active_mini_mode example and execute the 
following commands
***/

// Hello World example
markdoc "hello.do" , export("md") mini replace 
markdoc "hello.do" , export("html") mini replace 
markdoc "hello.do" , export("docx") mini replace 
markdoc "hello.do" , export("pdf") mini replace 
markdoc "hello.do" , export("sthlp") mini replace 

markdoc "test.do" , export("md") mini replace 
markdoc "test.do" , export("html") mini replace 
markdoc "test.do" , export("docx") mini replace 
markdoc "test.do" , export("pdf") mini replace 
markdoc "test.do" , export("sthlp") mini replace 


//go.do
markdoc "go.do" , export("md") mini replace 
markdoc "go.do" , export("html") mini replace 
markdoc "go.do" , export("docx") mini replace 
markdoc "go.do" , export("pdf") mini replace 
markdoc "go.do" , export("sthlp") mini replace //only extracts the documentation

markdoc "new.do" , export("md") mini replace 
markdoc "new.do" , export("html") mini replace 
markdoc "new.do" , export("docx") mini replace 
markdoc "new.do" , export("pdf") mini replace 
markdoc "new.do" , export("sthlp") mini replace //only extracts the documentation

markdoc "test2.do" , export("md") mini replace 
markdoc "test2.do" , export("html") mini replace 
markdoc "test2.do" , export("docx") mini replace 
markdoc "test2.do" , export("pdf") mini replace 
markdoc "test2.do" , export("sthlp") mini replace 

// tests with `txt`, `img`, and `tbl` commands: 
markdoc "full1.do" , export("md") mini replace 
markdoc "full1.do" , export("html") mini replace 
markdoc "full1.do" , export("docx") mini replace 
markdoc "full1.do" , export("pdf") mini replace 
markdoc "full1.do" , export("sthlp") mini replace 
