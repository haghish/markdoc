{smcl}



{title:Title}


{title:subtitle}

{title:}

{title:Tables}

{p 4 4 2}
Your documents, slides, and help files can include tables!

{col 5}Tables          {col 21}style of table       {col 27}Cool    
{space 4}{hline 48}
{col 5}col 3 is        {col 21}right-aligned        {col 27}$1600   
{col 5}col 2 is        {col 21}centered             {col 27}$12   
{space 4}{hline 48}


{p 4 4 2}
You can also create your tables online. The website mentioned below produces 
the format that is "ideal" for MarkDoc

{col 5}{bf:Website}        {col 25}{bf:URL}                                         
{space 4}{hline 69}
{col 5}{it:Tables Generator} {col 25}https://www.tablesgenerator.com/markdown_tables 
{space 4}{hline 69}
{title:}

{title:Agenda}

{break}    1. Introduction
{break}    2. Deep-dive
{break}    3. ...

{p 4 4 2}
or unordered list:

{break}    - Introduction
{break}    - Deep-dive
{break}    - ...


{title:}




{p 4 4 2}
This will start an {bf:asis} mode, which remember, it does not recognize "tabs". 
So until Stata fixes this problem, style your code with spaces rather than tabs.

{asis}
         
     if main.r2.iseq(1) {
         call main.master.enable
     }
     else {
         call main.master.disable
     }	
{smcl}


{title:}

{title:Introduction}

{title:}

{p 4 4 2}{bf:Listing observations}



