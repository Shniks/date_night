require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'
require './lib/binary_search_tree'


def load_movies
  @movies_list.each do |key, value|
    result = @tree.insert(key, value[0])
  end
end
