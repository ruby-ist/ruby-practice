class Array
	def heapify(n, node)
		largest = node
		left = node * 2 + 1
		right = node * 2 + 2

		if left < n && self[left] > self[largest]
			largest = left
		end

		if right < n && self[right] > self[largest]
			largest = right
		end

		unless largest == node
			self[largest], self[node] = self[node], self[largest]
			heapify(n, largest)
		end
	end

	def heap_sort
		n = size
		(n/2 - 1).downto(0) do |i|
			heapify(n, i)
		end

		(n-1).downto(0) do |i|
			self[0], self[i] = self[i], self[0]
			heapify(i, 0)
		end
	end
end

arr = []
10.times do |i|
	arr << rand(1..1000)
end

print "Initial Array: "
pp arr

arr.heap_sort

print "Sorted Array: "
pp arr