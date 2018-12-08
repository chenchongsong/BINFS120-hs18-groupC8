note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_DISPLAYER

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Events

	displayer: DISPLAYER
	converter: CONVERTER
	graph: DIRECTED_GRAPH

	on_prepare
			-- <Precursor>
		do
			create displayer.make
			create converter.make
			create graph.make

			converter.insert_name ("event1")
			converter.insert_name ("event2")
			converter.insert_name ("event3")
			converter.insert_name ("event4")
			converter.delete_name ("event3")

			graph.set_largest_node (4)
			graph.add_edge (1, 2)
			graph.add_edge (1, 3)
			graph.add_edge (1, 4)
			graph.add_edge (2, 3)
			graph.add_edge (2, 4)
			graph.add_edge (3, 4)
			graph.delete_edge (1, 2)
			graph.delete_node (3)
		end

feature -- Test routines

	test_displayer
		local
			output_file: PLAIN_TEXT_FILE
			output_file_name: STRING
		do
			output_file_name := "output_graph_test_displayer.txt"
			displayer.to_graphviz_format (graph, converter, output_file_name)

			-- examine output file
			create output_file.make_open_read (output_file_name)
			output_file.readline
			assert ("line1", output_file.last_string.is_equal ("digraph output_graph {"))
			output_file.readline
			assert ("line2", output_file.last_string.is_equal ("    event1 -> { event4 }"))
			output_file.readline
			assert ("line3", output_file.last_string.is_equal ("    event2 -> { event4 }"))
			output_file.readline
			assert ("line4", output_file.last_string.is_equal ("    event4 -> { }"))

			-- tear down
			output_file.close
			output_file.delete
		end

end
