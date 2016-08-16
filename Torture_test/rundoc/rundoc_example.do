/***
`rundoc` command
================

The [`markdoc`](https://github.com/haghish/MarkDoc) command takes a `SMCL` log file 
to create a dynamic document or presentation slides. This procedure requires 
the user to create a log file and convert it to a dynamic document. 

The __`rundoc`__ command, is simply a wrapper for MarkDoc to simplifies 
typesettinf dynamic documents directly from a Stata do-file, without requiring 
the do-file to include a log file. 

The syntax for writing comments remains identical to 
[`markdoc`](https://github.com/haghish/MarkDoc) command. This command should make 
executing dynamic documents much simpler!

Features
--------

### executing Stata commands

The __`rundoc`__ command preserves all of the features of `markdoc`, because it 
is simply a wrapper program. Therefore, it preserves all of the features of `markdoc` such 
as executing Stata commands and syntax highlighting of the Stata commands using 
[`statax`](https://github.com/haghish/statax) package:
***/

display "Hello MarkDoc"
sysuse auto, clear
summarize 

/***
### Writing mathematical notations 

Mathematical notations are supported in PDF, HTML, Docx, ODT (OpenOffice), and LaTeX: 

$$ Y = \beta_{0} + \beta_{1}x_{1} + \epsilon $$
***/




