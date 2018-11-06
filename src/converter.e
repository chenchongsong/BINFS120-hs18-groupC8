note
	description: "Summary description for {NAME_ID_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERTER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			largest_integer := 0
			create name2id_table.make(100)
			create id2name_array.make_empty
		end

feature {NONE}

	largest_integer: INTEGER
	name2id_table: HASH_TABLE [INTEGER, STRING]
	id2name_array: ARRAY [STRING]

feature {ANY}

	name2id (name: STRING): INTEGER
		do
			Result := 0 -- TODO
		end

	id2name (id: INTEGER): STRING
		do
			Result := "" -- TODO
		end

	insert_name (name: STRING)
		do

		end

	delete_name (name: STRING)
		do

		end
end
