	require_relative 'menu_class'
  require_relative 'custom_roster_class'
  require 'facets/hash/except'

  $EMPLOYEES = {
                "Alex" => {"wage" => 17.79, "minShift" => 4, "shiftBlockCost" => 71.16, "EmployeeType" => "KH"},
                "Jake" => {"wage" => 19.10, "minShift" => 5, "shiftBlockCost" => 95.50, "EmployeeType" => "KHW"},
                "Tamsin" => {"wage" => 17.29, "minShift" => 4, "shiftBlockCost" => 69.16, "EmployeeType" => "KH"},
                "Josh" => {"wage" => 18.47, "minShift" => 8, "shiftBlockCost" => 147.76, "EmployeeType" => "W"},
                "Adam" => {"wage" => 17.29, "minShift" => 8, "shiftBlockCost" => 138.32, "EmployeeType" => "KHW"},
                "Wayne" => {"wage" => 17.29, "minShift" => 5, "shiftBlockCost" => 86.45, "EmployeeType" => "KH"},
                "Dave" => {"wage" => 17.29, "minShift" => 6, "shiftBlockCost" => 103.74, "EmployeeType" => "KH"},
                "Bri" => {"wage" => 19.10, "minShift" => 9, "shiftBlockCost" => 171.90, "EmployeeType" => "W"},
                "Scott" => {"wage" => 18.47, "minShift" => 4, "shiftBlockCost" => 73.88, "EmployeeType" => "W"},
                "Marissa" =>  {"wage" => 20.13, "minShift" => 7, "shiftBlockCost" => 140.91, "EmployeeType" => "KHW"}
                }
	
	$BUDGET = 800.00

	$closest_to_budget = 0
	$names_on_shift = []
	$hours_worked = []
	$roles_on_shift = []

	def printStoredArrays
		i = 0	
		$EMPLOYEES.each do |key,value|
			print  "EMPLOYEE: #{key} ROLE: #{value["EmployeeType"]}, HOURLY WAGE = $#{value["wage"]}, REQUIRED HOURS = #{value["minShift"]}, SHIFT BLOCK COST = $#{value["shiftBlockCost"]}"	
			puts			
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
    total = 0
		i = 0
		array.each do |key|   
			print " #{objectDesc}: #{key}, ROLE:#{$EMPLOYEES[key]["EmployeeType"]}, HOURS WORKED:#{$EMPLOYEES[key]["minShift"]}, WAGE PAID:#{$EMPLOYEES[key]["shiftBlockCost"]}"
      total += $EMPLOYEES[key]["shiftBlockCost"] 
			i+=1
			puts
			break if i == arrayLength
		end
    puts total
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
	
  		  numbers.each_with_index do |(k,v), index|
  			  remaining = numbers.drop(index+1)
          createRosterSimple(remaining, budget, numbersAdded+[v], namesAdded +[k], rolesAdded + [$EMPLOYEES[k]["EmployeeType"]], hoursWorked + [$EMPLOYEES[k]["minShift"]])    		 	
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

  def stripHashToArray(hash)
    stripHash = {}
    hash.each do |key,value|
      stripHash[key] = value["shiftBlockCost"]
    end
    return stripHash
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
        h = stripHashToArray($EMPLOYEES)
        puts h
 				createRosterSimple(h,$BUDGET)
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
        budget = Menu.getUserNumber(4000)
        # budget = budget.to_i
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


  # customEmplopyees = CustomRoster.new(2,100) 
  # # print customEmplopyees.instance_variable_get("@CUSTOM_EMPLOYEES_ROLES")
  # # print customEmplopyees.instance_variable_get("@CUSTOM_EMPLOYEES_REQUIRED_SHIFT")
  # # print customEmplopyees.instance_variable_get("@CUSTOM_EMPLOYEES")
  # # print customEmplopyees.instance_variable_get("@CUSTOM_EMPLOYEES_WAGES")
  # blockCostArray = customEmplopyees.instance_variable_get("@CUSTOM_EMPLOYEE_SHIFT_BLOCK_COST")
  # print blockCostArray
  # customBudget = customEmplopyees.instance_variable_get("@customBudget")
  # # print customBudget
  # customEmplopyees.createRosterSimple(blockCostArray,customBudget)
  # print customEmplopyees.instance_variable_get("@closest_to_budget")
  # print customEmplopyees.instance_variable_get("@names_on_shift")
  # print customEmplopyees.instance_variable_get("@roles_on_shift")
  # print customEmplopyees.instance_variable_get("@hours_worked")

  # customTest = CustomRoster.new(1,100)
  # customTest.getEmployeeDetails 

  	# createRosterSimple(@ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST,@BUDGET)
  	# puts("the closest combination of hours to budget amounted to: ")
  	# print "$"
  	# print $closest_to_budget
  	
  	# puts
  	# print $names_on_shift
  	# puts
  	# print  $roles_on_shift  	
  	# puts
  	# print $hours_worked

  	# associative_recursive_addition(@ASSOCIATIVE_EMPLOYEE_SHIFT_BLOCK_COST_triple,@BUDGET)
  	# puts("the closest combination to budget amounted to: ")
  	# print $closest_to_budget
  	# puts
  	# print $names_on_shift
  	# puts


  	# sample array to test check role ratio
  	# @sample_roles = ["KH", "KH", "W", "W", "W", "W","W"]







