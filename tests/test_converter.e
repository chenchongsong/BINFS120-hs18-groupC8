note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CONVERTER

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
			assert ("not_implemented", True)
		end

	on_clean
			-- <Precursor>
		do
			assert ("not_implemented", True)
		end

feature -- Test routines

	test_converter_insert_name
		local
			converter: CONVERTER
		do
			create converter.make
			assert ("wrong initial largest number", converter.largest_integer = 0)
			converter.insert_name ("event1")
			assert ("wrong largest number", converter.largest_integer = 1)
			assert ("wrong element name", converter.id2name_array[1].is_equal ("event1"))
			assert ("wrong element id", converter.name2id_table.item ("event1") = 1)
		end

	test_converter_delete_name
		local
			converter: CONVERTER
		do
			create converter.make
			converter.insert_name ("event1")
			converter.delete_name ("event1")
			assert ("wrong largest number", converter.largest_integer = 1)
			assert ("wrong element name", converter.id2name_array[1].is_equal (""))
			assert ("wrong element id", converter.name2id_table.item ("event1") = 0)
		end

	test_converter_id2name_name2id
		local
			converter: CONVERTER
		do
			create converter.make
			converter.insert_name ("event1")
			converter.insert_name ("event2")
			assert ("wrong element id", converter.name2id ("event1") = 1)
			assert ("wrong element name", converter.id2name (2).is_equal ("event2"))

			-- test invalid names
			assert ("wrong element id", converter.name2id ("event3") = 0)
			-- test invalid ids
			assert ("wrong element name", converter.id2name (3).is_equal (""))
		end

end


