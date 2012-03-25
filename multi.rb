def num_digits(num)
  return 1 if num == 0
  count = 0
  while num > 0
    count = count + 1
    num = num / 10
  end
  count
end

def multi(x, y)
  nx, ny = num_digits(x), num_digits(y)
  if nx != ny
    puts "numbers must have the same number of even digits"
    return -1
  end

  return x * y if nx == 1

  factor = (10 ** (nx / 2))
  a, b = x / factor, x % factor
  c, d = y / factor, y % factor

  ac = multi(a, c)
  bd = multi(b, d)
  bc_ad = ((a + b) * (c + d)) - ac - bd
  return ac * (10 ** nx) + bc_ad * (10 ** (nx / 2)) + bd
end
