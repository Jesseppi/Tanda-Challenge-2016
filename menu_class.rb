class Menu

	def self.printWelcomeText
		puts "WELCOME TO THE CHALLENGING TIMESHEETING APP"
		puts
	end

	def self.printWelcomeMenu
		
		puts "you have a couple of options: "
		puts "1. Print the stored details of employees"
		puts "2. Find the roster with max hours assuming only 1 shift per employee"
		puts "3. Find the roster with max hours assuming 2 possible shifts per employee"
		puts "4. Find the roster with max hours assuming 3 possible shifts per employee"
		puts "5. Find the roster with max hours assuming a ratio of 2:1 Waiter to kitchen hands"
		puts "9. Exit this program"
	end

	def self.getUserNumericalChoice(maxChoice, exitChoice)
		userChoice = 0
		puts
		errorMessage = "Your choice is invalid, please enter a number corresponding to a menu choice."
		while(userChoice.to_i > maxChoice || userChoice.to_i < 1)
			puts "Please enter the number of your choice: "
			begin
				userChoice = gets
			rescue
				puts errorMessage
				userChoice = 0
			end
			if userChoice.to_i == exitChoice
				return userChoice
			elsif (userChoice.to_i > maxChoice || userChoice.to_i< 1)
				puts errorMessage
			end					
		end
		return userChoice.to_i
	end

	def self.printBreakLine(symbol,repititions)
  		$i = 0
  		loop do
  			print symbol
  			$i+=1
  			break if $i == repititions 
  		end
  	end



end