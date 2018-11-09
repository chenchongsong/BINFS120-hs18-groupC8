note
	description: "Directed Graph"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTED_GRAPH

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create nodes.make
			create successors.make_empty
		end

feature {NONE}

	nodes: LINKED_LIST [INTEGER]
			-- a list of all nodes,
			-- where each node is uniquely identified by an INTEGER

	successors: ARRAY[LINKED_LIST[INTEGER]]
			-- the adjacency list of the graph.
			-- successors[100] = [101, 102] means that
			-- there are two edges 100->101, 100->102

feature {ANY}

	add_node (node: INTEGER)
			-- append an INTEGER at the end of "nodes" list
		do

		end

	add_edge (predecessor, successor: STRING)
			-- add an edge predecessor->successor to the graph
		do

		end

	delete_node (node: INTEGER)
			-- delete an node from the "nodes" list
			-- delete all related edges from the adjacency list
		do

		end

	delete_edge (predecessor, successor: STRING)
			-- if edge "predecessor->successor" exists
			-- delete it from the graph
		do

		end
end
