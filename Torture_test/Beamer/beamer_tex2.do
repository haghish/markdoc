
qui log using example, replace

/***
\documentclass{beamer}
\usepackage{default}
\title{Generating PDF slides with LaTeX Markup with MarkDoc package}
\author{E. F. Haghish}
\date{August 15, 2016}
\begin{document}
\maketitle
***/


/***
\begin{frame}
\frametitle{First Slide}
Contents of the first slide
\end{frame}
***/

/***
\begin{frame}
	\frametitle{Famous Composers}
	\begin{center}
		\begin{tabular}{|l|c|}\hline
			J.\ S.\ Bach & 1685--1750 \\
			W.\ A.\ Mozart & 1756--1791 \\
			L.\ Beethoven & 1770--1827 \\
			F.\ Chopin & 1810--1849 \\
			R.\ Schumann & 1810--1856 \\
			B.\ Bart\'{o}k & 1881--1945 \\ \hline
		\end{tabular}
	\end{center}
\end{frame}
***/


*********************** IMPORT THE SAME TABLE FROM A FILE

//IMPORT ./Beamer/table.tex


/***
\begin{frame}
\frametitle{Second Slide}
Contents of the second slide
\end{frame}
\end{document}
***/





qui log c
markdoc example, exp(slide) markup(latex) replace 
