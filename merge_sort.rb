def merge_sort(arr)
  return arr if arr.length == 0 or arr.length == 1
  n = arr.length / 2
  arr1 = merge_sort(arr[0...n])
  arr2 = merge_sort(arr[n...arr.length])
  merge(arr1, arr2)
end

def merge(arr1, arr2)
  arr = []
  n1, n2 = arr1.length, arr2.length
  i1, i2 = 0, 0
  while i1 < n1 and i2 < n2
    if arr1[i1] < arr2[i2]
      arr << arr1[i1]
      i1 = i1 + 1
    else
      arr << arr2[i2]
      i2 = i2 + 1
    end
  end
  (i1...n1).each { |ii1| arr << arr1[ii1] }
  (i2...n2).each { |ii2| arr << arr2[ii2] }
  arr
end

def merge1(*arrs)
  n = arrs.length - 1
  arr = []
  for i in 0..n do
    arr = merge1(arr, arrs[i])
  end
  arr
end

