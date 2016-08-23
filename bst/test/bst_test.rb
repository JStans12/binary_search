require './lib/bst.rb'
require './lib/node.rb'
require "minitest/autorun"
require "minitest/pride"

class BinarySearchTest < Minitest::Test

  ### insert_node

  def test_if_root_node_is_inserted
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")

    assert_equal tree.root.score, 50
  end

  def test_insert_on_left
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")

    assert_equal tree.root.left.score, 45
  end

  def test_insert_on_right
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")

    assert_equal tree.root.right.score, 55
  end

  def test_insert_a_whole_bunch
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")
    tree.insert_node(60, "the hobbit")
    tree.insert_node(11, "star wars")
    tree.insert_node(85, "mad max")
    tree.insert_node(53, "i robot")

    assert_equal tree.root.score, 50
    assert_equal tree.root.left.score, 45
    assert_equal tree.root.right.score, 55
    assert_equal tree.root.right.right.score, 60
    assert_equal tree.root.left.left.score, 11
    assert_equal tree.root.right.right.right.score, 85
    assert_equal tree.root.right.left.score, 53
  end

  def test_nil_if_same_score
    tree = BinarySearchTree.new

    assert_equal tree.insert_node(50, "james bond"), 0
    assert_equal tree.insert_node(45, "avitar"), 1
    assert_equal tree.insert_node(50, "dig"), nil
    assert_equal tree.insert_node(45, "the hobbit"), nil
  end

  def test_return_depth
    tree = BinarySearchTree.new

    assert_equal tree.insert_node(50, "james bond"), 0
    assert_equal tree.insert_node(45, "avitar"), 1
    assert_equal tree.insert_node(55, "dig"), 1
    assert_equal tree.insert_node(60, "the hobbit"), 2
    assert_equal tree.insert_node(11, "star wars"), 2
    assert_equal tree.insert_node(85, "mad max"), 3
    assert_equal tree.insert_node(53, "i robot"), 2
  end

  ### include

  def test_include
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")

    assert tree.include?(50)
    assert tree.include?(45)
    assert tree.include?(55)
    refute tree.include?(91)
    refute tree.include?(15)
  end

  ### depth_of

  def test_depth_of_on_root
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")

    assert_equal tree.depth_of(50), 0
  end

  def test_more_depth_of
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")
    tree.insert_node(60, "the hobbit")
    tree.insert_node(11, "star wars")
    tree.insert_node(85, "mad max")
    tree.insert_node(53, "i robot")

    assert_equal tree.depth_of(50), 0
    assert_equal tree.depth_of(45), 1
    assert_equal tree.depth_of(55), 1
    assert_equal tree.depth_of(60), 2
    assert_equal tree.depth_of(11), 2
    assert_equal tree.depth_of(85), 3
    assert_equal tree.depth_of(53), 2
    assert_equal tree.depth_of(21), nil
    assert_equal tree.depth_of(88), nil
  end

end # end tests
