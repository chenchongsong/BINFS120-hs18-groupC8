note
	description: "The class converts name->id and id->name for elements"
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
			-- the largest id used so far

	name2id_table: HASH_TABLE [INTEGER, STRING]

	id2name_array: ARRAY [STRING]

feature {ANY}

	name2id (name: STRING): INTEGER
			-- translate from name to id using name2id_table,
			-- resutrn 0 if the name not found in the hash table
		do
			Result := 0 -- TODO
		end

	id2name (id: INTEGER): STRING
			-- translate from id to name using id2name_array
			-- return empty string if the id is invalid
		do
			Result := "" -- TODO
		end

	insert_name (name: STRING)
			-- insert a (name, new_id) pair in the hash table
		do

		end

	delete_name (name: STRING)
			-- delete the (name, id) pari from the hash table
			-- also, set id2name_array[id] to ""
		do

		end
end
