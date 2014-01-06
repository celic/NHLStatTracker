require_dependency "deep_whale/application_controller"

module DeepWhale
	class StatsController < ApplicationController

		def index
			@player = Player.find(params[:player_ids])
			@stats = @player.stats
		end
	end
end
