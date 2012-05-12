class Node
  attr_reader :text
  attr_accessor :distance

  def initialize(text)
    @text = text
    @others = []
    @visited = false
    @distance = -1
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

def bfs(start_node)
  start_node.visit
  start_node.distance = 0
  queue = [start_node]
  until queue.empty?
    node = queue.delete_at(0)
    node.each_other_node do |other_node|
      next if other_node.visited?
      other_node.visit
      other_node.distance = node.distance + 1
      queue << other_node
    end
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

a.connect(c)
c.connect(a)

b.connect(c)
c.connect(b)

b.connect(d)
d.connect(b)

c.connect(e)
e.connect(c)

d.connect(e)
e.connect(d)

bfs(s)

puts s.distance
puts a.distance
puts b.distance
puts c.distance
puts d.distance
puts e.distance
