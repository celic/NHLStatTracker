require_dependency "deep_whale/application_controller"

module DeepWhale
	class TeamsController < ApplicationController

		def index
			@teams = Team.all
		end

		def show
			@team = Team.find(params[:id])
		end
	end
end
