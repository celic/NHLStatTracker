module DeepWhale
	class Team < ActiveRecord::Base

		# Validations

		# Relationships
		has_many :players
		has_many :games
		
		# Functions
		
	end
end
