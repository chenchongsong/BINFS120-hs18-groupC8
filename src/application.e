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
		do
			--| Add your code here
			print ("==================%N")
			create auto_task.make
			--auto_task.add_element ("1")
			--auto_task.add_element ("1")
			--auto_task.delete_element ("1")
			--auto_task.delete_element ("1")
			--auto_task.add_element ("1")

			auto_task.add_element ("normal")
			auto_task.add_element ("happy")
			auto_task.add_element ("sad")
			auto_task.add_constraint ("normal", "sad")
			auto_task.add_constraint ("happy", "normal")
			auto_task.add_constraint ("sad", "happy")
			--auto_task.add_constraint ("happy", "happy")
			--auto_task.delete_constraint ("1", "2")
			topo_result := auto_task.topo_sort
			auto_task.display
		end

end
