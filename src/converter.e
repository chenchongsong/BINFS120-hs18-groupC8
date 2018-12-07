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
			create id2name_array.make_filled("", 1, 100)
		ensure
			largest_integer = 0
		end

feature {TEST_CONVERTER}

	largest_integer: INTEGER
			-- the largest id used so far

	name2id_table: HASH_TABLE [INTEGER, STRING]

	id2name_array: ARRAY [STRING]

feature {ANY}

	name2id (name: STRING): INTEGER
			-- translate from name to id using name2id_table,
			-- resutrn 0 if the name not found in the hash table
		require
			check_length: name.count <= 100
		do
			Result := name2id_table.item(name)
		end

	id2name (id: INTEGER): STRING
			-- translate from id to name using id2name_array
			-- return empty string if the id is invalid
		do
			Result := id2name_array[id]
		end

	insert_name (name: STRING)
			-- insert a (name, new_id) pair in the hash table
		require
			check_length: name.count <= 100
		do
			if not name2id_table.has (name) then
				largest_integer := largest_integer + 1
				name2id_table.put (largest_integer, name)
				id2name_array[largest_integer] := name
			end
		ensure
			largest_integer = old largest_integer
			or largest_integer = old largest_integer + 1
		end

	delete_name (name: STRING)
			-- delete the (name, id) pari from the hash table
			-- also, set id2name_array[id] to ""
		require
			check_length: name.count <= 100
		do
			if name2id_table.has (name) then
				id2name_array.item (name2id_table.item (name)) := ""
				name2id_table.remove (name)
			end
		ensure
			largest_integer = old largest_integer
		end

invariant
	largest_integer >= 0
end
