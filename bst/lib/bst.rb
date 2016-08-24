require "pry"

class BinarySearchTree
  attr_reader :root
  attr_accessor :sorted

  def initialize(root = nil, sorted = [])
    @root = root
    @sorted = sorted
  end

  def insert_node(input_score, input_movie, current_node = @root, depth = 1)

    # this commented out bit is a refactored version of insert_node
    # it returns more than just depth

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

    if @root == nil
      @root = Node.new(input_score, input_movie, 0)
      return 0
    else

      return nil if input_score == current_node.score

      if input_score < current_node.score
        if current_node.left == nil
          current_node.left = Node.new(input_score, input_movie, depth)
          return depth
        else
          self.insert_node(input_score, input_movie, current_node.left, depth + 1)
        end

      else
        if current_node.right == nil
          current_node.right = Node.new(input_score, input_movie, depth)
          return depth
        else
          self.insert_node(input_score, input_movie, current_node.right, depth + 1)
        end
      end
    end
  end # end insert_node

  def include?(input_score, current_node = @root)

    if current_node == nil
      return false
    else

      if input_score == current_node.score
        return true

      elsif input_score < current_node.score
        self.include?(input_score, current_node.left)

      elsif input_score > current_node.score
        self.include?(input_score, current_node.right)

      else
        return false
      end
    end
  end # end include?

  def depth_of(input_score, current_node = @root)

    if current_node == nil
      return nil
    else

      if input_score == current_node.score
        return current_node.depth

      elsif input_score < current_node.score
        self.depth_of(input_score, current_node.left)

      elsif input_score > current_node.score
        self.depth_of(input_score, current_node.right)

      else
        return nil
      end
    end
  end # end depth_of

  def max(current_node = @root)

    if current_node.right == nil
      return {current_node.movie => current_node.score}
    else
      max(current_node.right)
    end

  end # end max

  def min(current_node = @root)

    if current_node.left == nil
      return {current_node.movie => current_node.score}
    else
      min(current_node.left)
    end

  end # end min

  def sort(current_node = @root)

    if current_node.left != nil && @sorted.include?({current_node.left.movie => current_node.left.movie}) == false
      sort(current_node.left)

      if @sorted.include?({current_node.movie => current_node.score}) == false
        @sorted << {current_node.movie => current_node.score}
      end

    else
      @sorted << {current_node.movie => current_node.score}
    end

    if current_node.right != nil && @sorted.include?({current_node.right.movie => current_node.right.movie}) == false
      sort(current_node.right)
    end

  end # end sort

end # end BinarySearchTree
