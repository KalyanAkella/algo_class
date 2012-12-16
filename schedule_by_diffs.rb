
Job = Struct.new :weight, :length

def process(jobs)
	jobs.sort! do |job1, job2|
		diff1 = job1.weight - job1.length
		diff2 = job2.weight - job2.length
		if diff1 == diff2
			job2.weight - job1.weight
		else
			diff2 - diff1
		end
	end

	completion_time = 0
	weighted_sum = 0
	jobs.each do |job|
		completion_time += job.length
		weighted_sum += job.weight * completion_time
	end
	weighted_sum
end

if ARGV.length == 1
	jobs = []
	File.open(ARGV[0], 'r') do |file|
		(1..file.readline.to_i).each do |i|
			comps = file.readline.split(' ').collect(&:to_i)
			jobs << Job.new(comps[0], comps[1])
		end
	end
	puts "Running the greedy algorithm for scheduling the jobs..."
	puts "Weighted Sum: #{process(jobs)}"
end
