## Accumulate Method

Custom implementation of Enumerable module's `inject` method.

## Code:

```ruby
module Enumerable
    def accumulate(*args, &block)
        raise Error if args === [] && !block_given?
        raise ArgumentError if args.size > 2 || (args.size == 2 && block_given?)

        if args.size == 2
            operation(self, args[0], args[1])
        elsif args.size == 1 && !block_given?
            operation(self.drop(1), self.first, args[0])
        else
            if !args.empty?
                result = args[0]
                enum = self
            else
                result = self.first
                enum = self.drop(1)
            end
            enum = enum.to_a if self.class == Enumerator
            enum.each { |item| result = yield(result, item) }
            result
        end
    end
    
    private

    def operation(enum, accumulator_value, operator)
        raise TypeError unless operator.is_a?(Symbol)
        enum.each { |item| accumulator_value = accumulator_value.send(operator, item) }
        accumulator_value
    end
end

p (5..10).accumulate(1, :*)
p (5..10).accumulate(&:+)
p (2..4).accumulate { |acc, i| acc ** i }
```

## Output:

```
151200
45
4096
```