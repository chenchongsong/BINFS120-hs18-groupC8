note
	description: "Core Class of the Whole Library, providing APIs to the user"
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
		ensure
			converter /= Void
			displayer /= Void
			algorithm /= Void
			graph /= Void

		end

feature {NONE}

	converter: CONVERTER

	displayer: DISPLAYER

	algorithm: ALGORITHM

	graph: DIRECTED_GRAPH

feature {ANY}

	add_element (element_name: STRING)
			-- add an element
		require
			name_not_void: element_name /= Void
		do

		end

	add_constraint (element_name_1, element_name_2: STRING)
			-- add a constraint
		require
			name_not_void: element_name_1 /= Void and element_name_2 /= Void
		do

		end

	add_makefile(makefile: FILE)
			-- add nodes and constraints from a makefile
		require
			makefile.is_readable
		do
			
		end

	delete_element (element_name: STRING)
			-- delete an element and associated constraints
		require
			name_not_void: element_name /= Void
		do

		end

	delete_constraint (element_name_1, element_name_2: STRING)
			-- delete the constraint element_1->element_2 if it exists
		require
			name_not_void: element_name_1 /= Void and element_name_2 /= Void
		do

		end

	topo_sort: LINKED_LIST [STRING]
			-- call the ALGORITHM class to performa cycle detection
			-- and then topological sort
		local sorted_list: LINKED_LIST [STRING]
		do
			create sorted_list.make
			Result := sorted_list
		end

	display
			-- call the DISPLAYER class
			-- to generate GraphViz format text file
		do

		end

feature {NONE}

	check_length (element_name: STRING): BOOLEAN
			-- check whether the element_name is within length constaint
		do

		end

	check_existence (element_name: STRING): BOOLEAN
			-- check whether an element is added previously and not deleted so far
		do

		end

end
