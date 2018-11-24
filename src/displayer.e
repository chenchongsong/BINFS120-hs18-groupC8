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

feature {AUTO_TASK}

	to_graphviz_format (graph: DIRECTED_GRAPH; converter: CONVERTER)
			-- given a directed graph
			-- generate the corresponding text file
			-- for GraphViz to read and display the graph
		local
			output_file: PLAIN_TEXT_FILE
		do
			create output_file.make_open_write ("output_graph.txt")
			output_file.put_string ("digraph output_graph {%N")

			across 1 |..| graph.largest_node as predecessor_iter loop
				if graph.check_node_existence (predecessor_iter.item) then
					across graph.successors[predecessor_iter.item] as successor_iter loop
						output_file.put_string ("    ")
						output_file.put_string (converter.id2name (predecessor_iter.item))
						output_file.put_string (" -> ")
						output_file.put_string (converter.id2name (successor_iter.item))
						output_file.put_string ("%N")
					end
				end
			end

			output_file.put_string ("}%N")
			output_file.close
		end

end
