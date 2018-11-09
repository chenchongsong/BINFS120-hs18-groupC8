note
	description: "Class to handle cycle detection and topo sort."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALGORITHM

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature {AUTO_TASK} -- Cycle Detection

	cycle_detection (graph: DIRECTED_GRAPH): BOOLEAN
			-- check whether the graph contains a cycle
			-- with Depth First Search
		do

		end

feature {AUTO_TASK} -- Topological Sort

	topo_sort (graph: DIRECTED_GRAPH): LINKED_LIST [INTEGER]
			-- topological sort based on Kahn's algorithm
		local
			sorted_list: LINKED_LIST [INTEGER]
		do
			create sorted_list.make
			Result := sorted_list
		end

end
