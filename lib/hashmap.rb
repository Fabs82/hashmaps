require_relative 'node'

# Class representing the full implementation of an HashMap
class HashMap
  attr_reader :capacity, :buckets, :storage_count

  def initialize
    @capacity = 16 # starting dimension of the HashMap
    @buckets = Array.new(@capacity)
    @load_factor = 0.75 # determine when it is a goog time to grow the array capacity
    @threshold = @capacity * @load_factor # if storage_count > threshold -> increase buckets number
    @storage_count = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % @buckets.length
  end

  def grow_array
    # create a new array with double the capacity
    # copy all existing nodes to the buckets of the new array hashing their keys
  end

  def set(key, value)
    # add a key/value pair to the corresponding hashed index of the array
    index = hash(key)
    unless @buckets[index].nil? # bucket is not empty, check each node
      current_node = @buckets[index] # set the starting point
      while current_node # traverse the list
        if current_node.key == key # the new_node_key exists, overwrite its value
          current_node.value = value
          return
        end
        current_node = current_node.next_node
      end
    end
    # bucket is empty. simply add a new node
    new_node = Node.new(key, value)
    new_node.next_node = @buckets[index]
    @buckets[index] = new_node
    @storage_count += 1
  end

  def get(key)
    # if the key is in the hashmap returns its value
    index = hash(key)
    current_node = @buckets[index]
    while current_node # traverse the list
      return current_node.value if key == current_node.key # return the value from the loop if the key is found

      current_node = current_node.next_node # continue the loop if necessary
    end
  end

  def has?(key)
    # takes a key as an argument and returns true or false based on whether or not the key is in the hash map.
    index = hash(key)
    current_node = @buckets[index]
    while current_node
      return true if key == current_node.key

      current_node = current_node.next_node
    end
    false
  end

  def clear
    @buckets = Array.new(16)
    @storage_count = 0
  end

  def keys
    # returns an array containing all the keys inside the hash map.
    collect_from_nodes do |node|
      node.key
    end
    # loop orizontally bx index number
    # if the node at index number not nil/empty
    # loop vertically to check the linked lists
    # append all key to an array
    # return the array
  end

  def values
    # returns an array containing all values
    collect_from_nodes do |node|
      node.value
    end
  end

  def entries
    collect_from_nodes do |node|
      [node.key, node.value]
    end
  end

  def collect_from_nodes
    array = []
    @buckets.each do |current_node|
      next if current_node.nil?

      while current_node
        array << yield(current_node)
        current_node = current_node.next_node
      end
    end
    array
  end
end

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

p test.keys
