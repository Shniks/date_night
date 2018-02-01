require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test

  def setup
    @node = Node.new(92, "Sharknado 3")
  end

  def test_if_it_exists
    assert_instance_of Node, @node
  end

  def test_node_can_return_score
    assert_equal 92, @node.score
  end

  def test_node_can_return_title
    assert_equal "Sharknado 3", @node.title
  end

  def test_node_initialized_with_nil_left_next_node
    assert_nil nil, @node.node_left
  end

  def test_node_initialized_with_nil_right_next_node
    assert_nil nil, @node.node_right
  end

  def test_node_has_a_parent
    assert_nil nil, @node.parent
  end

end
