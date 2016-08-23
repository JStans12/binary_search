require './lib/bst_insert_in_node.rb'

tree = BinarySearchTree.new
p tree.insert_node(50, "james bond")
p tree.insert_node(60, "the hobbit")
p tree.insert_node(11, "star wars")
p tree.insert_node(85, "mad max")
p tree.insert_node(53, "i robot")
p tree.root.score
p tree.root.right.movie
p tree.root.left.score
p tree.root.right.right.movie
p tree.root.right.left.score
p tree.depth_of(50)
p tree.depth_of(60)
p tree.depth_of(85)
