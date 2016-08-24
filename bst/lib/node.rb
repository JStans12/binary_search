class Node
  attr_reader :data
  attr_accessor :left, :right

  def initialize(score, movie)
    @data = {movie => score}
    @left = left
    @right = right
  end

  def score
    @data.values[0]
  end

end
