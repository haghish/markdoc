`rundoc` command
================

The [`markdoc`](https://github.com/haghish/MarkDoc) command takes a
`SMCL` log file to create a dynamic document or presentation slides.
This procedure requires the user to create a log file and convert it to
a dynamic document.

The **`rundoc`** command, is simply a wrapper for MarkDoc to simplifies
typesettinf dynamic documents directly from a Stata do-file, without
requiring the do-file to include a log file.

The syntax for writing comments remains identical to
[`markdoc`](https://github.com/haghish/MarkDoc) command. This command
should make executing dynamic documents much simpler!

Features
--------

### executing Stata commands

The **`rundoc`** command preserves all of the features of `markdoc`,
because it is simply a wrapper program. Therefore, it preserves all of
the features of `markdoc` such as executing Stata commands and syntax
highlighting of the Stata commands using
[`statax`](https://github.com/haghish/statax) package:

          .  display "Hello MarkDoc"
          Hello MarkDoc
          
          . sysuse auto, clear
          (1978 Automobile Data)
          
          . summarize 
          
              Variable |        Obs        Mean    Std. Dev.       Min        Max
          -------------+---------------------------------------------------------
                  make |          0
                 price |         74    6165.257    2949.496       3291      15906
                   mpg |         74     21.2973    5.785503         12         41
                 rep78 |         69    3.405797    .9899323          1          5
              headroom |         74    2.993243    .8459948        1.5          5
          -------------+---------------------------------------------------------
                 trunk |         74    13.75676    4.277404          5         23
                weight |         74    3019.459    777.1936       1760       4840
                length |         74    187.9324    22.26634        142        233
                  turn |         74    39.64865    4.399354         31         51
          displacement |         74    197.2973    91.83722         79        425
          -------------+---------------------------------------------------------
            gear_ratio |         74    3.014865    .4562871       2.19       3.89
               foreign |         74    .2972973    .4601885          0          1
          
          

### Writing mathematical notations

Mathematical notations are supported in PDF, HTML, Docx, ODT
(OpenOffice), and LaTeX:

$$ Y = \beta_{0} + \beta_{1}x_{1} + \epsilon $$
