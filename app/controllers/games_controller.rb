class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :verify_add, only: [:new, :create]
  before_action :verify_remove, only: [:destroy]
  before_action :verify_edit, only: [:edit, :update]
  # GET /games
  # GET /games.json
  def index
    @games = Game.all
    @latest_games = Game.latest
    @popular_games = Game.most_popular
    @best_games = Game.best
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @genres=Genre.all
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    @genres=Genre.all
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @game }
      else
        format.html { render action: 'new' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    if @game.update(game_params)
      @game.genres.clear
      if(params.has_key?(:genres))
        genres=params.require(:genres)
        genres.each do |g|
          @game.genres.push(Genre.find(g))
        end
      end
      redirect_to game_path(@game), notice: "#{@game} has been updated!"
    else
      @genres=Genre.all
      render :edit
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :published, :description, :avatar)
    end

    def verify_add
      redirect_to "/" unless is_user_allowed_to?("add_game")
    end

    def verify_remove
      redirect_to "/" unless is_user_allowed_to?("remove_game")
    end

    def verify_edit
      redirect_to "/" unless is_user_allowed_to?("edit_game")
    end
end
