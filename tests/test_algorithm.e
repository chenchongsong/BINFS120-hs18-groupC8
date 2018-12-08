note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_ALGORITHM

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

feature {NONE} -- Events

	graph_with_cycle: DIRECTED_GRAPH

	graph_without_cycle: DIRECTED_GRAPH

	on_prepare
			-- <Precursor>
		do
			create graph_with_cycle.make
			graph_with_cycle.set_largest_node (4)
			graph_with_cycle.add_edge (1, 2)
			graph_with_cycle.add_edge (2, 3)
			graph_with_cycle.add_edge (3, 2)
			graph_with_cycle.add_edge (3, 4)

			create graph_without_cycle.make
			graph_without_cycle.set_largest_node (4)
			graph_without_cycle.add_edge (1, 2)
			graph_without_cycle.add_edge (1, 3)
			graph_without_cycle.add_edge (2, 4)
			graph_without_cycle.add_edge (3, 4)
		end

	on_clean
			-- <Precursor>
		do
			assert ("not_implemented", True)
		end

feature -- Test routines

	test_algorithm_cycle_detection_found
		local
			algorithm: ALGORITHM
			cycle: LINKED_LIST [INTEGER]
		do
			create algorithm.make
			cycle := algorithm.cycle_detection (graph_with_cycle)
			assert ("cycle detection: number of nodes", cycle.count = 2)
			assert ("cycle detection: first element", cycle.has (2))
			assert ("cycle detection: second element", cycle.has (3))
		end

	test_algorithm_cycle_detection_not_found
		local
			algorithm: ALGORITHM
			cycle: LINKED_LIST [INTEGER]
		do
			create algorithm.make
			cycle := algorithm.cycle_detection (graph_without_cycle)
			assert ("cycle detection: should not found", cycle.count = 0)
		end

	test_algorithm_topo_sort_with_cycle
		local
			algorithm: ALGORITHM
			sorted_list: LINKED_LIST [INTEGER]
		do
			create algorithm.make
			sorted_list := algorithm.topo_sort (graph_with_cycle)
			assert ("topo sort: acyclic part", sorted_list.count = 1 and sorted_list.has (1))
		end

	test_algorithm_topo_sort_without_cycle
		local
			algorithm: ALGORITHM
			sorted_list: LINKED_LIST [INTEGER]
		do
			create algorithm.make
			sorted_list := algorithm.topo_sort (graph_without_cycle)
			assert ("topo sort: whole", sorted_list.count = 4)
			assert ("topo sort: whole", sorted_list.first = 1)
			assert ("topo sort: whole", sorted_list.last = 4)
		end

end
