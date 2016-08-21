/*******************************************************************************
MarkDoc Torture Test
====================

The following do files test different features of MarkDoc package. Run these 
files one after another. Note that each do file erases the output of the 
previous do-file to ensure the output is recreated. Make sure Stata can has 
the premission to remove files from your working directory.


E. F. Haghish
Department of Mathematics and Computer Science
University of Southern Denmark
odense, Denmark

Aug 2016
*******************************************************************************/

cd "/Users/haghish/Documents/Packages/markdoc/Torture_test"

// Markdown Test
// =======================================
do ./Markdown/empty.do				// .md - empty
do ./Markdown/md.do					// .md - testing headings
do ./Markdown/markers.do			// .md - testing //IMPORT & markers
do ./Markdown/commands.do			// .md - commenting the do file
do ./Markdown/weaver_commands.do	// .md - testing img, tbl, and txt commands
do ./Markdown/loop.do				// .md - writing text in a loop
do ./Markdown/mata.do				// .md - literate programming in Mata
do ./Markdown/docx.do				// .docx - appealing report with TOC 
do ./Markdown/html.do				// .html - appealing report with statax syntax highlighter
do ./Markdown/pdf.do				// .pdf - appealing report with statax syntax highlighter
do ./Markdown/stata_journal.do


// Arguments Test
// =======================================
do ./Arguments/noisily.do			// .html - run MarkDoc Nosily + Numbered

/*******************************************************************************
BUG: THE NUMBERED OPTION IS NOT WORKING. WANNA KEEP IT? PROBABLY NOT...
*******************************************************************************/

// Beamer Test
// =======================================
do ./Beamer/Beamer.do
do ./Beamer/Beamer2.do
do ./Beamer/Beamer3.do
do ./Beamer/example.do
do ./Beamer/Beamer_tex.do

// HTML Slide Test
// =======================================
do ./Slide/slidy.do
do ./Slide/dzslide.do


// LaTeX Test
// =======================================
do ./LaTeX/empty.do
do ./LaTeX/weaver_command.do
do ./LaTeX/heading.do
do ./LaTeX/mata.do
do ./LaTeX/toc.do 					//table of content
do ./LaTeX/pdf.do 					//create PDF from LaTeX


// Pandoc Test
// =======================================
do ./LaTeX/mata.do
pandoc example.tex -o example.html

// STHLP Test
// =======================================
do ./sthlp/sthlp.do 				// .sthlp - very messy attempt
do ./sthlp/bugs.do 					// .sthlp - solving the known bugs

markdoc ./sthlp/example.ado, replace export(html) title("THITLE") 				///
author("HAGHISH") aff("FREIBURGH") date ///
address("HERE AND THERE")			


// rundoc Test
// =======================================
rundoc "./rundoc/rundoc_example", export() statax replace
rundoc "./rundoc/rundoc_example", export(markdown) statax replace
rundoc "./rundoc/rundoc_example", export(html) statax replace
rundoc "./rundoc/rundoc_example", export(docx) statax replace
rundoc "./rundoc/rundoc_example", export(tex) statax replace texmaster
rundoc "./rundoc/rundoc_example", export(odt) statax replace 
rundoc "./rundoc/rundoc_example", export(pdf) statax replace




// Examples
// =======================================
do ./Examples/main_features.do 
do ./Examples/short.do 


cap erase example.docx
markdoc example, install replace export(docx) noi
markdoc example, install replace export(pdf) noi


// Erase the products
// =======================================
cap erase graph.png
cap erase example.docx
cap erase example.html
cap erase example.odt

cap erase example.pdf
cap erase example.smcl
cap erase example.tex
cap erase example.aux
cap erase example.log
cap erase example.out
cap erase example.synctex.gz

cap erase example2.pdf
cap erase example2.smcl
cap erase example2.tex
cap erase example2.aux
cap erase example2.log
cap erase example2.out
cap erase example2.synctex.gz



cap erase myprogram.ado
// ---------------------------------------


