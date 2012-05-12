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
  end

  def visited?
    @visited
  end
end

def connected_components(nodes)
  nodes.each do |node|
    unless node.visited?
      bfs(node)
      puts "Detected connected component starting at, #{node.text}"
    end
  end
end

def bfs(start_node)
  start_node.visit
  queue = [start_node]
  until queue.empty?
    node = queue.delete_at(0)
    node.each_other_node do |other_node|
      next if other_node.visited?
      other_node.visit
      queue << other_node
    end
  end
end

n1 = Node.new('1')
n2 = Node.new('2')
n3 = Node.new('3')
n4 = Node.new('4')
n5 = Node.new('5')
n6 = Node.new('6')
n7 = Node.new('7')
n8 = Node.new('8')
n9 = Node.new('9')
n10 = Node.new('10')

n1.connect(n3)
n3.connect(n1)

n3.connect(n5)
n5.connect(n3)

n1.connect(n5)
n5.connect(n1)

n5.connect(n9)
n9.connect(n5)

n5.connect(n7)
n7.connect(n5)

n2.connect(n4)
n4.connect(n2)

n6.connect(n8)
n8.connect(n6)

n10.connect(n8)
n8.connect(n10)

n6.connect(n10)
n10.connect(n6)

connected_components([n1, n2, n3, n4, n5, n6, n7, n8, n9, n10])

