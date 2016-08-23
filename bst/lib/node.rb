class Node
  attr_reader :score, :movie
  attr_accessor :left, :right, :depth

  def initialize(score, movie, depth = 0)
    @score = score
    @movie = movie
    @left = left
    @right = right
    @depth = depth
  end

end
