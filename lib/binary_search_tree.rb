require 'pry'

class BinarySearchTree

  def initialize
    @head = nil
    @depth = nil
  end

  def insert_first_node(score, title)
    @head = Node.new(score, title)
  end

  def insert(score, title)
    if @head.nil?
      insert_first_node(score, title)
      @depth = 0
    else
      score_direction(score, title)
    end
  end

  def score_direction(score, title)
    @current_node = @head
    @depth = 0
    if score < @current_node.score
      score_left(score, title)
    else
      score_right(score, title)
    end
  end

  def score_left(score, title)
    while @current_node.node_left != nil
      @current_node = @current_node.node_left
      @depth += 1
    end
    @current_node.node_left = Node.new(score, title)
    @depth += 1
  end

  def score_right(score, title)
    while @current_node.node_right != nil
      @current_node = @current_node.node_right
      @depth += 1
    end
    @current_node.node_right = Node.new(score, title)
    @depth += 1
  end





end
