# To generate makefiles for example 4 & 5
# The generated dependencies will not contain any cycle!

import random

ALPHABET = "abcdefghijklmnopqrstuvwxyz"

def random_string(strlen):
 	result = ""
 	for i in range(strlen):
		result += random.choice(ALPHABET)

	return result

def generate_unique_element_name_list(num_elements):
	generated = {}
	elements = []
	for count in range(num_elements):
		new_element_name = random_string(5)
		while generated.get(new_element_name, False):
			new_element_name = random_string(5)
		elements.append(new_element_name)
		generated[new_element_name] = True
	return elements

def generate_unique_constraints(num_elements, num_constraints):
	# return a 2D array of intergers
	dependencies = [[] for count in range(num_elements)]
	generated = {}
	for count in range(num_constraints):
		id1 = random.randint(0, num_elements-1)
		id2 = random.randint(0, num_elements-1)
		while id1 == id2 or generated.get((min(id1,id2), max(id1,id2)), False):
			id1 = random.randint(0, num_elements-1)
			id2 = random.randint(0, num_elements-1)
		# by using min() and max, we can obtain dependencies without cycles
		dependencies[min(id1, id2)].append(max(id1, id2))

		generated[(min(id1,id2), max(id1,id2))] = True # mark as generated
	return dependencies

def generate(num_elements, num_constraints, file_name):
	elements = generate_unique_element_name_list(num_elements)
	dependencies = generate_unique_constraints(num_elements, num_constraints)
	# "constraints" is 2D array of integers
	myfile = open(file_name, 'w')
	for i in range(num_elements):
		myfile.write(elements[i] + ':')
		for j in dependencies[i]:
			myfile.write(" " + elements[j])
		myfile.write("\n")

random.seed(0)
generate(200, 1000, 'input_makefile_example_4.txt')
generate(2000, 100000, 'input_makefile_example_5.txt')


