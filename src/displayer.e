note
	description: "A class for graphviz text file generation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DISPLAYER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature {ANY}

	to_graphviz_format (graph: DIRECTED_GRAPH)
			-- given a directed graph
			-- generate the corresponding text file
			-- for GraphViz to read and display the graph
		do

		end

end
