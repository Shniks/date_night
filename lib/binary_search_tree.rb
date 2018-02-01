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
    sort_subtree(@head).map do |node|
      {node.title => node.score}
    end
  end

  def sort_subtree(head)
    return [] if head.nil?
    if head.node_left && head.node_right
      [sort_subtree(head.node_left), head,
        sort_subtree(head.node_right)].flatten
    elsif head.node_right.nil?
      [sort_subtree(head.node_left), head].flatten
    elsif head.node_left.nil?
      [head, sort_subtree(head.node_right)].flatten
    else
      [head]
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

  def height(head = @head)
    return -1 if head.nil?
    if height(head.node_left) > height(head.node_right)
      return height(head.node_left) + 1
    else
      return height(head.node_right) + 1
    end
  end

  def leaves(head = @head)
    return 0 if head.nil?
    if head.node_left.nil? && head.node_right.nil?
      return 1
    else
      return leaves(head.node_left) + leaves(head.node_right)
    end
  end

  def count(head = @head)
    unless head.nil?
      count(head.node_left) + 1 + count(head.node_right)
    else
      0
    end
  end

  #
  # def health(depth)
  #   if depth == 0
  #     [[head.score, number_of_child_nodes, percent]]
  #   end
  # end

end
