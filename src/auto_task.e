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
			if not check_element_existence (element_name) then
				converter.insert_name (element_name)
				print(converter.name2id (element_name))
				print(": added%N")
				graph.set_largest_node (converter.name2id (element_name))
			else
				print("Element Already Exists%N")
			end
		end

	add_constraint (element_name_1, element_name_2: STRING)
			-- add a constraint
		require
			name_not_void: element_name_1 /= Void and element_name_2 /= Void
		local
			element_id_1, element_id_2: INTEGER
		do
			if check_element_existence(element_name_1)
			and check_element_existence(element_name_2) then
				if not check_constraint_existence(element_name_1, element_name_2) then
					element_id_1 := converter.name2id (element_name_1)
					element_id_2 := converter.name2id (element_name_2)
					if element_id_1 /= element_id_2 then
						print(element_id_1)
						print(": added as part of constraint%N")
						print(element_id_2)
						print(": added as part of constraint%N")
						graph.add_edge (element_id_1, element_id_2)
					else
						print("Self-Loop Not Allowed")
					end
				else
					print("Constraint Already Exists%N")
				end
			else
				print("Element Not Exists%N")
			end
		end

	add_makefile(makefile: FILE)
			-- add nodes and constraints from a makefile
		require
			makefile.is_readable
		do
			-- TODO
		end

	delete_element (element_name: STRING)
			-- delete an element and associated constraints
		require
			name_not_void: element_name /= Void
		local
			element_id: INTEGER
		do
			if check_element_existence (element_name) then
				element_id := converter.name2id (element_name)
				graph.delete_node (element_id)
				converter.delete_name (element_name)
				print(converter.name2id (element_name))
				print(": deleted%N")
			else
				print("Element Not Exists%N")
			end
		end

	delete_constraint (element_name_1, element_name_2: STRING)
			-- delete the constraint element_1->element_2 if it exists
		require
			name_not_void: element_name_1 /= Void and element_name_2 /= Void
		local
			element_id_1, element_id_2: INTEGER
		do
			if check_constraint_existence(element_name_1, element_name_2) then
				element_id_1 := converter.name2id (element_name_1)
				element_id_2 := converter.name2id (element_name_2)
				graph.delete_edge (element_id_1, element_id_2)
			else
				print("Constraint Not Exists%N")
			end
		end

	topo_sort: LINKED_LIST [STRING]
			-- call the ALGORITHM class to performa cycle detection
			-- and then topological sort
			-- return a sorted linked list of all element names if no cycle
			-- return a sorted linked list of element names from non-cyclic parts if cycle exists
		local
			sorted_list_id: LINKED_LIST [INTEGER]
			sorted_list_name: LINKED_LIST [STRING]
			cycle_elements_id: LINKED_LIST [INTEGER]
		do
			create sorted_list_id.make
			create sorted_list_name.make

			cycle_elements_id := algorithm.cycle_detection(graph)
			if cycle_elements_id.is_empty then
				print("Cycle Not Found!%N")
			else
				print("Cycle Found:%N")
				across cycle_elements_id as element_iter
				loop
					print(converter.id2name(element_iter.item))
					print(" -> ")
				end
				cycle_elements_id.start
				print(converter.id2name(cycle_elements_id.item))
				print("%N")
			end

			-- compute sorted_list with topo sort
			sorted_list_id := algorithm.topo_sort (graph)
			across sorted_list_id as id_iter
			loop
				sorted_list_name.extend(converter.id2name(id_iter.item))
			end

			Result := sorted_list_name
		end

	display
			-- call the DISPLAYER class
			-- to generate GraphViz format text file
		do
			displayer.to_graphviz_format (graph, converter)
		end

feature {NONE}

	check_length (element_name: STRING): BOOLEAN
			-- check whether the element_name is within length constaint
		do
			Result := element_name.count > 100
		end

	check_element_existence (element_name: STRING): BOOLEAN
			-- check whether an element is added previously and not deleted so far
		local
			element_id: INTEGER
		do
			element_id := converter.name2id (element_name)
			Result := graph.check_node_existence (element_id)
		end

	check_constraint_existence (element_name_1, element_name_2: STRING): BOOLEAN
			-- check whether a constraint is added previously
			-- and not deleted so far
		local
			element_id_1, element_id_2: INTEGER
		do
			element_id_1 := converter.name2id (element_name_1)
			element_id_2 := converter.name2id (element_name_2)
			Result := graph.check_edge_existence (element_id_1, element_id_2)
		end
end
