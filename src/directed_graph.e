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
		ensure
			nodes.is_empty
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
		require
			positive_node_id: node > 0
		do

		end

	add_edge (predecessor, successor: INTEGER)
			-- add an edge predecessor->successor to the graph
		require
			positive_node_id: predecessor > 0 and successor > 0
			not_self_cycle: predecessor /= successor
		do

		end

	delete_node (node: INTEGER)
			-- delete an node from the "nodes" list
			-- delete all related edges from the adjacency list
		require
			positive_node_id: node > 0
		do

		end

	delete_edge (predecessor, successor: INTEGER)
			-- if edge "predecessor->successor" exists
			-- delete it from the graph
		require
			positive_node_id: predecessor > 0 and successor > 0
		do

		end
end
