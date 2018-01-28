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

  def include?(score)
    return true if @depth_values.keys.include?(score)
    false
  end

  def depth_of(score)
    return nil if score.nil?
    @depth_values[score]
  end

  def min
    @current_node = @head
    until @current_node.node_left == nil do
      @current_node = @current_node.node_left
    end
    { @current_node.title => @current_node.score }
  end

  def max
    @current_node = @head
    until @current_node.node_right == nil do
      @current_node = @current_node.node_right
    end
    { @current_node.title => @current_node.score }
  end

  def sort
    sorted_movies = []
    sort_left_of_head(sorted_movies)
    sorted_movies << { @head.title => @head.score }
    sort_right_of_head(sorted_movies)
    sorted_movies
  end

  def sort_left_of_head
    # Call the min method and put the last value in the array
    # Per the min method, the last value is now the current node
    # Check to see if the right node is nil
    # If not, then move one to the right and make that current node
    # Call min method again (recursion)
    # Check to see if the right node is nil
    # If nil, move up one node
    # Not sure how to do this for multiple branches
    # Also how does one move up one node (we have a node_next, but no node
    # previous) - maybe if the current_node.next_node.next_node is nil,
    # then can do previous_node = current_node?
  end


end
