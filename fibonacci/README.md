## Code:

```ruby
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
```

## Output:

```
Enter the n value: 50
=> 7778742049
Enter the n value: 23
=> 17711
Enter the n value: 39
=> 39088169
Enter the n value: 12
=> 89
Enter the n value: 1
=> 0
Enter the n value: 63
=> 4052739537881
Enter the n value: -1

-- program terminated --
```