//cd "/Users/haghish/Desktop/new"

/***
\documentclass[11pt]{amsart}
\usepackage{geometry}                % See geometry.pdf to learn the layout options. There are lots.
\geometry{letterpaper}                   % ... or a4paper or a5paper or ... 
\usepackage{graphicx}
\usepackage{amssymb}
\usepackage{epstopdf}
\DeclareGraphicsRule{.tif}{png}{.png}{`convert #1 `dirname #1`/`basename #1 .tif`.png}

\title{Chapter 3}
\author{E. F. Haghish}
\date{}                                           % Activate to display a given date or no date

\begin{document}
\maketitle

\section{}
\subsection{}



\end{document}  
***/


markdoc all_latex.do, export(pdf) markup(latex) replace linesize(120) 				///
printer("/usr/texbin/pdflatex")
