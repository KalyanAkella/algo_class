# Solution to the ContestWinner problem used in Topcoder SRM 546 Round 1 - Division II, Level One
def compute(events)
  max_contestant = events.max
  solved = Array.new(max_contestant, 0)
  time = Array.new(max_contestant, 1000001)
  events.each_with_index do |event, index|
    solved[event-1] += 1
    time[event-1] = index
  end
  max_solved = -1
  winners = []
  (0...max_contestant).each do |i|
    if solved[i] > max_solved
      winners = [i]
      max_solved = solved[i]
    elsif solved[i] == max_solved
      winners << i
    end
  end
  min_time = 1000002
  result = -1
  (0...winners.length).each do |wi|
    if time[winners[wi]] < min_time
      result = winners[wi]
      min_time = time[winners[wi]]
    end
  end
  result+1
end
