require 'pry'

class BinarySearchTree

  def initialize
    @head = nil
    @depth = nil
  end

  def insert_first_node(score, title)
    @head = Node.new(score, title)
  end

  def validate_score(score, title)

  end




  def insert(score, title)
    if @head.nil?
      insert_first_node(score, title)
      @depth = 0
    else
      validate_score(score, title)
    end
    binding.pry
  end



end
