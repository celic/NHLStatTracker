module DeepWhale
	class Stat < ActiveRecord::Base

		# Validations

		# Relationships
		belongs_to :player
		belongs_to :game

		# Functions
		def points
			goals + assists
		end

		def shot_percentage
			goals.to_f / sog.to_f
		end
	end
end
