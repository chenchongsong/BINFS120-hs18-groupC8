note
	description: "autotask application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application
		do
			--example_1
			example_2
		end

	example_1
		local
			auto_task: AUTO_TASK
			topo_result: LINKED_LIST [STRING]
			choice, further_input_1, further_input_2: STRING
		do
			from
				create auto_task.make
				choice := ""
			until
				choice.is_equal ("q")
			loop
				print ("%N====================================%N")
				print ("Please Enter Your Option:%N")
				print ("(ae)  : Add an element%N")
				print ("(ac)  : Add a constraint%N")
				print ("(de)  : Delete an element%N")
				print ("(dc)  : Delete a constraint%N")
				print ("(topo): Perform Topological Sort%N")
				print ("(dis) : Generate a Graphviz text file, according to directed graph%N")
				print ("(q)   : Quit%N")
				io.read_line
				choice := io.last_string.out
				if choice.is_equal ("ae") then
					print ("Please Enter the Element Name:%N")
					io.read_line
					further_input_1 := io.last_string.out
					auto_task.add_element (further_input_1)
				end
				if choice.is_equal ("ac") then
					print ("Please Enter Element Name:%N")
					io.read_line
					further_input_1 := io.last_string.out
					print ("|%N")
					print ("V%N")
					io.read_line
					further_input_2 := io.last_string.out
					auto_task.add_constraint (further_input_1, further_input_2)
				end
				if choice.is_equal ("de") then
					print ("Please Enter Element Names:%N")
					io.read_line
					further_input_1 := io.last_string.out
					auto_task.delete_element (further_input_1)
				end
				if choice.is_equal ("dc") then
					print ("Please Enter Element Names:%N")
					io.read_line
					further_input_1 := io.last_string.out
					print ("|%N")
					print ("V%N")
					io.read_line
					further_input_2 := io.last_string.out
					auto_task.delete_constraint (further_input_1, further_input_2)
				end
				if choice.is_equal ("topo") then
					topo_result := auto_task.topo_sort
					print("Topo Sort Resut:%N")
					across topo_result as element_iter
					loop
						print(element_iter.item.out + ", ")
					end
					print("%N")
				end
				if choice.is_equal ("dis") then
					auto_task.display ("outptu_graph_1.txt")
				end
				if not (choice.is_equal ("ae") or choice.is_equal ("ac") or
						choice.is_equal ("de") or choice.is_equal ("dc") or
						choice.is_equal ("topo") or choice.is_equal ("dis") or
						choice.is_equal ("q")) then
					print ("Invalid Choice!")
				end
			end
		end

	example_2
		local
			auto_task: AUTO_TASK
			topo_result: LINKED_LIST [STRING]
			input_makefile: PLAIN_TEXT_FILE
		do
			create auto_task.make
			create input_makefile.make_open_read("input_makefile_example_1.txt")
			auto_task.add_makefile(input_makefile)
			topo_result := auto_task.topo_sort
			print("Topo Sort Resut:%N")
			across topo_result as element_iter
			loop
				print(element_iter.item.out + ", ")
			end
			print("%N")
		end
end
