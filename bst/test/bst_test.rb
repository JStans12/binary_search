require './lib/bst.rb'
require './lib/node.rb'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'CSV'

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

  def test_include_a_lot
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

    assert tree.include?(50)
    assert tree.include?(45)
    assert tree.include?(55)
    assert tree.include?(60)
    assert tree.include?(11)
    assert tree.include?(85)
    assert tree.include?(53)
    assert tree.include?(12)
    assert tree.include?(54)
    assert tree.include?(59)
    assert tree.include?(47)
    assert tree.include?(46)
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

  ### max

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

  ### min

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

  ### sort

  def test_sort_for_one_node
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")

    assert_equal tree.sort, [{"james bond" => 50}]
  end

  def test_sort_to_the_right
    tree = BinarySearchTree.new
    tree.insert_node(45, "avitar")
    tree.insert_node(50, "james bond")

    assert_equal tree.sort, [{"avitar" => 45}, {"james bond" => 50}]
  end

  def test_sort_left_backtrack
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(11, "star wars")

    assert_equal tree.sort, [{"star wars" => 11}, {"avitar" => 45}, {"james bond" => 50}]
  end

  def test_sort_left_and_right
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")

    assert_equal tree.sort, [{"avitar" => 45}, {"james bond" => 50}, {"dig" => 55}]
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

    assert_equal tree.sort, [{"star wars" => 11}, {"avitar" => 45}, {"james bond" => 50}, {"i robot" => 53}, {"dig" => 55}, {"the hobbit" => 60}, {"mad max" => 85}]
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

    assert_equal tree.sort, [{"star wars" => 11}, {"sharknado" => 12}, {"avitar" => 45}, {"momento" => 46}, {"the shining" => 47}, {"james bond" => 50}, {"i robot" => 53}, {"fire walk with me" => 54}, {"dig" => 55}, {"cry baby" => 59}, {"the hobbit" => 60}, {"mad max" => 85}]
  end

  def test_sort_nothing
    tree = BinarySearchTree.new

    assert_equal tree.sort, []
  end

  ### load

  def test_load
    tree = BinarySearchTree.new
    tree.load("test/movies.txt")

    assert_equal tree.root.data, {"Hannibal Buress: Comedy Camisado" => 34}
    assert_equal tree.root.right.data, {"Meet My Valentine" => 63}
    assert_equal tree.root.left.data, {"Experimenter" => 22}
    assert_equal tree.root.right.right.data, {"French Dirty" => 84}
    assert_equal tree.root.right.left.data, {"Love" => 41}
    assert_equal tree.root.left.left.data, {"I Love You Phillip Morris" => 10}
  end

  ### health

  def test_health_at_root
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")

    assert_equal tree.health(0), [[50,1,100]]
  end

  def test_node_group_count
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")
    tree.insert_node(60, "the hobbit")
    tree.insert_node(11, "star wars")

    assert_equal tree.node_group_count(tree.root), 5
  end

  def test_healthy_as_fuck
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

    assert_equal tree.health(0), [[50,12,100]]
    assert_equal tree.health(1), [[45, 5, 38], [55, 6, 42]]
    assert_equal tree.health(2), [[11, 2, 13], [47, 2, 12], [53, 2, 11], [60, 3, 16]]
    assert_equal tree.health(3), [[12, 1, 5], [46, 1, 5], [54, 1, 4], [59, 1, 4], [85, 1, 4]]
    assert_equal tree.health(4), []
  end

  ### leaves

  def test_leaves_root_only
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")

    assert_equal tree.leaves, 1
  end

  def test_a_couple_leaves
    tree = BinarySearchTree.new
    tree.insert_node(50, "james bond")
    tree.insert_node(45, "avitar")
    tree.insert_node(55, "dig")

    assert_equal tree.leaves, 2
  end

  def test_bunch_o_leaves
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

    assert_equal tree.leaves, 5
  end

  ### height

   def test_height_at_node
     tree = BinarySearchTree.new
     tree.insert_node(50, "james bond")

     assert_equal tree.height, 0
   end

   def test_sooo_deeeeeep
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

     assert_equal tree.height, 3
   end

    def test_delete_at_root
      tree = BinarySearchTree.new
      tree.insert_node(50, "a")
      tree.insert_node(40, "b")
      tree.insert_node(60, "c")
      tree.insert_node(55, "d")
      tree.insert_node(45, "e")
      tree.insert_node(30, "f")
      tree.insert_node(70, "g")
      tree.insert_node(65, "h")
      tree.insert_node(35, "i")
      tree.insert_node(44, "j")
      tree.insert_node(46, "k")
      tree.insert_node(54, "l")
      tree.insert_node(56, "m")
      tree.insert_node(20, "n")
      tree.insert_node(80, "o")
      tree.delete(50)

      assert_equal tree.sort.length, 14
      assert_equal tree.root.right.score, 45
      assert_equal tree.root.right.right.right.score, 60
      assert_equal tree.root.left.right.score, 35
    end

    def test_delete_root_special_case
      tree = BinarySearchTree.new
      tree.insert_node(50, "a")
      tree.insert_node(40, "b")
      tree.delete(50)

      assert_equal tree.sort.length, 1
      assert_equal tree.root.score, 40
    end

    def test_delete_special_case_two
      tree = BinarySearchTree.new
      tree.insert_node(50, "a")
      tree.insert_node(60, "c")
      tree.delete(50)

      assert_equal tree.sort.length, 1
      assert_equal tree.root.score, 60
    end

    def test_deepest_right
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

      assert_equal tree.deepest_right(tree.root), tree.root.right.right.right
    end

    def test_try_to_break_delete
      tree = BinarySearchTree.new
      tree.insert_node(50, "a")
      tree.insert_node(40, "b")
      tree.insert_node(60, "c")
      tree.insert_node(55, "d")
      tree.insert_node(45, "e")
      tree.insert_node(30, "f")
      tree.insert_node(70, "g")
      tree.insert_node(65, "h")
      tree.insert_node(35, "i")
      tree.insert_node(44, "j")
      tree.insert_node(46, "k")
      tree.insert_node(54, "l")
      tree.insert_node(56, "m")
      tree.insert_node(20, "n")
      tree.insert_node(80, "o")
      tree.delete(40)

      assert_equal tree.sort.length, 14
      assert_equal tree.root.left.score, 30
      assert_equal tree.root.left.right.score, 35
      assert_equal tree.root.left.right.right.score, 45
      assert_equal tree.root.left.right.right.left.score, 44
    end

    def test_try_to_break_delete_part_two
      tree = BinarySearchTree.new
      tree.insert_node(50, "a")
      tree.insert_node(40, "b")
      tree.insert_node(60, "c")
      tree.insert_node(55, "d")
      tree.insert_node(45, "e")
      tree.insert_node(30, "f")
      tree.insert_node(70, "g")
      tree.insert_node(65, "h")
      tree.insert_node(35, "i")
      tree.insert_node(44, "j")
      tree.insert_node(46, "k")
      tree.insert_node(54, "l")
      tree.insert_node(56, "m")
      tree.insert_node(20, "n")
      tree.insert_node(80, "o")
      tree.delete(60)

      assert_equal tree.sort.length, 14
      assert_equal tree.root.right.score, 55
      assert_equal tree.root.right.right.score, 56
      assert_equal tree.root.right.right.right.score, 70
      assert_equal tree.root.right.left.score, 54
    end

end # end tests
