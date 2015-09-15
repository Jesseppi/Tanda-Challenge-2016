class CustomRoster

	

	def initialize(numberOfEmployees, customBudget)
		@numberOfEmployees = numberOfEmployees
		@customBudget = customBudget.to_i
		@CUSTOM_EMPLOYEES = []	
		@CUSTOM_EMPLOYEES_WAGES = []
		@CUSTOM_EMPLOYEES_REQUIRED_SHIFT = {}
		@CUSTOM_EMPLOYEE_SHIFT_BLOCK_COST = {}
		@CUSTOM_EMPLOYEES_ROLES = {}
		@closest_to_budget = 0
		@names_on_shift = []
		@hours_worked = []
		@roles_on_shift = []
		setEmployeesDetails(@CUSTOM_EMPLOYEES, @CUSTOM_EMPLOYEES_WAGES, @CUSTOM_EMPLOYEES_REQUIRED_SHIFT,@CUSTOM_EMPLOYEE_SHIFT_BLOCK_COST, @CUSTOM_EMPLOYEES_ROLES)
	end

	def printAnyArray(array, objectDesc)
		arrayLength = array.length
		i = 0
		loop do
			printf " #{objectDesc}: #{array[i]}, ROLE:#{@CUSTOM_EMPLOYEES_ROLES[array[i]]}, HOURS WORKED:#{@CUSTOM_EMPLOYEES_REQUIRED_SHIFT[array[i]]} "
			format = '#{objectDesc}: %s, ROLE: %s, HOURS WORKED: %d '
			sprintf(format,array[i],@CUSTOM_EMPLOYEES_ROLES[array[i]],@CUSTOM_EMPLOYEES_REQUIRED_SHIFT[array[i]])
			i+=1
			puts
			break if i == arrayLength
		end
	end

	def setEmployeesDetails(employees, wages, shiftLength, blockCost, roles)
		for i in 0..@numberOfEmployees-1
			puts "please enter the details for employee number #{i+1} "
			print " Please enter the employees name:"
			employeeName = gets
			employees.insert(i.to_i, employeeName)
			print " Please enter the employees wage rate:"
			employeeWageRate = gets
			wages.insert(i.to_i, employeeWageRate)
			print " Please enter the employees minimum shift length in hours:"
			employeeShiftLength = gets
			# shiftLength.insert(i.to_i, employeeShiftLength)
			shiftLength[employeeName] = (employeeShiftLength)
			employeeBlockCost = employeeShiftLength.to_i * employeeWageRate.to_i
			blockCost[employeeName] = (employeeBlockCost.to_i)
			print "Please enter the employees role [ W = \"waiter\", KH = \"Kitchen Hand\", KHW = \"can do both\" ]: "
			employeeRole = gets
			# roles.insert(i.to_i, employeeRole)
			roles[employeeName]= (employeeRole)
			puts



		end
	end

	def getEmployeeDetails
		for i in 0..@numberOfEmployees-1
			print "EMPLOYEE: #{@CUSTOM_EMPLOYEES[i]}ROLE = #{@CUSTOM_EMPLOYEES_ROLES[i]}HOURLY WAGE = $#{@CUSTOM_EMPLOYEES_WAGES[i]}REQUIRED HOURS = #{@CUSTOM_EMPLOYEES_REQUIRED_SHIFT[@CUSTOM_EMPLOYEES[i]]}SHIFT BLOCK COST = $#{@CUSTOM_EMPLOYEE_SHIFT_BLOCK_COST[@CUSTOM_EMPLOYEES[i]]}"
			puts
		end			
	end

	###### find max hours possible within budget
	def createRosterSimple(numbers, budget, numbersAdded =[], namesAdded = [], rolesAdded = [], hoursWorked = [])
		# print numbers
		recursive_sum = numbersAdded.inject(0, :+)
  		if recursive_sum > 0 && recursive_sum > 2 && recursive_sum <= budget
  					if recursive_sum > @closest_to_budget
  						@closest_to_budget = recursive_sum
  						@names_on_shift = namesAdded
  						@roles_on_shift =  rolesAdded
  						@hours_worked = hoursWorked
  					end
  				elsif recursive_sum > budget
  					return  						
  				end
	
  		numbers.each_with_index do |(k,v),index|
  			puts "#{index} iteration"
  			puts v
  			r =  @CUSTOM_EMPLOYEES_ROLES[k]
  			h =  @CUSTOM_EMPLOYEES_REQUIRED_SHIFT[k]
    		remaining = numbers.drop(index+1)
    		
    		
    		createRosterSimple(remaining, budget, numbersAdded+[v], namesAdded + [k], rolesAdded + [r], hoursWorked + [h])    		 	
  		end
	end	


end