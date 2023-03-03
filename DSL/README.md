## XML Builder

DSL written in Ruby for creating `XML` markups.

## Code:

```ruby
class Builder < BasicObject
    attr_accessor :xml

    def initialize
        @xml = %q{<?xml version="1.0" encoding="UTF-8"?>}
        @level = -1
    end

    def method_missing(name, *args, &block)
        raise ArgumentError if (args.size == 1 && !args[0].respond_to?(:keys) && block)
        raise ArgumentError if args.size > 2

        @xml << "\n"
        @level += 1
        @xml << "    " * @level + "<#{name.to_s}"

        if args.size == 2 || (args.size == 1 && block)
            options = block ? args[0] : args[1]
            options.each do |k, v|
                @xml << " #{k}=\"#{v}\""
            end
        end
        @xml << ">"

        if args.size == 2 || (args.size == 1 && !block)
            @xml << args[0].to_s
        else
            @xml << yield(self) if block
            @xml << "\n"
            @xml << "    " * @level
        end

        @xml << "</#{name.to_s}>"
        @level -= 1
    end
end

item = Builder.new

item.orders do |a|
    a.order do |b|
        b.number 1
        b.date "03/03/2023", {type: "date"}
        b.customercode "C7845"

        b.orderline( {number: 1} ) do |c|
            c.productcode "CDR1080"
            c.description "Chips"
            c.quantity 10
        end
    end

    a.order do |b|
        b.number 2
        b.date "08/03/2023", {type: "date"}
        b.customercode "C7846"

        b.orderline( {number: 2} ) do |c|
            c.productcode "CDR8530"
            c.description "iPad"
            c.quantity 2
        end
    end

    a.order do |b|
        b.number 3
        b.date "11/03/2023", {type: "date"}
        b.customercode "C0845"

        b.orderline( {number: 3} ) do |c|
            c.productcode "CDR8530"
            c.description "Choci Choci"
            c.quantity 20
        end
    end
end

puts item.xml
```

## Output:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<orders>
    <order>
        <number>1</number>
        <date type="date">03/03/2023</date>
        <customercode>C7845</customercode>
        <orderline number="1">
            <productcode>CDR1080</productcode>
            <description>Chips</description>
            <quantity>10</quantity>
        </orderline>
    </order>
    <order>
        <number>2</number>
        <date type="date">08/03/2023</date>
        <customercode>C7846</customercode>
        <orderline number="2">
            <productcode>CDR8530</productcode>
            <description>iPad</description>
            <quantity>2</quantity>
        </orderline>
    </order>
    <order>
        <number>3</number>
        <date type="date">11/03/2023</date>
        <customercode>C0845</customercode>
        <orderline number="3">
            <productcode>CDR8530</productcode>
            <description>Choci Choci</description>
            <quantity>20</quantity>
        </orderline>
    </order>
</orders>
```