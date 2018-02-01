require './lib/node'
require 'pry'

class BinarySearchTree

  attr_reader :head

  def initialize
    @head = nil
  end

  def insert_head_node(score, title, parent = nil)
    @head = Node.new(score, title, @head)
  end

  def insert(score, title, parent = nil)
    if @head.nil?
      insert_head_node(score, title, parent)
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
      current_node.node_left = Node.new(score, title, current_node)
      @depth += 1
    else
      node_travel_direction(score, title, current_node)
    end
    @depth
  end

  def right_of_head(score, title, current_node)
    if current_node.node_right == nil
      current_node.node_right = Node.new(score, title, current_node)
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

  def load(file)
    movie_list = File.read(file).split(/\n/)
    movie_list.reduce(0) do |count, movie|
      movie_info = movie.split(", ")
      next if include?(movie_info[0].to_i)
      insert(movie_info[0].to_i, movie_info[1])
      count += 1
    end
  end

  def count(head = @head)
    return 0 if head.nil?
    count(head.node_left) + 1 + count(head.node_right)
  end

  def find_nodes_by_depth(depth, head = @head, nodes_at_depth = [])
    if depth > height
      "Incorrect depth value! Maximum depth of this tree is #{height}."
    elsif head.nil?
      return nodes_at_depth
    elsif depth == 0
      nodes_at_depth.push(head)
    else
      find_nodes_by_depth(depth - 1, head.node_left, nodes_at_depth)
      find_nodes_by_depth(depth - 1, head.node_right, nodes_at_depth)
    end
  end

  def health(depth)
    if depth > height
      "Incorrect depth value! Maximum depth of this tree is #{height}."
    else
      find_nodes_by_depth(depth).map do |node|
        number_child_nodes = count(head = node)
        [node.score, number_child_nodes, (number_child_nodes/
          count(@head).to_f * 100).floor]
        end
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

  def delete(input_node)
    return nil if include?(input_node) == false
    target_node = traverse_to_delete_node(input_node)
    if target_node.node_left.nil? && target_node.node_right.nil?
      both_nodes_are_nil(target_node)
    elsif target_node.node_left.nil?
      only_left_node_is_nil(target_node)
    elsif target_node.node_right.nil?
      only_right_node_is_nil(target_node)
    else
      current_node = target_node.node_right
      until current_node.node_left == nil do
        current_node = current_node.node_left
      end
      replacement_node = current_node
      assign_replacement_node_attributes(current_node, replacement_node, target_node)
      assign_parent_to_replacement_node(replacement_node, target_node)
      return_value = target_node.score
      target_node = nil
    end
    return_value
  end

  def both_nodes_are_nil(target_node)
    if target_node.parent.node_left = target_node
      target_node.parent.node_left = nil
    else
      target_node.parent.node_right = nil
    end
  end

  def only_left_node_is_nil(target_node)
    if target_node.parent.node_left = target_node
      target_node.parent.node_left = target_node.node_right
    else
      target_node.parent.node_right = target_node.node_right
    end
  end

  def only_right_node_is_nil(target_node)
    if target_node.parent.node_left = target_node
      target_node.parent.node_left = target_node.node_left
    else
      target_node.parent.node_right = target_node.node_left
    end
  end

  def assign_replacement_node_attributes(current_node, replacement_node, target_node)
    current_node = nil
    replacement_node.node_left = target_node.node_left
    replacement_node.node_right = target_node.node_right
    replacement_node.parent = target_node.parent
  end

  def assign_parent_to_replacement_node(replacement_node, target_node)
    if replacement_node.parent.node_left = replacement_node
      replacement_node.parent.node_left = nil
    else
      replacement_node.parent.node_right = nil
    end
    if target_node.parent.node_left = target_node
      target_node.parent.node_left = replacement_node
    else
      target_node.parent.node_right = replacement_node
    end
  end

  def traverse_to_delete_node(input_node, head = @head)
    if head.nil?
      nil
    elsif head.score == input_node
      head
    elsif input_node > head.score
      traverse_to_delete_node(input_node, head.node_right)
    else
      traverse_to_delete_node(input_node, head.node_left)
    end
  end

end
