	@EMPLOYEES = ["Alex", "Jake", "Tasmin", "Josh", "Adam", "Wayne", "Dave", "Bri", "Scott", "Marissa"]
	@EMPLOYEES_WAGES = [17.79, 19.10, 17.29, 18.47, 17.29, 17.29, 17.29, 19.10, 18.47, 20.13]
	@EMPLOYEES_REQUIRED_SHIFT = [4,5,4,8,8,5,6,9,4,7]
	@EMPLOYEE_SHIFT_BLOCK_COST = [71.16, 95.50, 69.16, 147.76, 138.32, 86.45, 103.74, 171.90, 73.88, 140.91]

	@ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST = {"Alex" => 71.16, "Jake" => 95.50, "Tasmin" => 69.16, "Josh" => 147.76, "Adam" => 138.32, "Wayne" => 86.45, "Dave" => 103.74, "Bri" => 171.90, "Scott" => 73.88, "Marissa" 	=> 140.91}

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

	$closest_to_budget = 0

# print_arrays

	def simple_recursive_addition(numbers, budget, numbersAdded =[])

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
  					if recursive_sum > $closest_to_budget
  						$closest_to_budget = recursive_sum
  					end
  				end
  				return
  			end
  		end

  		(0..(numbers.length - 1)).each do |i|
    		n = numbers[i]
    		remaining = numbers.drop(i+1)
    		simple_recursive_addition(remaining, budget, numbersAdded + [n])
  		end
	end

	$associative_closest_to_budget = 0

	def associative_recursive_addition(numbers, budget, numbersAdded =[])

		recursive_sum = numbersAdded.inject(0, :+)
		
  		if recursive_sum > 0
  			if recursive_sum > 790 
  				if recursive_sum <= budget
  					print numbersAdded
  					print "    ....... "
  					print recursive_sum
  					puts 
  					if recursive_sum > $associative_closest_to_budget
  						$associative_closest_to_budget = recursive_sum
  					end
  				end
  				return
  			end
  		end
	
  		numbers.each_with_index do |(k,v),index|
    		# puts"#{index}"
    		# puts k
    		# puts v
    		n = v
    		remaining = numbers.drop(index+1)
    		associative_recursive_addition(remaining, budget, numbersAdded + [n])
  		end
	end	

	simple_recursive_addition(@EMPLOYEE_SHIFT_BLOCK_COST,@BUDGET)
	puts("the closest combination to budget amounted to: ")
  	print $closest_to_budget
  	puts
  	associative_recursive_addition(@ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST,@BUDGET)
  	puts("the closest combination to budget amounted to: ")
  	print $associative_closest_to_budget
  	puts






