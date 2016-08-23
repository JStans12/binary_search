require 'pry'

class Node
  attr_accessor :left, :right
  attr_reader :score, :movie

  # set left and right to nil for new nodes
  # later set directly to the child node (object)
  def initialize(score, movie)
    @score = score
    @movie = movie
    @left = nil
    @right = nil
  end

  # triggers only if the root is already set
  # is passed a depth variable and keeps track recursivly
  def insert_node(current_score, current_movie, depth)

    # ignore same scores
    return false if current_score == @score

    # either create node or run insert again on either side
    if current_score < @score
      if @left == nil
        @left = Node.new(current_score, current_movie)
        return depth
      else
        left.insert_node(current_score, current_movie, depth+1)
      end
    end

    if current_score > @score
      if @right == nil
        @right = Node.new(current_score, current_movie)
        return depth
      else
        right.insert_node(current_score, current_movie, depth+1)
      end
    end

  end # end insert_node

  def depth_of(check_score, depth)

    if check_score == @score
      return depth
    elsif left != nil && check_score < @score
      left.depth_of(check_score, depth+1)
    elsif right != nil && check_score > @score
      right.depth_of(check_score, depth+1)
    else
      return nil
    end

  end # end depth_of

end # end class

### ### ### ### ###

class BinarySearchTree
  attr_reader :root

  def initialize(root = nil)
    @root = root
  end

  # create root if necessary
  # otherwise pass to insert_node on the node object
  def insert_node(current_score, current_movie)
    if @root == nil
      @root = Node.new(current_score, current_movie)
      return 0 # return depth of zero
    else
      @root.insert_node(current_score, current_movie, 1)
    end
  end

  def depth_of(check_score)
    if @root == nil
      return nil
    else
      if check_score == @root.score
        return 0
      else
        @root.depth_of(check_score, 0)
      end
    end
  end

end # end class
