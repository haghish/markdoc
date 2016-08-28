
qui log using 0, replace
/***
\begin{table}[]
\centering
\caption{My caption}
\label{my-label}
\begin{tabular}{|l|l|l|}
\hline
\textbf{Animals} & \textbf{Sports}  & \textbf{Fruits} \\ \hline
Cat     & Soccer     & Apple  \\ \hline
Dog     & Basketball & Orange \\ \hline
\end{tabular}
\end{table}
***/

qui log c
markdoc 0, expor(pdf) markup(latex) replace texmaster
