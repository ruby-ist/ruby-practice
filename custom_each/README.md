## Code:

```ruby
class Array
    def my_each(&block)
        return to_enum(:my_each) unless block_given?

    	i = 0
    	while i < size
            yield self[i]
            i += 1
    	end
    	self
    end
end

arr = [1,3,4,8,9,6,2]
arr.my_each do |i|
    print i, " "
end
```

## Output:

```
1 3 4 8 9 6 2 
```