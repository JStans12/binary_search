require './lib/bst.rb'
require './lib/node.rb'
require "minitest/autorun"
require "minitest/pride"
require 'pry'

class BinarySearchTest < Minitest::Test

  ### insert_node

  def test_if_root_node_is_inserted
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")

    assert_equal tree.root.score, 50
  end

  def test_if_new_insert_already_exists
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")

    assert_equal tree.insert_node(50, "james bod"), nil
  end

  def test_insert_on_left
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")

    assert_equal tree.root.left.score, 45
  end

  def test_insert_two_on_left
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(11, "star wars")

    assert_equal tree.root.left.left.score, 11
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

  def test_max_at_root
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")

    assert_equal tree.max, {"james bond" => 50}
  end

  def test_max_full
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")
    tree.insert_node(60, "the hobbit")
    tree.insert_node(11, "star wars")
    tree.insert_node(85, "mad max")
    tree.insert_node(53, "i robot")

    assert_equal tree.max, {"mad max" => 85}
  end

  def test_min_at_root
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")

    assert_equal tree.max, {"james bond" => 50}
  end

  def test_min_full
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")
    tree.insert_node(60, "the hobbit")
    tree.insert_node(11, "star wars")
    tree.insert_node(85, "mad max")
    tree.insert_node(53, "i robot")

    assert_equal tree.min, {"star wars" => 11}
  end

  def test_sort_for_one_node
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.sort

    assert_equal tree.sorted, [{"james bond" => 50}]
  end

  def test_sort_to_the_right
    tree = BinarySearchTree.new
    tree.insert_node(45, "avitar")
    tree.insert_node(50, "james bond")
    tree.sort

    assert_equal tree.sorted, [{"avitar" => 45}, {"james bond" => 50}]
  end

  def test_sort_left_backtrack
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(11, "star wars")
    tree.sort

    assert_equal tree.sorted, [{"star wars" => 11}, {"avitar" => 45}, {"james bond" => 50}]
  end

  def test_sort_left_and_right
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")
    tree.sort

    assert_equal tree.sorted, [{"avitar" => 45}, {"james bond" => 50}, {"dig" => 55}]
  end

  def test_sort_does_this_actually_work_wtf
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")
    tree.insert_node(60, "the hobbit")
    tree.insert_node(11, "star wars")
    tree.insert_node(85, "mad max")
    tree.insert_node(53, "i robot")
    tree.sort

    assert_equal tree.sorted, [{"star wars" => 11}, {"avitar" => 45}, {"james bond" => 50}, {"i robot" => 53}, {"dig" => 55}, {"the hobbit" => 60}, {"mad max" => 85}]
  end

  def test_sort_this_cannot_possibly_be_the_answer
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")
    tree.insert_node(60, "the hobbit")
    tree.insert_node(11, "star wars")
    tree.insert_node(85, "mad max")
    tree.insert_node(53, "i robot")
    tree.insert_node(12, "sharknado")
    tree.insert_node(54, "fire walk with me")
    tree.insert_node(59, "cry baby")
    tree.insert_node(47, "the shining")
    tree.insert_node(46, "momento")
    tree.sort

    assert_equal tree.sorted, [{"star wars" => 11}, {"sharknado" => 12}, {"avitar" => 45}, {"momento" => 46}, {"the shining" => 47}, {"james bond" => 50}, {"i robot" => 53}, {"fire walk with me" => 54}, {"dig" => 55}, {"cry baby" => 59}, {"the hobbit" => 60}, {"mad max" => 85}]
  end

end # end tests
