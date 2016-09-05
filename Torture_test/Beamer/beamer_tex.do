
//If you produce the slide from the do-file, instead of smcl, remove the log from the 
//top line, because the document must begine with the latex heading. 
qui log using example, replace

/***
\documentclass{beamer}
\title{Generating PDF slides with LaTeX Markup with MarkDoc package}
\author{E. F. Haghish}
\date{August 15, 2016}
\begin{document}
\maketitle
\begin{frame}
\frametitle{First Slide}
Contents of the first slide
\end{frame}
\begin{frame}
\frametitle{Second Slide}
Contents of the second slide
\end{frame}
\end{document}
***/



qui log c
*markdoc example, exp(pdf) markup(latex) replace 
