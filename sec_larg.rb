def sec_larg(arr)
  max = -1
  second_max = -1
  arr.each do |num|
    if num > max
      second_max = max
      max = num
    elsif num > second_max
      second_max = num
    end
  end
  second_max
end
