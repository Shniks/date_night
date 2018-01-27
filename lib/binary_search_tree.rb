require 'pry'

class BinarySearchTree

  def initialize
    @head = nil
    @depth = nil  #Do I even need this here since I have instance variables below?
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
      score_left(score, title)
    else
      score_right(score, title)
    end
  end

  def node_travel_direction(score, title)
    if score < @current_node.score
      @current_node = @current_node.node_left
    else
      @current_node = @current_node.node_right
    end
      score_direction(score, title)
  end

  def node_insert_direction(score, title)
    if score < @current_node.score
      @current_node.node_left = Node.new(score, title)
    else
      @current_node.node_right = Node.new(score, title)
    end
  end

  def score_left(score, title)
    if @current_node.node_left == nil
      @current_node.node_left = Node.new(score, title)
      @depth += 1
    else
      node_travel_direction(score, title)
    end
    @depth
  end

  def score_right(score, title)
    if @current_node.node_right == nil
      @current_node.node_right = Node.new(score, title)
      @depth += 1
    else
    node_insert_direction(score, title)
    end
    @depth
  end

  # def score_left(score, title)
  #   while @current_node.node_left != nil
  #     node_travel_direction(score, title)
  #     @depth += 1
  #   end
  #   node_insert_direction(score, title)
  #   @depth += 1
  # end
  #
  # def score_right(score, title)
  #   while @current_node.node_right != nil
  #     node_travel_direction(score, title)
  #     @depth += 1
  #   end
  #   node_insert_direction(score, title)
  #   @depth += 1
  # end

end
