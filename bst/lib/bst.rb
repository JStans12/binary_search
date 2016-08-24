require "pry"

# the BinarySearchTree class holds the root node of the tree
# and is where all of the methods and functionality are defined.
# users don't interact with nodes, they interact with the tree.

class BinarySearchTree
  attr_reader :root
  attr_accessor :sorted

  def initialize(root = nil, sorted = [])
    @root = root
    @sorted = sorted
  end

  # the insert_node method is where the tree is built.
  # it takes in argument for current_node which changes as
  # recursion is used to move through the tree.
  def insert_node(input_score, input_movie, current_node = @root, depth = 1)

    # if this is the first node
    if @root == nil
      @root = Node.new(input_score, input_movie)
      return 0
    else

      # if another node is already using the input score
      return nil if input_score == current_node.score

      # insert node on the left or move to the left
      if input_score < current_node.score
        if current_node.left == nil
          current_node.left = Node.new(input_score, input_movie)
          return depth
        else
          self.insert_node(input_score, input_movie, current_node.left, depth + 1)
        end

      # insert node on the right or move to the right
      else
        if current_node.right == nil
          current_node.right = Node.new(input_score, input_movie)
          return depth
        else
          self.insert_node(input_score, input_movie, current_node.right, depth + 1)
        end
      end
    end

    # this commented out bit is a refactored version of insert_node
    # it returns more than just depth
    # could possibly be made to work

    # return 0 && @root = Node.new(input_score, input_movie, 0) if @root == nil
    #
    # return nil if input_score == current_node.score
    #
    # return depth && current_node.left = Node.new(input_score, input_movie, depth) if input_score < current_node.score && current_node.left == nil
    #
    # self.insert_node(input_score, input_movie, current_node.left, depth + 1) if input_score < current_node.score && current_node.left != nil
    #
    # return depth && current_node.right = Node.new(input_score, input_movie, depth) if input_score > current_node.score && current_node.right == nil
    #
    # self.insert_node(input_score, input_movie, current_node.right, depth + 1) if input_score > current_node.score && current_node.right != nil

  end # end insert_node


  def include?(input_score, current_node = @root)

    # should never look at a nil node if the tree contains input_score
    if current_node == nil
      return false
    else

      # return true if input_score is found
      if input_score == current_node.score
        return true

      # look at nodes on the left or the right
      elsif input_score < current_node.score
        self.include?(input_score, current_node.left)

      else
        self.include?(input_score, current_node.right)

      end
    end
  end # end include?


  def depth_of(input_score, current_node = @root, depth = 0)

    # if the input_score doesn't exist in the tree
    if current_node == nil
      return nil
    else

      # return depth when found
      if input_score == current_node.score
        return depth

      # move right or left to find just like include?
      elsif input_score < current_node.score
        self.depth_of(input_score, current_node.left, depth + 1)

      elsif input_score > current_node.score
        self.depth_of(input_score, current_node.right, depth + 1)

      end
    end
  end # end depth_of

  # only move right
  def max(current_node = @root)

    if current_node.right == nil
      return current_node.data
    else
      max(current_node.right)
    end

  end # end max

  #only move left
  def min(current_node = @root)

    if current_node.left == nil
      return current_node.data
    else
      min(current_node.left)
    end

  end # end min

  # Sort:
  # move left as far as possible
  # push to array
  # move right one node if possible
  # repeat
  # move backwards as method instances return and push nodes if needed
  # move right one node at a time
  # always checking if possible to move left
  def sort(current_node = @root)

    return @sorted if @root == nil

    if current_node.left != nil && @sorted.include?(current_node.left.data) == false
      sort(current_node.left)

      if @sorted.include?(current_node.data) == false
        @sorted << current_node.data
      end

    else
      @sorted << current_node.data
    end

    if current_node.right != nil && @sorted.include?(current_node.right.data) == false
      sort(current_node.right)
    end

    @sorted

  end # end sort

end # end BinarySearchTree
