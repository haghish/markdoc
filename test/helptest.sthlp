{smcl}
{right:version 1.0.0}
{title:Title}

{phang}
{bf:myprogram }{hline 2} A new module for to print text. This description can include  multiple lines, but not several paragraphs. You may write the title section  in multiple lines. {help MarkDoc} will connect the lines to create only a  single paragraph. If you{c 39}d like to describe the package more, create a  description section below this header.


{title:Author}

{p 4 4 2}
E. F. Haghish{break}
University of Freiburg{break}
haghish@imbi.uni-freiburg.de{break}
{browse "http://www.haghish.com/markdoc"}{break}


{title:Syntax}

{p 8 16 2}
{opt myprogram} [{it:anything}] [, {opt b:old} {opt i:talic}] 

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt b:old}}prints bold text{p_end}
{synopt :{opt i:talic}}prints italic text{p_end}
{synoptline}



{p}
Typically, the text paragraphs in Stata help files begin with an indention,  which makes the help file easier to read (and that{c 39}s important). To do so,  place a {bf:{c -(}p 4 4 2{c )-}} directive above the line to indent the text paragraph and you{c 39}re good to go.

{p}
this is a text paragraph that is processing {bf:Markdown}, {it:italic text} or  {ul:underscored text}. The only thing left is the link! but how far can this  {bf:text styling go}? I mean how far does the  rabit whole go? do you have any idea?


    {hline}

{p}
this is a text paragraph that is processing {bf:Markdown}, {it:italic text} or  {ul:underscored text}. The only thing left is the link! but how far can this  {bf:text styling go}? I mean how far does the  rabit whole go? do you have any idea?


{p 4 4 2}
this is a text paragraph that is processing {bf:Markdown}, {it:italic text} or  {ul:underscored text}. The only thing left is the link! but how far can this  {bf:text styling go}? I mean how far does the  rabit whole go? do you have any idea?



{title:Another heading }

{p 4 4 2}	
Typically, the text paragraphs in Stata help files begin with an indention, 
which makes the help file easier to read (and that's important). To do so, 
place a {bf:{c -(}p 4 4 2{c )-}} directive above the line to indent the text
paragraph and you're good to go. 


{title:Example}

    print {bf:bold} text
        . myprogram "print this text in bold", bold

    print {it:italic} text
        . myprogram "print this text in italic", i

{title:Dynamic Graph}

{c TLC}{hline 17}{c TRC}       {c TLC}{hline 8}{c TRC}           {c TLC}{hline 20}{c TRC}
{c |} markdown source {c |}{hline 6}>{c |} mdddia {c |}{hline 5}-{c +}{hline 3}>{c |} processed markdown {c |}
{c TLC}{hline 17}{c TRC}       {c TLC}{hline 8}{c TRC}      {c |}    {c TLC}{hline 20}{c TRC}
                              {c |}           {c TLC}{hline 3}>{c |} image files        {c |}
                    {c TLC}{hline 18}{c TRC}       {c TLC}{hline 20}{c TRC}
                    {c |} diagram creation {c |}
                    {c TLC}{hline 18}{c TRC}
                    {c |} ditaa/dot/rdfdot {c |}
                    {c TLC}{hline 18}{c TRC}
					

{title:      Source |       SS           df       MS      Number of obs   =        74}
       Model |   139449474         1   139449474   Prob > F        =    0.0000

{title:    Residual |   495615923        72  6883554.48   R-squared       =    0.2196}
       Total |   635065396        73  8699525.97   Root MSE        =    2623.7

       price |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
         mpg |  -238.8943   53.07669    -4.50   0.000    -344.7008   -133.0879

{title:       _cons |   11253.06   1170.813     9.61   0.000     8919.088    13587.03}
					


*cap prog drop markdoc
markdoc test/helptest.ado, replace export(sthlp) 
