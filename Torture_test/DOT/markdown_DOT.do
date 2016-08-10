
// -----------------------------------------------------------------------------
// Literate Visualization Notation
// =============================================================================
qui log using 000, replace smcl
	/***
	Dynamic Software Visualization
	=========================
	
	
	Writing software documentation and visualizing seletive information can 
	boost active learning in students. It can also provide very useful information 
	about structure of a software and encourages users to read the code and 
	contribute to an open-source project. __MarkDoc package__ supports the 
	___DOT___ (graph description language), and it can produce HTML documents 
	with graphs, written within the source code or data analysis. 
	
	The graph can be written in different sections. However, MarkDoc has a 
	separate syntax for beginning a new graph or continuing the previous graphs. 
	to begin a new graph, use the regular syntax for wiriting documentation plus 
	a double dollar sign and to continue using the current 
	graph, use a single dollar sign. Here is an example:
	***/
	
	/***$$ 
  	digraph {
		Hello -> World; 
	}
	***/ 
	
	/***
	Continues figures
	-----------------
	
	It's much easier to write a detailed graph in different section and update 
	it, when there is a change in that section. Writing a detailed graph at once 
	and within a single section makes it _less interesting_ and makes it feel like 
	_extra work_ when the job is already done. However if the graph is developed 
	gradually, as the program is written, it's more encouraging. For example, the 
	graph below is written in two separate sections. 
	***/
	
	/***$$
	graph ER {
	node [shape=box]; course; institute; student;
	node [shape=ellipse]; {node [label="name"] name0; name1; name2;}
		code; grade; number;
	node [shape=diamond,style=filled,color=lightgrey]; "C-I"; "S-C"; "S-I";

	name0 -- course;
	code -- course;
	course -- "C-I" [label="n",len=1.00];
	"C-I" -- institute [label="1",len=1.00];
	***/
	

	
	/***$
	institute -- name1;
	institute -- "S-I" [label="1",len=1.00];
	"S-I" -- student [label="n",len=1.00];
	student -- grade;
	student -- name2;
	student -- number;
	student -- "S-C" [label="m",len=1.00];
	"S-C" -- course [label="n",len=1.00];

	label = "\n\nEntity Relation Diagram\ndrawn by NEATO";
	fontsize=20;
	}
	***/
	
	
	/***
	Example 1
	---------
	***/
	
	/***$$
	digraph { 
		subgraph cluster_0 {
			label="Subgraph A";
			a -> b;
			b -> c;
			c -> d;
		}
		
		subgraph cluster_1 {
			label="Subgraph B";
			a -> f;
			f -> c;
		}
	}
	***/
	
	
	/***
	Example 2
	---------
	***/
	
	/***$$
	digraph {
		a -> b[label="0.2",weight="0.2"];
		a -> c[label="0.4",weight="0.4"];
		c -> b[label="0.6",weight="0.6"];
		c -> e[label="0.6",weight="0.6"];
		e -> e[label="0.1",weight="0.1"];
		e -> b[label="0.7",weight="0.7"];
	}
	***/
	
	
	
	
	
	
	/***
	Example 3
	---------
	***/
	/***$$
	digraph G {

	subgraph cluster_0 {
		style=filled;
		color=lightgrey;
		node [style=filled,color=white];
		a0 -> a1 -> a2 -> a3;
		label = "process #1";
	}

	subgraph cluster_1 {
		node [style=filled];
		b0 -> b1 -> b2 -> b3;
		label = "process #2";
		color=blue
	}
	start -> a0;
	start -> b0;
	a1 -> b3;
	b2 -> a3;
	a3 -> a0;
	a3 -> end;
	b3 -> end;

	start [shape=Mdiamond];
	end [shape=Msquare];
	}
	***/
	
	
	
qui log c 
markdoc 000, replace exp(html) 
