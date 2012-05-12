class Node
  attr_reader :text
  attr_accessor :index

  def initialize(text)
    @text = text
    @others = []
    @visited = false
    @index = -1
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
    puts "Node #{@text} visited"
  end

  def visited?
    @visited
  end
end

def topological_sort(nodes)
  current_index = nodes.length
  nodes.each do |node|
    next if node.visited?
    current_index = dfs(node, current_index)
  end
end

def dfs(node, current_index)
  return current_index if node.visited?
  node.visit
  node.each_other_node do |other_node|
    current_index = dfs(other_node, current_index)
  end
  node.index = current_index
  current_index -= 1
  current_index
end

s = Node.new('s')
a = Node.new('a')
b = Node.new('b')
c = Node.new('c')

s.connect(a)
a.connect(c)
s.connect(b)
b.connect(c)

nodes = [s, a, b, c]
topological_sort(nodes)

nodes.each do |n|
  puts "#{n.text}->#{n.index}"
end
