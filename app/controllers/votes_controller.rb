class VotesController < ApplicationController
	before_action :verify_vote, only: [:create]

	def create
		@vote = Vote.new(vote_params)
		if(@vote.save)
			redirect_to "#{game_path(@vote.review.game)}#review_#{@vote.review.id}"
		end
	end

	private

		def vote_params
	      params.require(:vote).permit(:user_id, :value, :review_id)
	    end

	    def verify_vote
	    	redirect_to "/" if(current_user.nil? or current_user!=User.find(params[:vote][:user_id]))
	    end
end