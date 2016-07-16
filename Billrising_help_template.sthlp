{smcl}
{* *! version #.#.# 18sep2011}{...}
{* delete if no dialog box}{...}
{viewerdialog "XXX" "dialog XXX"}{...}
{* link to manual entries (really meant for stata to link to its own docs}{...}
{vieweralsosee "[?] whatever" "mansection ? whatever"}{...}
{* a divider if needed}{...}
{vieweralsosee "" "--"}{...}
{* link to other help files which could be of use}{...}
{vieweralsosee "[?] whatever" "help whatever "}{...}
{viewerjumpto "Syntax" "XXX##syntax"}{...}
{viewerjumpto "Description" "XXX##description"}{...}
{viewerjumpto "Options" "XXX##options"}{...}
{viewerjumpto "Remarks" "XXX##remarks"}{...}
{viewerjumpto "Examples" "XXX##examples"}{...}
{viewerjumpto "Stored Results" "XXX##stored_results"}{...}
{viewerjumpto "Acknowledgements" "XXX##acknowledgements"}{...}
{viewerjumpto "Author" "XXX##author"}{...}
{viewerjumpto "References" "XXX##references"}{...}
{...}
{title:Title}

{phang}
{cmd:XXX} {hline 2} title of command
{p_end}

{marker syntax}{...}
{title:Syntax}

{* put the syntax in what follows. Don't forget to use [ ] around optional items}{...}
{p 8 16 2}
   {cmd: XXX}
   {varlist}
   {cmd:=}{it}{help exp}{sf}
   {ifin}
   {weight}
   {help using} {it:filename}
   [{cmd:,}
   {it:options}
   ]
{p_end}

{* the new Stata help format of putting detail before generality}{...}
{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt min:abbrev}}description of what option{p_end}
{synopt:{opt min:abbrev(arg)}}description of another option{p_end}
{synoptline}
{p2colreset}{...}

{p 4 6 2}{* if by is allowed, leave the following}
{cmd:by} is allowed; see {manhelp by D}.{p_end}
{p 4 6 2}{* if weights are allowed, say which ones}
{cmd:fweight}s are allowed; see {help weight}.


{marker description}{...}
{title:Description}

{pstd}
{cmd:XXX} does ... (now put in a one-short-paragraph description of the purpose of the command)
{p_end}


{marker options}{...}
{title:Options}

{phang}{opt whatever} does yak yak
{p_end}

{pmore}Use -pmore- for additional paragraphs within and option description.
{p_end}

{phang}{opt 2nd option} etc.


{marker remarks}{...}
{title:Remarks}

{pstd}
The remarks are the detailed description of the command and its nuances.
Official documented Stata commands don't have much for remarks, because the remarks go in the documentation.
{p_end}


{marker examples}{...}
{title:Example(s)}{* Be sure to change Example(s) to either Example or Examples}

{phang}{cmd:. some sample input here}{* an example with no explanation}
{p_end}

{phang}{cmd:. another sample input here}{break}
An example with explanation
{p_end}

{marker stored_results}{...}
{title:Stored results}

{pstd}{* replace r() with e() for an estimation command}
{cmd:summarize} stores the following in {cmd:r()}:

{* here is everything saved from estimation commands}{...}
{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}


{marker acknowledgments}{...}
{title:Acknowledgements}

{pstd}
If you have thanks specific to this command, put them here.

{marker author}{...}
{title:Author}

{pstd}
Author information here; nothing for official Stata commands
{p_end}

{marker references}{...}
{title:References}

{pstd}{* here is a shill example entry from the -regress- command}
{marker AP2009}{...}
{phang}
Angrist, J. D., and J.-S. Pischke. 2009.
{browse "http://www.stata.com/bookstore/mhe.html":{it:Mostly Harmless Econometrics: An Empiricist's Companion}.}
Princeton, NJ: Princeton University Press.

