require_relative 'node'

# Class representing the full implementation of an HashMap
class HashMap
  attr_accessor :capacity, :buckets, :storage_count, :threshold

  def initialize
    @capacity = 16 # starting dimension of the HashMap
    @buckets = Array.new(@capacity)
    @load_factor = 0.75 # determine when it is a goog time to grow the array capacity
    @storage_count = 0  # if storage_count > threshold (@capacity * @load_factor) -> increase buckets number
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % @buckets.length
  end

  def grow_array
    @capacity *= 2
    old_buckets = @buckets
    @buckets = Array.new(@capacity)
    puts 'time to grow'
    old_buckets.each do |current_node|
      next if current_node.nil?

      while current_node
        next_node_to_process = current_node.next_node
        index = hash(current_node.key)
        current_node.next_node = @buckets[index]
        @buckets[index] = current_node
        current_node = next_node_to_process
      end
    end
    # the hashmap grows in the SET() method
    # # if storage_count > threshold -> increase buckets number
    # create a new array with double the capacity
    # copy all existing nodes to the buckets of the new array re-hashing their keys
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
    # grow array if storage_count > threshold -> increase buckets number
    threshold = @capacity * @load_factor
    grow_array if @storage_count > threshold
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

  def remove(key)
    index = hash(key)
    current_node = @buckets[index]
    previous_node = nil

    return nil if current_node.nil? # return nil if index is empty

    while current_node
      if current_node.key == key # check the key
        if previous_node.nil? # check if it is the first element in the bucket
          @buckets[index] = current_node.next_node
        else
          previous_node.next_node = current_node.next_node # move the pointer and jump the current_node removing it
        end
        @storage_count -= 1 # decrease the count to correctly calculate the threshold
        return current_node.value # break out of the loop
      end
      previous_node = current_node # if still in the loop move to the next nodes couple
      current_node = current_node.next_node
    end
  end

  def clear
    @buckets = Array.new(16)
    @storage_count = 0
  end

  def keys
    # returns an array containing all the keys inside the hash map.
    collect_from_nodes { |current_node| current_node.key }
  end

  def values
    # returns an array containing all values
    collect_from_nodes { |current_node| current_node.value }
  end

  def entries
    # returns an array containing all keys & values
    collect_from_nodes do |current_node|
      [current_node.key, current_node.value]
    end
  end

  private

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
  # loop orizontally bx index number
  # if the node at index number not nil/empty
  # loop vertically to check the linked lists
  # append all the selected value to an array
  # yield delegates the extraction of the corrected data to the method caller.
  # return the array
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

test.set('moon', 'silver')

p test.buckets
