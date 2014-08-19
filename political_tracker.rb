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
	else
		puts "Invalid input"
		main
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
			puts "To edit a representative press [2]"
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





main