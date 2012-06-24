class Node
  attr_accessor :d, :f, :id, :color, :others

  def initialize(id)
    @id = id
    @others = []
    @color = 'W'
    @d = @f = -1
  end

  def to(node)
    @others << node
    self
  end

  def each_other_node(&block)
    @others.each do |node|
      block.call(node)
    end
  end

  def white?
    @color == 'W'
  end
end

def dfs(nodes)
  time = 0
  nodes.each do |node|
    time = dfs_visit(node, time) if node.white?
  end
end

def dfs_visit(node, time)
  node.color = 'G'
  time += 1
  node.d = time
  stack = [node]
  until stack.empty?
    curr_node = stack[0]
    unless curr_node.others.any? { |node| node.white? }
      curr_node = stack.pop
      curr_node.color = 'B'
      time += 1
      curr_node.f = time
    end
    curr_node.each_other_node do |other_node|
      if other_node.white?
        other_node.color = 'G'
        time += 1
        other_node.d = time
        stack.push(other_node)
      end
    end
  end
  time
end

def dfs_visit1(node, time)
  node.color = 'G'
  time += 1
  node.d = time
  node.each_other_node do |other_node|
    if other_node.white?
      time = dfs_visit1(other_node, time)
    end
  end
  node.color = 'B'
  time += 1
  node.f = time
  time
end

q = Node.new('q')
r = Node.new('r')
s = Node.new('s')
t = Node.new('t')
u = Node.new('u')
v = Node.new('v')
w = Node.new('w')
x = Node.new('x')
y = Node.new('y')
z = Node.new('z')

q.to(s).to(t).to(w)
r.to(u).to(y)
s.to(v)
t.to(x).to(y)
u.to(y)
v.to(w)
w.to(s)
x.to(z)
y.to(q)
z.to(x)

graph = [q,r,s,t,u,v,w,x,y,z]
dfs(graph)

graph.each do |_node|
  puts "#{_node.id} -> #{_node.d}/#{_node.f}"
end
