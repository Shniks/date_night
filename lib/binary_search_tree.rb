require './lib/node'
require 'pry'

class BinarySearchTree

  attr_reader :head

  def initialize
    @head = nil
  end

  def insert_head_node(score, title)
    @head = Node.new(score, title)
  end

  def insert(score, title)
    if @head.nil?
      insert_head_node(score, title)
      @depth = 0
    else
      current_node = @head
      @depth = 0
      score_direction(score, title, current_node)
    end
  end

  def score_direction(score, title, current_node)
    if score < current_node.score
      left_of_head(score, title, current_node)
    else
      right_of_head(score, title, current_node)
    end
  end

  def left_of_head(score, title, current_node)
    if current_node.node_left == nil
      current_node.node_left = Node.new(score, title)
      @depth += 1
    else
      node_travel_direction(score, title, current_node)
    end
    @depth
  end

  def right_of_head(score, title, current_node)
    if current_node.node_right == nil
      current_node.node_right = Node.new(score, title)
      @depth += 1
    else
      node_travel_direction(score, title, current_node)
    end
    @depth
  end

  def node_travel_direction(score, title, current_node)
    if score < current_node.score
      current_node = current_node.node_left
    else
      current_node = current_node.node_right
    end
    @depth += 1
    score_direction(score, title, current_node)
  end

  def include?(score, current_node = @head)
    if current_node.nil?
      false
    elsif score == current_node.score
      true
    else
      include_traverse(score, current_node)
    end
  end

  def include_traverse(score, current_node)
    if score > current_node.score
      include?(score, current_node.node_right)
    else
      include?(score, current_node.node_left)
    end
  end

  def depth_of(score, depth = 0, current_node = @head)
    if current_node.nil?
      nil
    elsif score == current_node.score
      depth
    else
      depth_of_traverse(score, depth, current_node)
    end
  end

  def depth_of_traverse(score, depth, current_node)
    if score > current_node.score
      depth += 1
      depth_of(score, depth, current_node.node_right)
    else
      depth += 1
      depth_of(score, depth, current_node.node_left)
    end
  end

  def min(current_node = @head)
    until current_node.node_left == nil do
      current_node = current_node.node_left
    end
    { current_node.title => current_node.score }
  end

  def max(current_node = @head)
    until current_node.node_right == nil do
      current_node = current_node.node_right
    end
    { current_node.title => current_node.score }
  end

  def sort
    current_node = duplicate_head = @head
    sorted_movies = []
    return sorted_movies if current_node.nil?
    sort_left_of_head(duplicate_head, sorted_movies)
    sorted_movies << { duplicate_head.title => duplicate_head.score }
    sort_right_of_head(duplicate_head, sorted_movies)
    sorted_movies
  end

  def sort_left_of_head(duplicate_head, sorted_movies)
    current_node = duplicate_head
    until duplicate_head.node_left == nil do
      until current_node.node_left.node_left == nil do
        current_node = current_node.node_left
      end
      sorted_movies << { current_node.node_left.title => current_node.node_left.score }
      point_parents_node_left_to_childs_right_side_node(duplicate_head, current_node)
      sort_left_of_head(duplicate_head, sorted_movies)
    end
  end

  def point_parents_node_left_to_childs_right_side_node(duplicate_head, current_node)
    if current_node.node_left.node_right != nil
      current_node.node_left = current_node.node_left.node_right
    else
      current_node.node_left = nil
    end
  end

  def sort_right_of_head(duplicate_head, sorted_movies)
    current_node = duplicate_head
    until duplicate_head.node_right == nil do
      duplicate_head = duplicate_head.node_right
      sort_left_of_head(duplicate_head, sorted_movies)
      sorted_movies << { duplicate_head.title => duplicate_head.score }
    end
  end

  def load
    movie_list = File.read('./movies.txt').split(/\r\n/)
    movie_list.reduce(0) do |count, movie|
      movie_info = movie.split(", ")
      next if include?(movie_info[0].to_i)
      insert(movie_info[0].to_i, movie_info[1])
      count += 1
    end
  end

  def health()

  end

end
