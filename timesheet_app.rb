	@EMPLOYEES = ["Alex", "Jake", "Tasmin", "Josh", "Adam", "Wayne", "Dave", "Bri", "Scott", "Marissa"]
	@EMPLOYEES_WAGES = [17.79, 19.10, 17.29, 18.47, 17.29, 17.29, 17.29, 19.10, 18.47, 20.13]
	@EMPLOYEES_REQUIRED_SHIFT = [4,5,4,8,8,5,6,9,4,7]
	@EMPLOYEE_SHIFT_BLOCK_COST = [71.16, 95.50, 69.16, 147.76, 138.32, 86.45, 103.74, 171.90, 73.88, 140.91]

	@BUDGET = 800.00

	def print_arrays

		# Test code for printing out members of the arrays
		
		# @EMPLOYEES.each do |employee|
		# 	print " #{employee} ,"
		# end

		# puts 

		# @EMPLOYEES_WAGES.each do |wages|
		# 	print " $#{wages} ,"
		# end

		# puts

		# @EMPLOYEES_REQUIRED_SHIFT.each do |shift|
		# 	print " #{shift} ,"
		# end

		# puts

		# @EMPLOYEE_SHIFT_BLOCK_COST.each do |block|
		# 	print " $#{block} ,"
		# end

		puts

		i = 0	
		loop do
			print " #{@EMPLOYEES[i]} , HOURLY WAGE = $#{@EMPLOYEES_WAGES[i]}, REQUIRED HOURS = #{@EMPLOYEES_REQUIRED_SHIFT[i]}, SHIFT BLOCK COST = $#{@EMPLOYEE_SHIFT_BLOCK_COST[i]}"	
			i+=1
			puts
			break if i==10
		end	
	end

# print_arrays

	def recursive_addition(numbers, budget, numbersAdded =[])

		recursive_sum = numbersAdded.inject(0, :+)
		# puts recursive_sum

		# puts "sum(#{partial})=#{target}" if recursive_sum == budget

  		if recursive_sum > 0
  			if recursive_sum > 790 
  				if recursive_sum <= budget
  					print numbersAdded
  					print "    ....... "
  					print recursive_sum
  					puts "got to here"
  				end
  				return
  			end
  		end

  		(0..(numbers.length - 1)).each do |i|
    		n = numbers[i]
    		remaining = numbers.drop(i+1)
    		recursive_addition(remaining, budget, numbersAdded + [n])
  		end
	end

	recursive_addition(@EMPLOYEE_SHIFT_BLOCK_COST,@BUDGET)