note
	description: "Class to handle cycle detection and topo sort."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALGORITHM

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create dfs_visited.make_empty
			create dfs_parent.make_empty
			create dfs_stack.make
			create dfs_cycle_elements.make

			create sorted_list.make
			create predecessor_count.make_empty
		end

feature {AUTO_TASK} -- Cycle Detection

	cycle_detection_initialize (graph: DIRECTED_GRAPH)
		do
			create dfs_visited.make(1, graph.largest_node)
			create dfs_parent.make(1, graph.largest_node)
			create dfs_stack.make
			create dfs_cycle_elements.make
		end

	dfs_visited: ARRAY [BOOLEAN]
	dfs_parent: ARRAY [INTEGER]
	dfs_stack: LINKED_LIST [INTEGER]
	dfs_cycle_elements: LINKED_LIST [INTEGER]

	cycle_detection (graph: DIRECTED_GRAPH): LINKED_LIST [INTEGER]
			-- check whether the graph contains a cycle
			-- with Depth First Search
			-- (return a linked list of node (INTEGER) if cycle found)
			-- (return an empty linked list if no cycle found)
		local
			node: INTEGER
			dfs_result: BOOLEAN
		do
			cycle_detection_initialize (graph)
			from
				node := 1
				dfs_result := false
			until
				node > graph.largest_node or dfs_result
			loop
				if not graph.deleted[node] and not dfs_visited[node] then
					dfs_result := depth_first_search(graph, node)
				end
				node := node + 1
			end

			Result := dfs_cycle_elements
		ensure
			result_not_void: Result /= Void
		end

	depth_first_search (graph: DIRECTED_GRAPH; node: INTEGER): BOOLEAN
			-- find cycle in the directed graph
			-- recursively using Depth First Search
			-- (return true if found)
		do
--			print("DFS: ")
--			print(node)
--			print("%N")
			dfs_visited[node] := true
			dfs_stack.extend(node)
			Result := false

			across graph.successors[node] as successor_iter
			loop
--				print("successor: ")
--				print(successor_iter.item)
--				print("%N")
				if Result = false then
					-- print("HERE: cycle not found%N")
					if dfs_visited[successor_iter.item] = true then
						-- cycle found
						print("HERE: cycle found!%N")
						from
							dfs_stack.start
						until
							dfs_stack.item = successor_iter.item
						loop
							dfs_stack.forth
						end

						from
						until
							dfs_stack.exhausted
						loop
							dfs_cycle_elements.extend(dfs_stack.item)
							dfs_stack.forth
						end

						Result := true
					else
						if graph.deleted[node] = false then
							-- print("HERE: dfs deeper%N")
							Result := Result or depth_first_search(graph, successor_iter.item)
						end
					end
				end
			end
			dfs_stack.finish
			dfs_stack.remove
		end

feature {AUTO_TASK} -- Topological Sort

	sorted_list: LINKED_LIST [INTEGER]
	predecessor_count: ARRAY [INTEGER]

	topo_sort_initialize (graph: DIRECTED_GRAPH)
		do
			create sorted_list.make
			create predecessor_count.make(1, graph.largest_node)

			-- compute predecessor_count array
			across graph.successors as predecessor_iter
			loop
				if not graph.deleted[predecessor_iter.target_index] then
					across graph.successors[predecessor_iter.target_index]
					as successor_iter
					loop
						predecessor_count[successor_iter.item]:=predecessor_count[successor_iter.item]+1
					end
				end
			end

			-- initialize sorted_list
			across predecessor_count as successor_iter
			loop
--				print(successor_iter.target_index.out + "]: " + successor_iter.item.out)
--				print("%N")
				if not graph.deleted[successor_iter.target_index]
				and successor_iter.item = 0 then
					sorted_list.extend(successor_iter.target_index)
				end
			end
		end

	topo_sort (graph: DIRECTED_GRAPH): LINKED_LIST [INTEGER]
			-- topological sort based on Kahn's algorithm
		do
			topo_sort_initialize (graph)
			from
				sorted_list.start
			until
				sorted_list.exhausted
			loop
				-- take sorted_list.item as precedessor
				across graph.successors[sorted_list.item]
				as successor_iter
				loop
					predecessor_count[successor_iter.item] := predecessor_count[successor_iter.item] - 1
					if predecessor_count[successor_iter.item] = 0 then
						sorted_list.extend(sorted_list.item)
					end
				end

				sorted_list.forth
			end

			Result := sorted_list
		ensure
			result_not_void: Result /= Void
		end

end
