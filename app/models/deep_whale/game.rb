module DeepWhale
	class Game < ActiveRecord::Base

		# Validations

		# Relationships
		belongs_to :home_team, class_name: "Team", foreign_key: "home_id"
		belongs_to :away_team, class_name: "Team", foreign_key: "away_id"
		has_many :stats

		# Functions
	end
end
