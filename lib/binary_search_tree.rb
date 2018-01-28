require 'pry'

class BinarySearchTree

  def initialize
    @head = nil
    @depth_values = {}
  end

  def insert_head_node(score, title)
    @head = Node.new(score, title)
  end

  def insert(score, title)
    if @head.nil?
      insert_head_node(score, title)
      @depth = 0
    else
      @current_node = @head
      @depth = 0
      score_direction(score, title)
    end
  end

  def score_direction(score, title)
    if score < @current_node.score
      left_of_head(score, title)
    else
      right_of_head(score, title)
    end
  end

  def left_of_head(score, title)
    if @current_node.node_left == nil
      @current_node.node_left = Node.new(score, title)
      @depth += 1
    else
      node_travel_direction(score, title)
    end
    @depth_values[score] = @depth
    @depth
  end

  def right_of_head(score, title)
    if @current_node.node_right == nil
      @current_node.node_right = Node.new(score, title)
      @depth += 1
    else
      node_travel_direction(score, title)
    end
    @depth_values[score] = @depth
    @depth
  end

  def node_travel_direction(score, title)
    if score < @current_node.score
      @current_node = @current_node.node_left
    else
      @current_node = @current_node.node_right
    end
    @depth += 1
    score_direction(score, title)
  end

  def depth_of(score)
    return nil if score.nil?
    @depth_values[score]
  end
    
  def max
    @current_node = @head
    until @current_node.node_right == nil do
      @current_node = @current_node.node_right
    end
    { @current_node.title => @current_node.score }
  end

  def min
    @current_node = @head
    until @current_node.node_left == nil do
      @current_node = @current_node.node_left
    end
    { @current_node.title => @current_node.score }
  end

end
