# Node class representing the key and value to be stored in the HashMap
class Node
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end
