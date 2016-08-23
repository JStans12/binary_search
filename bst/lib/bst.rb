require "pry"

class BinarySearchTree
  attr_reader :root

  def initialize(root = nil)
    @root = root
  end

  def insert_node(insert_score, insert_movie, current_node = @root, depth = 1)

    if @root == nil
      @root = Node.new(insert_score, insert_movie, 0)
      return 0
    else

      return nil if insert_score == current_node.score

      if insert_score < current_node.score
        if current_node.left == nil
          current_node.left = Node.new(insert_score, insert_movie, depth)
          return depth
        else
          self.insert_node(insert_score, insert_movie, current_node.left, depth + 1)
        end

      else
        if current_node.right == nil
          current_node.right = Node.new(insert_score, insert_movie, depth)
          return depth
        else
          self.insert_node(insert_score, insert_movie, current_node.right, depth + 1)
        end
      end
    end
  end # end insert_node

  def include?(check_score, current_node = @root)

    if current_node == nil
      return false
    else

      if check_score == current_node.score
        return true

      elsif check_score < current_node.score
        self.include?(check_score, current_node.left)

      elsif check_score > current_node.score
        self.include?(check_score, current_node.right)

      else
        return false
      end
    end
  end # end include?

  def depth_of(check_score, current_node = @root)

    if current_node == nil
      return nil
    else

      if check_score == current_node.score
        return current_node.depth

      elsif check_score < current_node.score
        self.depth_of(check_score, current_node.left)

      elsif check_score > current_node.score
        self.depth_of(check_score, current_node.right)

      else
        return nil
      end
    end
  end # end depth_of

end # end BinarySearchTree
