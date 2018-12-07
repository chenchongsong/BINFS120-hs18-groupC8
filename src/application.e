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
			-- Run application.
		local
			auto_task: AUTO_TASK
			topo_result: LINKED_LIST [STRING]
			makefile: PLAIN_TEXT_FILE
		do
			--| Add your code here
			print ("==================%N")
			create auto_task.make
			--auto_task.add_element ("1")
			--auto_task.add_element ("1")
			--auto_task.delete_element ("1")
			--auto_task.delete_element ("1")
			--auto_task.add_element ("1")

--			--auto_task.add_element ("root")
--			auto_task.add_element ("normal")
--			auto_task.add_element ("happy")
--			auto_task.add_element ("sad")
--			auto_task.add_constraint ("normal", "sad")
--			auto_task.add_constraint ("happy", "normal")
--			--auto_task.add_constraint ("sad", "happy")
--			--auto_task.add_constraint ("root", "normal")
--			--auto_task.delete_constraint ("1", "2")

			create makefile.make_open_read("input_makefile")
			auto_task.add_makefile(makefile)
			topo_result := auto_task.topo_sort
			print("Topo Sort Resut:%N")
			across topo_result as element_iter
			loop
				print(element_iter.item.out + ", ")
			end
			print("%N")
			auto_task.display
		end

end
