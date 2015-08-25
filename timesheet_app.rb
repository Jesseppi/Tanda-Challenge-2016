	@EMPLOYEES = ["Alex", "Jake", "Tasmin", "Josh", "Adam", "Wayne", "Dave", "Bri", "Scott", "Marissa"]
	@EMPLOYEES_WAGES = [17.79, 19.10, 17.29, 18.47, 17.29, 17.29, 17.29, 19.10, 18.47, 20.13]
	@EMPLOYEES_REQUIRED_SHIFT = [4,5,4,8,8,5,6,9,4,7]
	@EMPLOYEE_SHIFT_BLOCK_COST = [71.16, 95.50, 69.16, 147.76, 138.32, 86.45, 103.74, 171.90, 73.88, 140.91]

	@ASSOCIATIVE_EMPLOYEE_TYPE = {"Alex" => "KH", "Jake" => "KHW", "Tasmin" => "KH", "Josh" => "W", "Adam" => "KHW", "Wayne" => "KH", "Dave" => "KH", "Bri" => "W", "Scott" => "W", "Marissa" => "KHW"}
	@ASSOCIATIVE_EMPLOYEE_TYPE.default = "no such person"


	@ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST = {"Alex" => 71.16, "Jake" => 95.50, "Tasmin" => 69.16, "Josh" => 147.76, "Adam" => 138.32, "Wayne" => 86.45, "Dave" => 103.74, "Bri" => 171.90, "Scott" => 73.88, "Marissa" => 140.91}
	@ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST_double = {"Alex" => 71.16, "Alex2" => 71.16, "Jake" => 95.50, "Jake2" => 95.50, "Tasmin" => 69.16, "Tasmin2" => 69.16, "Josh" => 147.76, "Josh2" => 147.76, "Adam" => 138.32, "Adam2" => 138.32, "Wayne" => 86.45, "Wayne2" => 86.45, "Dave" => 103.74, "Dave2" => 103.74, "Bri" => 171.90, "Bri2" => 171.90, "Scott" => 73.88, "Scott2" => 73.88, "Marissa" => 140.91, "Marissa2" => 140.91 }
	@ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST_triple = {"Alex" => 71.16, "Alex2" => 71.16, "Alex3" => 71.16, "Jake" => 95.50, "Jake2" => 95.50, "Jake3" => 95.50, "Tasmin" => 69.16, "Tasmin2" => 69.16, "Tasmin3" => 69.16, "Josh" => 147.76, "Josh2" => 147.76, "Josh3" => 147.76, "Adam" => 138.32, "Adam2" => 138.32, "Adam3" => 138.32, "Wayne" => 86.45, "Wayne2" => 86.45, "Wayne3" => 86.45, "Dave" => 103.74, "Dave2" => 103.74, "Dave3" => 103.74, "Bri" => 171.90, "Bri2" => 171.90, "Bri3" => 171.90, "Scott" => 73.88, "Scott2" => 73.88, "Scott3" => 73.88, "Marissa" => 140.91, "Marissa2" => 140.91, "Marissa3" => 140.91 }
	@BUDGET = 800.00

	def print_arraysyeah
		i = 0	
		loop do
			print " #{@EMPLOYEES[i]} , HOURLY WAGE = $#{@EMPLOYEES_WAGES[i]}, REQUIRED HOURS = #{@EMPLOYEES_REQUIRED_SHIFT[i]}, SHIFT BLOCK COST = $#{@EMPLOYEE_SHIFT_BLOCK_COST[i]}"	
			i+=1
			puts
			break if i==10
		end	
	end

		def checkRoleRatio(roles)
		waiters = roles.count("W")
		# puts waiters
		kitchenhands = roles.count("KH")
		# puts kitchenhands
		if waiters != 0 && kitchenhands != 0 
			shiftratio = waiters.to_f/kitchenhands.to_f
		else
			shiftratio = 0
		end
		# puts shiftratio
		return shiftratio
	end

	def checkIfEmployeeCanBeAdded(role, rolesArray)
		ratio = checkRoleRatio(rolesArray)
		# puts role
		if role == "W" || role == "KHW"
			return true
		elsif role == "KH" && ratio > 2
			return true
		else
			return false
		end
			
	end

	$associative_closest_to_budget = 0
	$names_on_shift = []
	$roles_on_shift = []

	def associative_recursive_addition(numbers, budget, numbersAdded =[], namesAdded = [], rolesAdded = [])

		recursive_sum = numbersAdded.inject(0, :+)
		print numbersAdded
		puts
		
  		if recursive_sum > 0
  			if recursive_sum > 790 
  				if recursive_sum <= budget
  					# print numbersAdded
  					# print namesAdded
  					# print "    ....... "
  					# print recursive_sum
  					# puts 
  					if recursive_sum > $associative_closest_to_budget
  						$associative_closest_to_budget = recursive_sum
  						$names_on_shift = namesAdded
  						$roles_on_shift =  rolesAdded
  					end
  				elsif recursive_sum > budget
  					return  						
  				end
  				return
  			end
  		end
	
  		numbers.each_with_index do |(k,v),index|
  			r =  @ASSOCIATIVE_EMPLOYEE_TYPE[k]
  			# puts checkIfEmployeeCanBeAdded(r, rolesAdded) ? "can be added":"*******"
    		# puts"#{index}"
    		# puts k
    		# puts v
    		remaining = numbers.drop(index+1)
    		# if checkIfEmployeeCanBeAdded(r, rolesAdded)
    		# 	puts "in"
    		# 	print numbersAdded
    		# end
    		 	associative_recursive_addition(remaining, budget, numbersAdded+[v], namesAdded + [k], rolesAdded + [r])
  		end
	end	

 	###### associative code
  	associative_recursive_addition(@ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST,@BUDGET)
  	puts("the closest combination to budget amounted to: ")
  	print $associative_closest_to_budget
  	puts
  	print $names_on_shift
  	puts
  	print  $roles_on_shift  	
  	puts

  	# associative_recursive_addition(@ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST_triple,@BUDGET)
  	# puts("the closest combination to budget amounted to: ")
  	# print $associative_closest_to_budget
  	# puts
  	# print $names_on_shift
  	# puts


  	# sample array to test check role ratio
  	# @sample_roles = ["KH", "KH", "W", "W", "W", "W","W"]







