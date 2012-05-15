# arr -> unimodal array => elements in increasing order, maximum element, elements in decreasing order
def uni_max(arr)
  return arr.max if arr.length < 3
  pivot = arr.length / 2
  a = arr[pivot - 1]
  b = arr[pivot]
  c = arr[pivot + 1]
  return b if a < b and b > c
  if a < b and b < c
    return uni_max(arr[(pivot + 1)..(arr.length)])
  elsif a > b and b > c
    return uni_max(arr[0..pivot])
  end
end
