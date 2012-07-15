class Node
  attr_accessor :d, :f, :id, :color, :others, :cc

  def initialize(id)
    @id = id
    @others = []
    @color = 'W'
    @d = @f = @cc = -1
  end

  def to(*nodes)
    @others << nodes
    @others.flatten!
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

def paths(u, v)
  num_paths = 0
  num_paths = dfs_visit(u, v, num_paths)
  num_paths
end

def dfs_visit(src, dst, num_paths)
  src.each_other_node do |other_node|
    num_paths += 1 if other_node.id == dst.id
    if other_node.white?
      num_paths = dfs_visit(other_node, dst, num_paths)
    end
  end
  num_paths
end

m = Node.new('m')
n = Node.new('n')
o = Node.new('o')
p = Node.new('p')
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

m.to(r, q, t)
n.to(q, u, o)
o.to(r, v, s)
p.to(o, s, z)
q.to(t)
r.to(u, y)
s.to(r)
u.to(t)
v.to(x, w)
w.to(z)
y.to(v)

puts paths(p, v)
