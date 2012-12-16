class Edge
  attr_accessor :node1, :node2, :cost

  def initialize(node1, node2, cost)
  	@node1 = node1
  	@node1.edges << self

  	@node2 = node2
  	@node2.edges << self

    @cost = cost
    @in_mst = false
  end

  def crossing?
    @node1.in_mst ^ @node2.in_mst
  end

  def non_mst_node
    if not @node1.in_mst
      @node1
    elsif not @node2.in_mst
      @node2
    else
      nil
    end
  end
end

class Node
  attr_accessor :id, :edges, :in_mst

  def initialize(id)
    @id = id
    @edges = []
    @in_mst = false
  end
end

def prims_mst(node_map)
  verts = node_map.values
  verts[0].in_mst = true

  t = []            # edges of the minimum spanning tree
  x = [verts[0]]    # vertices spanned by tree_so_far

  while x.length != verts.length
    edges_to_consider = []
    x.each do |node|
      edges_to_consider << node.edges.select { |edge| edge.crossing? }
    end
    cheapest_edge = edges_to_consider.flatten.min { |e1, e2| e1.cost <=> e2.cost }
    new_node = cheapest_edge.non_mst_node
    new_node.in_mst = true
    x << new_node
    t << cheapest_edge
  end
  t.reduce(0) { |memo, edge| memo + edge.cost }
end

if ARGV.length == 1
  node_map = Hash.new { |hash, key| hash[key] = Node.new(key) } # key => node id, value => node itself
  all_edges = []
	File.open(ARGV[0], 'r') do |file|
		num_nodes, num_edges = file.readline.split(' ').collect(&:to_i)
		(1..num_edges).each do |i|
			node_id1, node_id2, edge_cost = file.readline.split(' ').collect(&:to_i)
			all_edges << Edge.new(node_map[node_id1], node_map[node_id2], edge_cost)
		end
	end
	puts "Cost of the MST: #{prims_mst(node_map)}"
end
