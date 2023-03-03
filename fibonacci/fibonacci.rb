fibonacci = Hash.new do |hash, i|
	hash[i] = hash[i-1] + hash[i-2]
end

fibonacci[1] = 0
fibonacci[2] = 1

loop do
	print"Enter the n value: "
	n = gets.strip.to_i

	unless n.negative?
		puts "=> #{fibonacci[n]}"
	else
		puts "\n-- program terminated --"
		break
	end
end
