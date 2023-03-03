def heapify(arr, n, node)
	largest = node
	left = node * 2 + 1
	right = node * 2 + 2

	if left < n && arr[left] > arr[largest]
		largest = left
	end

	if right < n && arr[right] > arr[largest]
		largest = right
	end

	unless largest == node
		arr[largest], arr[node] = arr[node], arr[largest]
		heapify(arr, n, largest)
	end
end

def heap_sort(arr, n)
	(n/2 - 1).downto(0) do |i|
		heapify(arr, n, i)
	end

	(n-1).downto(0) do |i|
		arr[0], arr[i] = arr[i], arr[0]
		heapify(arr, i, 0)
	end
end

arr = []
10.times do |i|
	arr << rand(1..1000)
end

print "Initial Array: "
pp arr

heap_sort(arr, arr.size)

print "Sorted Array: "
pp arr