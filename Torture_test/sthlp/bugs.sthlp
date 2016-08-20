{smcl}


{title:Adding a list}

{p 4 4 2}
* this is a text line    {break}
* this is also    {break}
* how about this?    {break}
	
	

{title:Dot in the end}

{p 4 4 2}
It seems that if a line end with a "." dot, 
and a new line is 
started adter, 
the {bf:sthlp} engine will add 2 space characters. 
Like this. 
Is that solved? 


{p 4 4 2}
This is not true if the text is written immediately. after the dot

{p 4 4 2}
Also, removing.
space after the dot does not help!

{p 4 4 2}
{bf:AFTER EVALUATING THE {help smcl} file} it seems {help markdoc} is working
very fine and there is no bug. This is how Stata renders SMCL document...
but still, there is no reason why there should be 2 spaces.

{p 4 4 2}
This problem,
only happens after dots.



{title:Ending the line with accent}

{p 4 4 2}
The grave accents are used to {c 96}make{c 96} font monospace. Can we 



{title:Unsolved}




