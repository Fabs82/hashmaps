require_relative 'node'

# Class representing the full implementation of an HashMap
class HashMap
  attr_reader :capacity, :buckets, :storage_count, :load_factor

  def initialize
    @capacity = 16.0 # starting dimension of the HM
    @storage_count = 12.0 # the storage count will increase each time a new Node is added to the HM
    @buckets = Array.new(@capacity)
    @load_factor = (@storage_count / @buckets.size) # if load factor is =>0.75 array capacity will double reducing the LF
  end
end

test = HashMap.new
