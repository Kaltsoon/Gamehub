class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :confirm_review, only: [:create]
  before_action :ensure_that_signed_in, only: [:new, :create]
  before_action :verify_reviewer, only: [:destroy]
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
    @latest_reviews = Review.latest
    @highest_score_reviews = Review.highest_score
    @lowest_score_reviews = Review.lowest_score
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @games = Game.all-current_user.games
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    if(@review.save)
      redirect_to game_path(@review.game)
    else
      @games = Game.all-current_user.games
      render :new
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def confirm_review
      if(current_user.nil?)
        redirect_to signin_path
      end
      if(params[:review].has_key?(:game_id))
        game = Game.find(params[:review][:game_id])
        if(game.nil?)
          redirect_to "/"
        elsif(game.users.include?(params[:review][:user_id]))
          redirect_to "/"
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:game_id, :user_id, :score, :content)
    end

    def verify_reviewer
      review = Review.find(params[:id])
      redirect_to "/" unless (!current_user.nil? and current_user.id==review.user.id)
    end
end
