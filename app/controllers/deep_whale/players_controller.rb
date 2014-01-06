require_dependency "deep_whale/application_controller"

module DeepWhale
	class PlayersController < ApplicationController

		def index
			@players = Player.all
		end

		def show
			@player = Player.find(params[:id])
		end
	end
end
