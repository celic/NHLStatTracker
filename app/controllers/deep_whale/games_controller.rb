require_dependency "deep_whale/application_controller"

module DeepWhale
	class GamesController < ApplicationController

		def index
			@games = Game.all
		end

		def show
			@game = Game.find(params[:id])
		end
	end
end
