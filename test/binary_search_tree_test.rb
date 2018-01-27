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
    assert_nil nil, @head
  end

  def test_it_can_insert_head_node
    result = @tree.insert_head_node(61, "Bill & Ted's Excellent Adventure")

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

  def test_it_can_insert_a_second_node_to_the_left
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    result = @tree.insert(16, "Johnny English")

    assert_equal 1, result
  end

  def test_it_can_insert_a_third_node_to_the_right
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    result = @tree.insert(92, "Sharknado 3")

    assert_equal 1, result
  end

  def test_it_can_insert_a_fourth_node
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    result = @tree.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal 2, result
  end

  def test_it_can_insert_a_tenth_node
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")
    @tree.insert(40, "Transformers1")
    @tree.insert(45, "Transformers2")
    @tree.insert(55, "Transformers3")
    @tree.insert(94, "Transformers4")
    @tree.insert(90, "Transformers5")
    result = @tree.insert(35, "Transformers6")

    assert_equal 4, result
  end

  def test_it_can_insert_a_twelfth_node
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")
    @tree.insert(40, "Transformers1")
    @tree.insert(45, "Transformers2")
    @tree.insert(55, "Transformers3")
    @tree.insert(94, "Transformers4")
    @tree.insert(90, "Transformers5")
    @tree.insert(35, "Transformers6")
    @tree.insert(98, "Transformers7")
    result = @tree.insert(70, "Transformers8")

    assert_equal 3, result
  end

  def test_it_can_find_movie_with_max_score
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")
    expected = {"Sharknado 3"=>92}

    assert_equal expected, @tree.max
  end

  def test_it_finds_another_movie_with_max_score
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")
    @tree.insert(40, "Transformers1")
    @tree.insert(45, "Transformers2")
    @tree.insert(55, "Transformers3")
    @tree.insert(94, "Transformers4")
    @tree.insert(90, "Transformers5")
    @tree.insert(35, "Transformers6")
    @tree.insert(98, "Transformers7")
    @tree.insert(70, "Transformers8")
    expected = {"Transformers7"=>98}

    assert_equal expected, @tree.max
  end

  def test_it_can_find_movie_with_min_score
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")
    expected = {"Johnny English"=>16}

    assert_equal expected, @tree.min
  end

  def test_it_finds_another_movie_with_min_score
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")
    @tree.insert(40, "Transformers1")
    @tree.insert(45, "Transformers2")
    @tree.insert(16, "Johnny English")
    @tree.insert(55, "Transformers3")
    @tree.insert(8, "Transformers7")
    @tree.insert(94, "Transformers4")
    @tree.insert(90, "Transformers5")
    @tree.insert(35, "Transformers6")
    @tree.insert(70, "Transformers8")
    expected = {"Transformers7"=>8}

    assert_equal expected, @tree.min
  end

end
