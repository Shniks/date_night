require 'pry'

class BinarySearchTree

  def initialize
    @head = nil
    @depth = nil
  end

  def insert_first_node(score, title)
    @head = Node.new(score, title)
  end

  def score_left
    while @current_node.node_left != nil
      @current_node = @current_node.node_left
    end
    @depth += 1
  end

  def score_right
    while @current_node.node_right != nil
      @current_node = @current_node.node_right
    end
    @depth += 1
  end

  def score_direction(score, title)
    @current_node = @head
    if score < @current_node.score
      score_left
    else
      score_right
    end
    @depth
  end

  def insert(score, title)
    if @head.nil?
      insert_first_node(score, title)
      @depth = 0
    else
      score_direction(score, title)
    end
  end



end
