require_relative 'node'

# Class representing the full implementation of an HashMap
class HashMap
  attr_reader :capacity, :buckets, :storage_count, :load_factor

  def initialize
    @capacity = 16.0 # starting dimension of the HM
    @storage_count = 0.0 # the storage count will increase each time a new Node is added to the HM
    @buckets = Array.new(@capacity)
    @load_factor = (@storage_count / @buckets.size) # if load factor is =>0.75 array capacity will double reducing the LF
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % @buckets.size
  end

  def set(key, value)
    # add a key/value pair to the corresponding hashed index of the array
    new_node = Node.new(key, value)
    index = hash(new_node.key)

    raise IndexError if index.negative? || index >= @buckets.length

    return puts 'Index is not empty' unless @buckets[index].nil?

    @buckets[index] = new_node
    @storage_count += 1
  end
end

test = HashMap.new

test.set('apple', 'red')
