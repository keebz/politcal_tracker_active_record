class State < ActiveRecord::Base
	has_many :representatives
	before_save :capitalize_name

private

	def capitalize_name
		self.name = self.name.capitalize
	end
end