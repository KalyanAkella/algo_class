
Node = Struct.new(:key, :value)

class Heap
  attr_accessor :arr

  def initialize
    @arr = []
  end

  def parent_index(node_index)
    return nil if @arr.length <= 1 or node_index == 0
    (node_index/2).floor
  end

  def child_indices(node_index)
    child_index = node_index * 2
    [child_index + 1, child_index + 2]
  end

  def insert(node)
    @arr << node
    adjust_after_insert
  end

  def extract_min
    @arr[0], @arr[@arr.length - 1] = @arr[@arr.length - 1], @arr[0]
    element = @arr.delete_at(@arr.length - 1)
    adjust_after_delete
    element
  end

  def adjust_after_insert
    return if @arr.length <= 1
    li = @arr.length - 1
    last_node = @arr[li]
    pi = parent_index(li)
    parent_node = @arr[pi]
    until (parent_node.nil? or parent_node.key <= last_node.key)
      @arr[pi], @arr[li] = @arr[li], @arr[pi]
      li, last_node = pi, @arr[pi]
      pi = parent_index(li)
      parent_node = pi.nil? ? nil : @arr[pi]
    end
  end

  def adjust_after_delete
    return if @arr.length <= 1
    curr_index, curr_node = 0, @arr[0]
    child_index1, child_index2 = child_indices(curr_index)
    child_node1, child_node2 = @arr[child_index1], @arr[child_index2]
    until (child_node1.nil? or curr_node.key <= child_node1.key) and (child_node2.nil? or curr_node.key <= child_node2.key)
      puts "Parent: #{curr_node.key}, Child1: #{child_node1.nil? ? '<empty>' : child_node1.key}, Child2: #{child_node2.nil? ? '<empty>' : child_node2.key}"
      if !child_node1.nil? and !child_node2.nil?
        if child_node1.key < child_node2.key
          @arr[curr_index], @arr[child_index1] = @arr[child_index1], @arr[curr_index]
          curr_index, curr_node = child_index1, @arr[child_index1]
        else
          @arr[curr_index], @arr[child_index2] = @arr[child_index2], @arr[curr_index]
          curr_index, curr_node = child_index2, @arr[child_index2]
        end
      else
        if child_node2.nil?
          @arr[curr_index], @arr[child_index1] = @arr[child_index1], @arr[curr_index]
          curr_index, curr_node = child_index1, @arr[child_index1]
        else
          @arr[curr_index], @arr[child_index2] = @arr[child_index2], @arr[curr_index]
          curr_index, curr_node = child_index2, @arr[child_index2]
        end
      end
      child_index1, child_index2 = child_indices(curr_index)
      child_node1, child_node2 = @arr[child_index1], @arr[child_index2]
    end
  end
end
