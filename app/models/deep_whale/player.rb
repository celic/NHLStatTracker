module DeepWhale
	class Player < ActiveRecord::Base

		# Validations

		# Relationships
		belongs_to :team
		has_many :stats

		# Functions
	end
end
