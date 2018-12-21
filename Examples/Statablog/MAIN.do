// the MAIN.do executes examples from Stata Blog
// visit https://blog.stata.com/ for more informatin

cd datamanagement

// Web scraping NBA data into Stata
clear
do "./NBA.do"
markdoc "_NBA.smcl" , mini export(md) replace statax        // Markdown 
markdoc "_NBA.smcl" , mini export(html) replace statax      // html 
markdoc "_NBA.smcl" , mini export(docx) replace statax      // Word 
markdoc "_NBA.smcl" , mini export(pdf) replace statax       // pdf 
markdoc "_NBA.smcl" , mini export(slide) replace statax     // Slides
markdoc "NBA.do" , mini export(sthlp) replace               // help file


// Handling gaps in time series using business calendars
clear
do "./timeseries.do"
markdoc "_timeseries.smcl" , mini export(md) replace statax    // Markdown 
markdoc "_timeseries.smcl" , mini export(html) replace statax  // html 
markdoc "_timeseries.smcl" , mini export(docx) replace statax  // Word 
markdoc "_timeseries.smcl" , mini export(pdf) replace statax   // pdf 
markdoc "_timeseries.smcl" , mini export(slide) replace statax // Slides
markdoc "timeseries.do" , mini export(sthlp) replace           // help file
