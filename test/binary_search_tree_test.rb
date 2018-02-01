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

  def test_it_can_verify_presence_of_score_in_the_tree
    @movies_list.each do |key, value|
      result = @tree.insert(key, value[0])
    end

    assert @tree.include?(16)
    assert @tree.include?(50)
    assert @tree.include?(35)
    assert @tree.include?(98)
    refute @tree.include?(72)
    refute @tree.include?(37)
    refute @tree.include?(-22)
  end

  def test_it_can_find_depth_of_any_movie
    @movies_list.each do |key, value|
      result = @tree.insert(key, value[0])
    end

    assert_equal 1, @tree.depth_of(92)
    refute_equal 2, @tree.depth_of(92)
    assert_equal 2, @tree.depth_of(50)
    refute_equal 3, @tree.depth_of(-50)
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
      @tree.insert(key, value[0])
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
      @tree.insert(key, value[0])
    end
    expected = {"Johnny English"=>16}

    assert_equal expected, @tree.min
  end

  def test_it_can_sort_the_tree_with_four_values
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")
    expected = [{"Johnny English"=>16},
    {"Hannibal Buress: Animal Furnace"=>50},
    {"Bill & Ted's Excellent Adventure"=>61}, {"Sharknado 3"=>92}]

    assert_equal expected, @tree.sort
  end

  def test_it_can_sort_the_tree_with_twelve_values
    @movies_list.each do |key, value|
      @tree.insert(key, value[0])
    end
    expected = [{"Johnny English"=>16}, {"Transformers6"=>35},
    {"Transformers1"=>40}, {"Transformers2"=>45},
    {"Hannibal Buress: Animal Furnace"=>50}, {"Transformers3"=>55},
    {"Bill & Ted's Excellent Adventure"=>61}, {"Transformers8"=>70},
    {"Transformers5"=>90}, {"Sharknado 3"=>92}, {"Transformers4"=>94},
    {"Transformers7"=>98}]

    assert_equal expected, @tree.sort
  end

  def test_it_can_load_movies_from_a_text_file
    assert_equal 99, @tree.load
  end

  def test_it_can_return_height_of_tree
    @movies_list.each do |key, value|
      @tree.insert(key, value[0])
    end
    assert_equal 4, @tree.height
  end

  def test_it_can_return_number_of_leaves_of_tree
    @movies_list.each do |key, value|
      @tree.insert(key, value[0])
    end

    assert_equal 5, @tree.leaves
  end

  def test_it_can_count
    @movies_list.each do |key, value|
      @tree.insert(key, value[0])
    end
    assert_equal 12, @tree.count
  end

  def test_it_can_find_nodes_by_depth
    @movies_list.each do |key, value|
      @tree.insert(key, value[0])
    end

    result = @tree.find_nodes_by_depth(0).map { |node| node.score }
    assert_equal [61], result

    result = @tree.find_nodes_by_depth(1).map { |node| node.score }
    assert_equal [16, 92], result

    result = @tree.find_nodes_by_depth(2).map { |node| node.score }
    assert_equal [50, 90, 94], result

    result = @tree.find_nodes_by_depth(3).map { |node| node.score }
    assert_equal [40, 55, 70, 98], result

    result = @tree.find_nodes_by_depth(4).map { |node| node.score }
    assert_equal [35, 45], result

    result = @tree.find_nodes_by_depth(5)
    assert "Incorrect depth value! Maximum depth of this tree is 4.", result
  end

  def test_it_can_return_health_of_tree
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal [[98, 7, 100]], tree.health(0)
    assert_equal [[58, 6, 85]], tree.health(1)
    assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
    assert_equal "Incorrect depth value! Maximum depth of this tree is 4.",
    tree.health(7)
  end

end
