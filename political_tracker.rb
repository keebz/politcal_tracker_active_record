require 'bundler/setup'
require 'pry'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])
DB = PG.connect({:dbname => 'political_tracker_development'})

def main
	puts "Welcome"
	puts "Press [1] if you are a voter"
	puts "Press [2] if you are an admin"
	puts "Press [x] to exit"
	selection = gets.chomp.to_s
	if selection == 'x'
		exit
	elsif selection == '1'
		voter_menu
	elsif selection == '2'
		admin_menu
	elsif selection == '$'
		secret_menu
	else
		puts "Invalid input"
		main
	end
end

def voter_menu
	puts "Enter your state to see your representatives:"
	user_state = gets.chomp.capitalize
	if State.find_by(name: user_state) != nil
		@state = State.find_by(name: user_state)

		Representative.all.each_with_index do |representative, index|

			if @state.id == representative.state_id
				puts (index +1).to_s + ". " + representative.name
			end
		end
		main
	else
		puts "No such state listed. Please contact ADMIN."
		main
	end
end

def secret_menu
	puts "welcome special friend... I missed you."
	puts "to create a new funder for a political representive press [1]"
	puts "to see all of the funders and their representive puppets press [2]"
	puts "to exit press [x]"
	selection = gets.chomp.to_s
	if selection == 'x'
		puts "you saw nothing..."
		sleep 1
		main
	elsif selection == '1'
		add_funder
		secret_menu
	elsif selection == '2'
		secret_list
	else
		puts "Invalid... WHO ARE YOU!?!?"
		main
	end			
end

def add_funder
	puts "Enter funder name:"
	new_funder = Funder.create({name: gets.chomp.capitalize})
	puts "select a puppets number for them to fund:"
	list_representatives
	representive = Representative.all[gets.chomp.to_i - 1]
	representive.funders << new_funder
	puts representive.funders.name + " has been added. shhhhhhh!"
end

def secret_list
	Representative.all.each_with_index do |representive,index|
		puts (index + 1).to_s + ". " + representive.name + " - " + representive.funders[index].name
	end
end

def admin_menu
	puts "Welcome 'ADMIN' Please enter password or type hint for password reminder:"
	password = gets.chomp.to_s

	if password.downcase == 'hint' 
		puts "Who shot JFK?"
		admin_menu
	elsif password.downcase == 'nameht'
		puts "ADMIN confirmed..."
		loop do
			puts "To add a representative press [1]"
			puts "To delete a representative press [2]"
			puts "To add a party press [3]"
			puts "To exit to main menu press [m]"

			selection = gets.chomp.to_s
			if selection == 'm'
				main
			elsif selection == '1'
				add_representative
			elsif selection == '2'
				edit_representative
			elsif selection == '3'
				add_party
			else
				puts "Invalid input"
			end
		end
	else	
		puts "Invalid input"
		main
	end
end

def add_party
	puts "Please enter the name of the new political party:"
	party = Party.create({name: gets.chomp})
	puts party.name + " has been added!"
end

def list_parties
	Party.all.each_with_index do |party, index|
		puts (index + 1).to_s + ". " + party.name
	end
end


def add_representative
	puts "Please enter your new representatives name:"
	name = gets.chomp.capitalize
	puts "Please enter your new representatives state:"
	user_state = gets.chomp.capitalize
		if State.find_by(name: user_state) == nil
			state = State.create({name: user_state})
		else
			state = State.find_by(name: user_state)
		end
	puts "Please enter the name of your new representatives party:"
	list_parties
	party = Party.find_by(name: gets.chomp.capitalize)
	puts "Please enter the type of public servant the representive is:"
	puts "Example: 'Senator'"
	type = Type.create({name: gets.chomp.capitalize})
	new_representative = Representative.create({name: name, state_id: state.id, party_id: party.id, type_id: type.id})
	puts party.name + " " + type.name + " " + new_representative.name + " from the state of " + state.name + " has been added!"
end

def list_representatives
	Representative.all.each_with_index do |representive, index|
		puts (index + 1).to_s + ". " + Party.find_by(id: representive.party_id).name + " " + Type.find_by(id: representive.type_id).name + " " + representive.name + " From :" + State.find_by(id: representive.state_id).name
	end
end

def edit_representative
	list_representatives
	puts "\n\n Select the number for the representative you would like to delete or press [x] to exit:"
	selection = gets.chomp.to_s
	if selection == 'x'
		admin_menu
	end
	representive = Representative.all[selection.to_i - 1]
	representive.destroy
	puts "Deleted!"	
end


main