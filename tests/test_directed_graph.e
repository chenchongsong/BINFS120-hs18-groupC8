note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_DIRECTED_GRAPH

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			assert ("not_implemented", True)
		end

	on_clean
			-- <Precursor>
		do
			assert ("not_implemented", True)
		end

feature -- Test routines

	test_directed_graph_set_largest_node_delete_node
			-- with check_node_existence
		local
			graph: DIRECTED_GRAPH
		do
			-- set_largest_node
			create graph.make
			graph.set_largest_node (5)
			assert ("set largest node failure", graph.largest_node = 5)
			-- check_node_existence
			assert ("delete node failure: init", graph.deleted [3] = false)
			assert ("check node existence failure: added", graph.check_node_existence (3))

			-- delete_node
			graph.delete_node (3)
			-- check node not exist
			assert ("delete node failure: after deletion", graph.deleted [3] = true)
			assert ("check node existence failure: deleted", not graph.check_node_existence (3))
		end

	test_directed_graph_add_delete_edge
		local
			graph: DIRECTED_GRAPH
		do
			-- add edge
			create graph.make
			graph.set_largest_node (3)
			graph.add_edge (1, 2)
			graph.add_edge (1, 3)
			assert ("add edge failure", graph.successors [1].count = 2)
			assert ("add edge failure: first edge", graph.successors [1].first = 2)
			assert ("add edge failure: second edge", graph.successors [1].last = 3)
			-- check_edge_existence
			assert ("check edge existence", graph.check_edge_existence (1, 2))
			assert ("check edge existence", graph.check_edge_existence (1, 3))

			-- delete edge
			graph.delete_edge (1, 2)
			assert ("delete edge failure", graph.successors [1].count = 1)
			assert ("delete edge failure", graph.successors [1].first = 3)
			-- check edge not exist
			assert ("check edge existence", not graph.check_edge_existence (1, 2))
		end

end
