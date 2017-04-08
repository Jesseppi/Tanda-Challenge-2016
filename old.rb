require_relative 'menu_class'
  require_relative 'custom_roster_class'

	$EMPLOYEES = ["Alex", "Jake", "Tasmin", "Josh", "Adam", "Wayne", "Dave", "Bri", "Scott", "Marissa"]
	$EMPLOYEES_WAGES = [17.79, 19.10, 17.29, 18.47, 17.29, 17.29, 17.29, 19.10, 18.47, 20.13]
	$EMPLOYEES_REQUIRED_SHIFT = [4,5,4,8,8,5,6,9,4,7]
	$EMPLOYEE_SHIFT_BLOCK_COST = [71.16, 95.50, 69.16, 147.76, 138.32, 86.45, 103.74, 171.90, 73.88, 140.91]
  $EMPLOYEE_TYPE = ["KH","KHW","KH","W","KHW","KH","KH","W","W","KHW"]

	$ASSOCIATIVE_EMPLOYEE_TYPE = {"Alex" => "KH", "Jake" => "KHW", "Tasmin" => "KH", "Josh" => "W", "Adam" => "KHW", "Wayne" => "KH", "Dave" => "KH", "Bri" => "W", "Scott" => "W", "Marissa" => "KHW"}
	$ASSOCIATIVE_EMPLOYEE_TYPE.default = "no such person"


	$ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST = {"Alex" => 71.16, "Jake" => 95.50, "Tasmin" => 69.16, "Josh" => 147.76, "Adam" => 138.32, "Wayne" => 86.45, "Dave" => 103.74, "Bri" => 171.90, "Scott" => 73.88, "Marissa" => 140.91}
	$ASSOCIATIVE_EMPLOYEE_SHIFT_LENGTH = {"Alex" => 4, "Jake" => 5, "Tasmin" => 4, "Josh" => 8, "Adam" => 8, "Wayne" => 5, "Dave" => 6, "Bri" => 9, "Scott" => 4, "Marissa" => 7}
	$ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST_double = {"Alex" => 71.16, "Alex2" => 71.16, "Jake" => 95.50, "Jake2" => 95.50, "Tasmin" => 69.16, "Tasmin2" => 69.16, "Josh" => 147.76, "Josh2" => 147.76, "Adam" => 138.32, "Adam2" => 138.32, "Wayne" => 86.45, "Wayne2" => 86.45, "Dave" => 103.74, "Dave2" => 103.74, "Bri" => 171.90, "Bri2" => 171.90, "Scott" => 73.88, "Scott2" => 73.88, "Marissa" => 140.91, "Marissa2" => 140.91 }
	$ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST_triple = {"Alex" => 71.16, "Alex2" => 71.16, "Alex3" => 71.16, "Jake" => 95.50, "Jake2" => 95.50, "Jake3" => 95.50, "Tasmin" => 69.16, "Tasmin2" => 69.16, "Tasmin3" => 69.16, "Josh" => 147.76, "Josh2" => 147.76, "Josh3" => 147.76, "Adam" => 138.32, "Adam2" => 138.32, "Adam3" => 138.32, "Wayne" => 86.45, "Wayne2" => 86.45, "Wayne3" => 86.45, "Dave" => 103.74, "Dave2" => 103.74, "Dave3" => 103.74, "Bri" => 171.90, "Bri2" => 171.90, "Bri3" => 171.90, "Scott" => 73.88, "Scott2" => 73.88, "Scott3" => 73.88, "Marissa" => 140.91, "Marissa2" => 140.91, "Marissa3" => 140.91 }
	$BUDGET = 800.00

	$closest_to_budget = 0
	$names_on_shift = []
	$hours_worked = []
	$roles_on_shift = []

	def printStoredArrays
		i = 0	
		loop do
			print " EMPLOYEE: #{$EMPLOYEES[i]} , ROLE: #{$EMPLOYEE_TYPE[i]}, HOURLY WAGE = $#{$EMPLOYEES_WAGES[i]}, REQUIRED HOURS = #{$EMPLOYEES_REQUIRED_SHIFT[i]}, SHIFT BLOCK COST = $#{$EMPLOYEE_SHIFT_BLOCK_COST[i]}"	
			i+=1
			puts
			break if i==10
		end	
	end

  def zeroOutArrays
    $closest_to_budget = 0
    $names_on_shift = []
    $hours_worked = []
    $roles_on_shift = []
  end

	def printAnyArray(array, objectDesc)
		arrayLength = array.length
		i = 0
		loop do
			print " #{objectDesc}: #{array[i]}, ROLE:#{$ASSOCIATIVE_EMPLOYEE_TYPE[array[i]]}, HOURS WORKED:#{$ASSOCIATIVE_EMPLOYEE_SHIFT_LENGTH[array[i]]} "
			i+=1
			puts
			break if i == arrayLength
		end
	end

	def checkRoleRatio(roles)
		waiters = roles.count("W")
		kitchenhands = roles.count("KH")
		if waiters != 0 && kitchenhands != 0 
			shiftratio = waiters.to_f/kitchenhands.to_f
		else
			shiftratio = 0
		end
		return shiftratio
	end

	def checkIfEmployeeCanBeAdded(role, rolesArray)
		ratio = checkRoleRatio(rolesArray)
		if role == "W" || role == "KHW"
			return true
		elsif role == "KH" && ratio > 2
			return true
		else
			return false
		end
			
	end

	
	###### find max hours possible within budget
	def createRosterSimple(numbers, budget, numbersAdded =[], namesAdded = [], rolesAdded = [], hoursWorked = [])

		recursive_sum = numbersAdded.inject(0, :+)
		
  		if recursive_sum > 0 && recursive_sum > 300 && recursive_sum <= budget
  					if recursive_sum > $closest_to_budget
  						$closest_to_budget = recursive_sum
  						$names_on_shift = namesAdded
  						$roles_on_shift =  rolesAdded
  						$hours_worked = hoursWorked
  					end
  				elsif recursive_sum > budget
  					return  						
  				end
	
  		numbers.each_with_index do |(k,v),index|
  			r =  $ASSOCIATIVE_EMPLOYEE_TYPE[k]
  			h = $ASSOCIATIVE_EMPLOYEE_SHIFT_LENGTH[k]
    		remaining = numbers.drop(index+1)
    		
    		createRosterSimple(remaining, budget, numbersAdded+[v], namesAdded + [k], rolesAdded + [r], hoursWorked + [h])    		 	
  		end
	end	

	 	###### find max hours possible within budget abiding by a ratio of 2(W):1(KH)
	def createRosterRatio(numbers, budget, numbersAdded =[], namesAdded = [], rolesAdded = [])

		recursive_sum = numbersAdded.inject(0, :+)
				
  		if recursive_sum > 0
  			if recursive_sum > 500 
  				if recursive_sum <= budget
  					if recursive_sum > $closest_to_budget
  						$closest_to_budget = recursive_sum
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
  			r =  $ASSOCIATIVE_EMPLOYEE_TYPE[k]
    		remaining = numbers.drop(index+1)
    		if checkIfEmployeeCanBeAdded(r, rolesAdded)
    			createRosterRatio(remaining, budget, numbersAdded+[v], namesAdded + [k], rolesAdded + [r])
    		end    		 	
  		end
	end	



 

 	 def timesheetMenu
 		@exit = false
    # Menu.printWelcomeMenu
 		while(@exit != true)
 			
      puts
      Menu.printWelcomeMenu
 			userChoice = Menu.getUserNumericalChoice(6,9) 
      puts

 			case userChoice
 			when 1
 				puts
 				printStoredArrays
 				puts
        
 			when 2
 				puts
 				Menu.printBreakLine("*",40)
 				puts
 				createRosterSimple($ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST,$BUDGET)
 				print ("the closest employee roster to $#{$BUDGET} amounted to: ")
  			print $closest_to_budget
  			puts
  			printAnyArray($names_on_shift, "EMPLOYEE")
  			Menu.printBreakLine("*",40)
        zeroOutArrays
  			puts
  			puts
          
  		when 3
  			puts
 				Menu.printBreakLine("*",40)
 				puts
 				createRosterSimple($ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST_double,$BUDGET)
 				print ("the closest employee roster to $#{$BUDGET} amounted to: ")
  			print $closest_to_budget
  			puts
  			printAnyArray($names_on_shift, "EMPLOYEE")
  			Menu.printBreakLine("*",40)
        zeroOutArrays
  			puts
  			puts

  		when 4
  			puts
 				Menu.printBreakLine("*",40)
 				puts
 				createRosterSimple($ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST_triple,$BUDGET)
 				print ("the closest employee roster to $#{$BUDGET} amounted to: ")
  			print $closest_to_budget
  			puts
  			printAnyArray($names_on_shift, "EMPLOYEE")
  			Menu.printBreakLine("*",40)
        zeroOutArrays
  			puts
  			puts

  		when 5 
  			puts
 				Menu.printBreakLine("*",40)
 				puts
 				createRosterRatio($ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST,$BUDGET)
 				print ("the closest employee roster to $#{$BUDGET} amounted to: ")
  			print $closest_to_budget
  			puts
  			printAnyArray($names_on_shift, "EMPLOYEE")
  			Menu.printBreakLine("*",40)
        zeroOutArrays
  			puts
  			puts

      when 6
        print "How many employees do you have to enter?:"
        numberOfEmployees = Menu.getUserNumericalChoice(5,9)
        print "What is your shift budget?:"
        budget = gets
        budget = budget.to_i
        customRoster = CustomRoster.new(numberOfEmployees,budget)
        customRoster.getEmployeeDetails
        blockCostArray = customRoster.instance_variable_get("@CUSTOM_EMPLOYEE_SHIFT_BLOCK_COST").clone
        employeeNames = blockCostArray = customRoster.instance_variable_get("@CUSTOM_EMPLOYEES")
        puts
        # print customRoster.instance_variable_get("@CUSTOM_EMPLOYEE_SHIFT_BLOCK_COST")
        # print customRoster.instance_variable_get("@CUSTOM_EMPLOYEES")
        # print customRoster.instance_variable_get("@CUSTOM_EMPLOYEES_ROLES")
        Menu.printBreakLine("*",40)
        puts
        customRoster.createRosterSimple(customRoster.instance_variable_get("@CUSTOM_EMPLOYEE_SHIFT_BLOCK_COST"),budget)
        print ("the closest employee roster to $#{budget} amounted to: ")
        puts customRoster.instance_variable_get("@closest_to_budget")
        # puts names_on_shift.length
        # puts names_on_shift
        customRoster.printAnyArray(customRoster.instance_variable_get("@names_on_shift"), "EMPLOYEE")
        
        

 			when 9		
 				print "exit case reached"
 				@exit = true

 			else
 				@exit = false
 			end

 		end
 	end

  # Running Code ----------------------------
 	Menu.printWelcomeText
 	timesheetMenu