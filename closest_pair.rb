#
# points are 2d with as in [x,y]
# example invocation: closest_pair([[2,3], [1,4], [3,5], [2,2]])
# approach: brute force
# complexity: O(n*n)
#
def closest_pair1(points)
  min_distance = Float::MAX
  best_pair = nil
  (0...points.length).each do |i|
    (i...points.length).each do |j|
      if i != j
        curr_distance = distance1(points[i], points[j])
        if curr_distance < min_distance
          min_distance = curr_distance
          best_pair = [points[i], points[j]]
        end
      end
    end
  end
  best_pair
end

def distance1(p1, p2)
  Math.sqrt(((p1[0] - p2[0]) * (p1[0] - p2[0])) + ((p1[1] - p2[1]) * (p1[1] - p2[1])))
end

def distance(p1, p2)
  Math.sqrt(((p1.x - p2.x)*(p1.x - p2.x)) + ((p1.y - p2.y)*(p1.y - p2.y)))
end

# approach: sort and compute
# complexity: O(nlogn)
#
Point = Struct.new :x, :y

def log(obj)
  puts "*"*100
  puts obj
  puts "*"*100
end

def closest_pair(points)
  px = merge_sort_x(points)
  py = merge_sort_y(points)
  _closest_pair(px, py)
end

# px -> all points sorted by their x coordinates
# py -> all points sorted by their y coordinates
def _closest_pair(px, py)
  nx, ny = px.length, py.length
  return [px[0], py[0]] if nx == 1 and ny == 1
  return best([px[0], px[1]], [py[0], py[1]]) if nx == 2 and ny == 2
  qx, rx, qy, ry = px[0...nx/2], px[nx/2...nx], py[0...ny/2], py[ny/2...ny]
  qpair = _closest_pair(qx, qy)
  rpair = _closest_pair(rx, ry)
  min_dist = [distance(qpair[0], qpair[1]), distance(rpair[0], rpair[1])].min
  split_pair = closest_split_pair(px, py, min_dist)
  best(qpair, rpair, split_pair)
end

def best(*pairs)
  min_dist = Float::MAX
  best_pair = nil
  pairs.each do |pair|
    next if pair.nil?
    dist = distance(pair[0], pair[1])
    if dist < min_dist
      min_dist = dist
      best_pair = pair
    end
  end
  best_pair
end

def closest_split_pair(px, py, min_dist)
  best_pair = nil
  nx, ny = px.length, py.length
  x_bar = px[nx / 2]
  x_range = (x_bar.x - min_dist)..(x_bar.x + min_dist)
  sy = py.select { |p| x_range.cover?(p.x) }
  nsy = sy.length - 7
  (0...nsy).each do |i|
    (0...7).each do |j|
      dist = distance(sy[i], sy[j])
      if dist < min_dist
        min_dist = dist
        best_pair = [sy[i], sy[j]]
      end
    end
  end
  best_pair
end

def merge_sort_x(points)
  return points if points.length == 0 or points.length == 1
  n = points.length / 2
  px1 = merge_sort_x(points[0...n])
  px2 = merge_sort_x(points[n...points.length])
  merge_x(px1, px2)
end

def merge_x(px1, px2)
  px = []
  i1, i2 = 0, 0
  n1, n2 = px1.length, px2.length
  while i1 < n1 and i2 < n2 do
    if px1[i1].x < px2[i2].x
      px << px1[i1]
      i1 = i1 + 1
    else
      px << px2[i2]
      i2 = i2 + 1
    end
  end
  (i1...n1).each { |i| px << px1[i] }
  (i2...n2).each { |i| px << px2[i] }
  px
end

def merge_sort_y(points)
  return points if points.length == 0 or points.length == 1
  n = points.length / 2
  py1 = merge_sort_y(points[0...n])
  py2 = merge_sort_y(points[n...points.length])
  merge_y(py1, py2)
end

def merge_y(py1, py2)
  py = []
  i1, i2 = 0, 0
  n1, n2 = py1.length, py2.length
  while i1 < n1 and i2 < n2 do
    if py1[i1].y < py2[i2].y
      py << py1[i1]
      i1 = i1 + 1
    else
      py << py2[i2]
      i2 = i2 + 1
    end
  end
  (i1...n1).each { |i| py << py1[i] }
  (i2...n2).each { |i| py << py2[i] }
  py
end
