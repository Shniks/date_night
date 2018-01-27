require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree'

class BinarySearchTreeTest < Minitest::Test

  def test_if_it_exists
    tree = BinarySearchTree.new

    assert_instance_of BinarySearchTree, tree
  end

  def test_if_head_node_is_initially_nil
    tree = BinarySearchTree.new

    assert_nil nil, tree.head
  end

end
