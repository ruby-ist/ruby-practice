class XMLBuilder < BasicObject
	attr_accessor :xml

	def map_to_xml(&block)
  	@xml = %q{<?xml version="1.0" encoding="UTF-8"?>}
  	@level = -1
    instance_eval(&block)
    @xml
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
			@xml << instance_eval(&block) if block
			@xml << "\n"
			@xml << "    " * @level
		end

		@xml << "</#{name.to_s}>"
		@level -= 1
	end
end

result = XMLBuilder.new.map_to_xml do
  orders do
  	order do
  		number 1
  		date "03/03/2023", {type: "date"}
  		customercode "C7845"

  		orderline( {number: 1} ) do |c|
  			productcode "CDR1080"
  			description "Chips"
  			quantity 10
  		end
  	end

  	order do
  		number 2
  		date "08/03/2023", {type: "date"}
  		customercode "C7846"

  		orderline( {number: 2} ) do |c|
  			productcode "CDR8530"
  			description "iPad"
  			quantity 2
  		end
  	end

  	order do
  	  number 3
  		date "11/03/2023", {type: "date"}
  		customercode "C0845"

  		orderline( {number: 3} ) do
  			productcode "CDR8530"
  			description "Choci Choci"
  			quantity 20
  		end
  	end
  end
end

puts result
