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
    @current_node = @head
    sorted_movies = []
    return sorted_movies if @current_node.nil?
    sort_left_of_head(sorted_movies)
    sorted_movies << { @head.title => @head.score }
    sort_right_of_head(sorted_movies)
    sorted_movies
  end

  def sort_left_of_head(sorted_movies)
    current_node = @head
    until @head.node_left == nil do
      until current_node.node_left.node_left == nil do
        current_node = current_node.node_left
      end
      sorted_movies << { current_node.node_left.title => current_node.node_left.score }
      point_parent_node_to_right_side_node(current_node)
      sort_left_of_head(sorted_movies)
    end
  end

  def point_parent_node_to_right_side_node(current_node)
    if current_node.node_left.node_right != nil
      current_node.node_left = current_node.node_left.node_right
    else
      current_node.node_left = nil
    end
  end

  def sort_right_of_head(sorted_movies)
    current_node = @head
    until @head.node_right == nil do
      @head = @head.node_right
      sort_left_of_head(sorted_movies)
      sorted_movies << { @head.title => @head.score }
    end
  end

  def height
    @depth_values.values.max
  end

end
