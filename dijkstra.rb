
class Edge
  attr_accessor :head, :tail, :distance

  def initialize(head, tail, distance)
    @head = head
    @tail = tail
    @distance = distance
  end

  def visited?
    @head.length >= 0 and @tail.length >= 0
  end
end

class Node
  attr_reader :text
  attr_accessor :outgoing_edges, :length

  def initialize(text)
    @text = text
    @outgoing_edges = []
    @length = -1
  end
end

# Single source shortest path algorithm - Dijkstra
def compute(source, num_nodes)
  x = [source]
  source.length = 0
  until x.length == num_nodes
    min_edge = nil
    min_distance = Float::INFINITY
    x.each do |xnode|
      xnode.outgoing_edges.each do |xedge|
        next if xedge.visited?
        curr_distance = xnode.length + xedge.distance
        if curr_distance <= min_distance
          min_distance = curr_distance
          min_edge = xedge
        end
      end
    end
    min_edge.head.length = min_distance
    x << min_edge.head
  end
  x
end

s = Node.new('s')
v = Node.new('v')
w = Node.new('w')
t = Node.new('t')

s.outgoing_edges << Edge.new(v, s, 1) << Edge.new(w, s, 4)
v.outgoing_edges << Edge.new(t, v, 6) << Edge.new(w, v, 2)
w.outgoing_edges << Edge.new(t, w, 3)

shortest_path = compute(s, 4)
shortest_path.each do |node|
  print "#{node.text} "
end
puts ""
