# Solution to the problem in CLR book, page 539, prob: 22.2-6

class Node
  attr_reader :id, :rivals
  attr_writer :good
  attr_accessor :color

  def initialize(id)
    @id = id
    @rivals = []
    @good = nil
    @color = 'WHITE'
  end

  def rival(rival_node)
    @rivals << rival_node
    self
  end

  def white?
    @color == 'WHITE'
  end

  def good?
    @good
  end
end

def compute(nodes)
  start_node = nodes[0]
  start_node.color = 'GREY'
  start_node.good = false
  queue = [start_node]
  until queue.empty?
    curr_node = queue.delete_at(0)
    curr_node.rivals.each do |rival_node|
      if curr_node.good? == rival_node.good?
        return false
      end
      if rival_node.white?
        rival_node.color = 'GREY'
        rival_node.good = !curr_node.good?
        queue << rival_node
      end
    end
    curr_node.color = 'BLACK'
  end
  return true
end

def solve(nodes)
  if compute(nodes)
    node_hash = nodes.group_by { |node| node.good? }
    [node_hash[false].collect { |node| node.id }, node_hash[true].collect { |node| node.id }]
  else
    nodes.collect { |node| node.id }
  end
end

node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)
node4 = Node.new(4)
node5 = Node.new(5)

node1.rival(node2)
node2.rival(node1)

node2.rival(node3)
node3.rival(node2)

node4.rival(node2)
node2.rival(node4)

node3.rival(node5)
node5.rival(node3)

node4.rival(node5)
node5.rival(node4)

# uncomment the following two lines
# to introduce an impossible designation
# node2.rival(node5)
# node5.rival(node2)

puts solve([node1, node2, node3, node4, node5]).inspect
