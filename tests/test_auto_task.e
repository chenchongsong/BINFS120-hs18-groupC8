note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_AUTO_TASK

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do

		end

	on_clean
			-- <Precursor>
		do

		end

feature -- Test routines

	test_auto_task_topo_sort_without_cycle
		local
			auto_task: AUTO_TASK
			topo_result: LINKED_LIST [STRING]
		do
			create auto_task.make
			auto_task.add_element("event1")
			auto_task.add_element("event2")
			auto_task.add_element("event3")
			auto_task.add_constraint("event1", "event2")
			auto_task.add_constraint("event1", "event3")
			auto_task.add_constraint("event2", "event3")
			auto_task.delete_constraint("event1", "event3")
			auto_task.delete_element("event3")

			topo_result := auto_task.topo_sort
			assert ("auto task: whole", topo_result.count = 2)
			assert ("auto task: whole", topo_result.first.is_equal ("event1"))
			assert ("auto task: whole", topo_result.last.is_equal ("event2"))
		end

	test_auto_task_add_makefile_display
		local
			auto_task: AUTO_TASK
			input_makefile: PLAIN_TEXT_FILE
			input_makefile_name: STRING
			output_file: PLAIN_TEXT_FILE
			output_file_name: STRING
		do
			-- generate input_makefile for testing
			input_makefile_name := "input_makefile_test_auto_task.txt"
			create input_makefile.make_open_write (input_makefile_name)
			input_makefile.put_string ("event1: event2 event3 %N")
			input_makefile.put_string ("     %N")
			input_makefile.put_string ("event4:%N")
			input_makefile.put_string ("%N")
			-- terminate writing mode and reopen it with reading mode
			input_makefile.close
			input_makefile.make_open_read (input_makefile_name)

			-- add_makefile
			create auto_task.make
			auto_task.add_makefile (input_makefile)

			-- display
			output_file_name := "output_graph_test_auto_task.txt"
			auto_task.display (output_file_name)

			-- oracle
			create output_file.make_open_read (output_file_name)
			output_file.readline
			assert ("line1", output_file.last_string.is_equal ("digraph output_graph {"))
			output_file.readline
			assert ("line2", output_file.last_string.is_equal ("    event1 -> { }"))
			output_file.readline
			assert ("line3", output_file.last_string.is_equal ("    event2 -> { event1 }"))
			output_file.readline
			assert ("line4", output_file.last_string.is_equal ("    event3 -> { event1 }"))
			output_file.readline
			assert ("line5", output_file.last_string.is_equal ("    event4 -> { }"))
			output_file.readline
			assert ("line6", output_file.last_string.is_equal ("}"))

			-- tear down
			input_makefile.delete
			output_file.close
			output_file.delete
		end
end
