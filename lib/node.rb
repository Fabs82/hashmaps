# Node class representing the key and value to be stored in the HashMap
class Node
  attr_accessor :key, :next_node, :value

  def initialize(key, value, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end
