note
	description: "Summary description for {AUTO_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUTO_TASK

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create converter.make
			create displayer.make
			create algorithm.make
			create graph.make
		end

feature {NONE}

	converter: CONVERTER
	displayer: DISPLAYER
	algorithm: ALGORITHM
	graph: DIRECTED_GRAPH

feature {ANY}

	add_element (element_name: STRING)
		do

		end

	add_constraint (element_name_1, element_name_2: STRING)
		do

		end

	delete_element (element_name: STRING)
		do

		end

	delete_constraint (element_name_1, element_name_2: STRING)
		do

		end

	topo_sort: LINKED_LIST [STRING]
		local sorted_list: LINKED_LIST [STRING]
		do
			create sorted_list.make
			Result := sorted_list
		end

feature {NONE}

	check_length (element_name: STRING): BOOLEAN
		do

		end

	check_existence (element_name: STRING): BOOLEAN
		do

		end

end
