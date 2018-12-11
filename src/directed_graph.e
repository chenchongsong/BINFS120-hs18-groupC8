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
			create deleted.make_filled (false, 1, 5000)
			create successors.make_filled(create {LINKED_LIST[INTEGER]}.make, 1, 5000)
			across 1 |..| 5000 as predecessor_iter loop
				successors.put (create {LINKED_LIST[INTEGER]}.make, predecessor_iter.item)
			end
		end

feature {DISPLAYER, ALGORITHM, TEST_DIRECTED_GRAPH}

	largest_node: INTEGER
			-- the upperbound of all node values in successors ARRAY
			-- Without node deletion, all nodes range from [1, largest_node]

	successors: ARRAY [LINKED_LIST [INTEGER]]
			-- the adjacency list of the graph.
			-- successors[100] = [101, 102] means that
			-- there are two edges 100->101, 100->102

	deleted: ARRAY [BOOLEAN]
			-- corresponding entry will be marked as deleted (true)
			-- after a node is deleted

feature {DISPLAYER, ALGORITHM, AUTO_TASK, TEST_DIRECTED_GRAPH, TEST_ALGORITHM, TEST_DISPLAYER}
	check_node_existence (node: INTEGER): BOOLEAN
		require
			non_negative_node: node >= 0
		do
			if node > largest_node or node = 0 then
				Result := false
			else
				if deleted[node] then
					Result := false
				else
					Result := true
				end
			end
		end

	check_edge_existence (predecessor, successor: INTEGER): BOOLEAN
		require
			non_negative_nodes: predecessor >= 0 and successor >= 0
		do
			if not check_node_existence (predecessor)
			or not check_node_existence (successor) then
				Result := false
			else
				Result := successors[predecessor].has (successor)
			end
		end

feature {AUTO_TASK, TEST_DIRECTED_GRAPH, TEST_ALGORITHM, TEST_DISPLAYER}

	set_largest_node (new_largest_node: INTEGER)
			-- append an INTEGER at the end of "nodes" list
		require
			positive_node: new_largest_node > 0
		do
			largest_node := new_largest_node
		end

	add_edge (predecessor, successor: INTEGER)
			-- add an edge predecessor->successor to the graph
		require
			positive_node_id: predecessor > 0 and successor > 0
			not_self_cycle: predecessor /= successor
		do
			successors[predecessor].extend (successor)
		end

	delete_node (node: INTEGER)
			-- delete an node from the "nodes" list
			-- delete all related edges from the adjacency list
		require
			positive_node: node > 0
			existence: check_node_existence (node)
		do
			deleted[node] := true
		end

	delete_edge (predecessor, successor: INTEGER)
			-- if edge "predecessor->successor" exists
			-- delete it from the graph
		require
			positive_nodes: predecessor > 0 and successor > 0
			existence: check_edge_existence (predecessor, successor)
		do
			from
				successors[predecessor].start
			until
				successors[predecessor].exhausted
			loop
				if successors[predecessor].item = successor then
					successors[predecessor].remove
				else
					successors[predecessor].forth
				end
			end
		end
end
