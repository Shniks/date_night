require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree'

class BinarySearchTreeTest < Minitest::Test

  def setup
    @tree = BinarySearchTree.new
    @movies_list = { 61 => ["Bill & Ted's Excellent Adventure", 0],
    16 => ["Johnny English", 1], 92 => ["Sharknado 3", 1],
    50 => ["Hannibal Buress: Animal Furnace", 2], 40 => ["Transformers1", 3],
    45 => ["Transformers2", 4], 55 => ["Transformers3", 3],
    94 => ["Transformers4", 2], 90 => ["Transformers5", 2],
    35 => ["Transformers6", 4], 98 => ["Transformers7", 3],
    70 => ["Transformers8", 3] }
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

  def test_it_can_insert_and_find_depth_of_a_node
    result = @tree.insert(61, "Bill & Ted's Excellent Adventure")

    assert_equal 0, result
    refute_equal 1, result
  end

  def test_it_can_insert_and_find_depth_of_a_second_node_to_the_left
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    result = @tree.insert(16, "Johnny English")

    assert_equal 1, result
    refute_equal 0, result
  end

  def test_it_can_insert_and_find_depth_of_a_third_node_to_the_right
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    result = @tree.insert(92, "Sharknado 3")

    assert_equal 1, result
    refute_equal 2, result
  end

  def test_it_can_insert_and_find_depth_of_a_fourth_node
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    result = @tree.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal 2, result
    refute_equal 3, result
  end

  def test_it_can_find_depth_of_each_movie_when_inserting_twelve_movies
    @movies_list.each do |key, value|
      result = @tree.insert(key, value[0])
      assert_equal value[1], result
    end
  end

  def test_it_can_find_depth_of_any_movie
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")

    assert_nil nil, @tree.depth_of(nil)
    assert_equal 1, @tree.depth_of(92)
    refute_equal 2, @tree.depth_of(92)
    assert_equal 2, @tree.depth_of(50)
    refute_equal 3, @tree.depth_of(50)
  end

  def test_it_can_find_movie_with_max_score
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")
    expected = {"Sharknado 3"=>92}

    assert_equal expected, @tree.max
  end

  def test_it_finds_movie_with_max_score_among_twelve_movies
    @movies_list.each do |key, value|
      result = @tree.insert(key, value[0])
    end
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

  def test_it_finds_movie_with_min_score_among_twelve_movies
    @movies_list.each do |key, value|
      result = @tree.insert(key, value[0])
    end
    expected = {"Johnny English"=>16}

    assert_equal expected, @tree.min
  end

end
