class Node

  attr_reader   :score,
                :title
  attr_accessor :node_left,
                :node_right

  def initialize (score, title)
    @score      = score
    @title      = title
    @node_left  = nil
    @node_right = nil
  end

end
