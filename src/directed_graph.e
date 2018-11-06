note
	description: "Summary description for {DIRECTED_GRAPH}."
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

	successors: ARRAY[LINKED_LIST[INTEGER]]

feature {ANY}

	add_node (node: INTEGER)
		do

		end

	add_vertice (predecessor, successor: STRING)
		do

		end

	delete_node (node: INTEGER)
		do

		end

	delete_vertice (predecessor, successor: STRING)
		do

		end
end
