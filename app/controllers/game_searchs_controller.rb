class GameSearchsController < ApplicationController
	
	def index
	end

	def search
		@game = GiantBombApi.fetch_game(params[:name])
		if(@game.nil?)
			redirect_to game_search_path, notice: "No results for #{params[:name]}"
		else
			render :index
		end
	end
end