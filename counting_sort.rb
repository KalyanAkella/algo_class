
# for any array element ai, for i in [0,n),
# assume that ai <= k where k > 0 and
# n is the size of the array
def sort(arr, k)
  temp = Array.new(k, 0)
  result = Array.new(arr.length)
  n = arr.length

  (0...n).each do |i|
    temp[arr[i]] += 1
  end

  (1...k).each do |i|
    temp[i] += temp[i-1]
  end

  (0...k).each do |i|
    temp[i] -= 1
  end

  # doing the iteration from 0 to (n-1) affects the stability !
  (n-1).downto(0).each do |i|
    result[temp[arr[i]]] = arr[i]
    temp[arr[i]] -= 1
  end

  result
end
