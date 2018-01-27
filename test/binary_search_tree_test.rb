require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree'

class BinarySearchTreeTest < Minitest::Test

  def setup
    @tree = BinarySearchTree.new
  end

  def test_if_it_exists
    assert_instance_of BinarySearchTree, @tree
  end

  def test_if_head_node_is_initially_nil
    assert_nil nil, @tree.head
  end

  def test_it_can_insert_first_node
    result = @tree.insert_first_node(61, "Bill & Ted's Excellent Adventure")

    assert_instance_of Node, result
    assert_equal 61, result.score
    assert_equal "Bill & Ted's Excellent Adventure", result.title
    assert_nil nil, result.node_left
    assert_nil nil, result.node_right
  end

  def test_it_can_insert_a_node
    result = @tree.insert(61, "Bill & Ted's Excellent Adventure")

    assert_equal 0, result
  end

end
