class Node
  attr_reader :id

  def initialize(id)
    @id = id
    @others = []
    @visited = false
  end

  def connect(node)
    @others << node
    self
  end

  def each_other_node(&block)
    @others.each do |node|
      block.call(node)
    end
  end

  def visit
    @visited = true
  end

  def visited?
    @visited
  end

  def reset!
    @visited = false
  end
end

def dfs2(node, fnodes)
  node.visit
  node.each_other_node do |other_node|
    dfs2(other_node, fnodes) unless other_node.visited?
  end
  fnodes.push(node)
end

def dfs(node)
  node.visit
  puts "Visited #{node.id}"
  node.each_other_node do |other_node|
    dfs(other_node) unless other_node.visited?
  end
end

def compute(nodes, nodes_rev)
  fnodes = [] # a stack of nodes ordered by the finishing times
  nodes_rev.each do |node|
    dfs2(node, fnodes) unless node.visited?
  end

  fnodes.each do |fnode|
    fnode.reset!
  end

  until fnodes.empty?
    fnode = fnodes.pop
    dfs(fnode) unless fnode.visited?
  end
end

def connect(nodes, node_rels)
  node_rels.each_pair do |k,v|
    v.each do |i|
      nodes[k - 1].connect(nodes[i - 1])
    end
  end
end

nodes = [Node.new(1), Node.new(2), Node.new(3), Node.new(4), Node.new(5), Node.new(6), Node.new(7), Node.new(8), Node.new(9)]
node_rels = { 1 => [4], 4 => [7], 7 => [1], 9 => [7, 3], 3 => [6], 6 => [9], 8 => [6, 5], 5 => [2], 2 => [8] }
connect(nodes, node_rels)

nodes_rev = [Node.new(1), Node.new(2), Node.new(3), Node.new(4), Node.new(5), Node.new(6), Node.new(7), Node.new(8), Node.new(9)]
node_rels_rev = { 4 => [1], 7 => [4, 9], 1 => [7], 3 => [9], 6 => [3, 8], 9 => [6], 5 => [8], 2 => [5], 8 => [2] }
connect(nodes_rev, node_rels_rev)

compute(nodes, nodes_rev)
