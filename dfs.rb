class Node
  attr_reader :text

  def initialize(text)
    @text = text
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
    puts "Node #{@text} visited"
  end

  def visited?
    @visited
  end
end

def dfs1(start_node)
  start_node.visit
  stack = [start_node]
  until stack.empty?
    node = stack.pop
    node.each_other_node do |other_node|
      next if other_node.visited?
      other_node.visit
      stack.push(other_node)
    end
  end
end

def dfs(node)
  return if node.visited?
  node.visit
  node.each_other_node do |other_node|
    dfs(other_node)
  end
end

s = Node.new('s')
a = Node.new('a')
b = Node.new('b')
c = Node.new('c')
d = Node.new('d')
e = Node.new('e')

s.connect(a)
a.connect(s)

s.connect(b)
b.connect(s)

a.connect(b)
b.connect(a)

a.connect(c)
c.connect(a)

b.connect(d)
d.connect(b)

c.connect(d)
d.connect(c)

c.connect(e)
e.connect(c)

d.connect(e)
e.connect(d)

dfs(s)
