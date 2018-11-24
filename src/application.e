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
		do
			--| Add your code here
			print ("==================%N")
			create auto_task.make
			--auto_task.add_element ("1")
			--auto_task.add_element ("1")
			--auto_task.delete_element ("1")
			--auto_task.delete_element ("1")
			--auto_task.add_element ("1")
			auto_task.add_element ("1")
			auto_task.add_element ("2")
			auto_task.add_constraint ("1", "2")
			auto_task.delete_constraint ("1", "2")
			auto_task.delete_constraint ("1", "2")
		end

end
