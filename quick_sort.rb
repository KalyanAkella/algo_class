def partition(pivot_index, array, l, r)
  if pivot_index > l
    array[l], array[pivot_index] = array[pivot_index], array[l]
    pivot_index = l
  end
  i, j = l + 1, l + 1
  pivot = array[pivot_index]
  while j <= r
    if array[j] < pivot
      array[i], array[j] = array[j], array[i]
      i = i + 1
    end
    j = j + 1
  end
  array[l], array[i - 1] = array[i - 1], array[l]
  return (i - 1)
end

def quick_sort(l, r, array)
  n = r - l + 1
  return if n <= 1
  pivt = partition(l, array, l, r)
  quick_sort(l, pivt - 1, array)
  quick_sort(pivt + 1, r, array)
end
