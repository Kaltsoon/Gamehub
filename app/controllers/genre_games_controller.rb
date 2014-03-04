class GenreGamesController < ApplicationController
  before_action :set_genre_game, only: [:show, :edit, :update, :destroy]

  # GET /genre_games
  # GET /genre_games.json
  def index
    @genre_games = GenreGame.all
  end

  # GET /genre_games/1
  # GET /genre_games/1.json
  def show
  end

  # GET /genre_games/new
  def new
    @genre_game = GenreGame.new
  end

  # GET /genre_games/1/edit
  def edit
  end

  # POST /genre_games
  # POST /genre_games.json
  def create
    @genre_game = GenreGame.new(genre_game_params)

    respond_to do |format|
      if @genre_game.save
        format.html { redirect_to @genre_game, notice: 'Genre game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @genre_game }
      else
        format.html { render action: 'new' }
        format.json { render json: @genre_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /genre_games/1
  # PATCH/PUT /genre_games/1.json
  def update
    respond_to do |format|
      if @genre_game.update(genre_game_params)
        format.html { redirect_to @genre_game, notice: 'Genre game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @genre_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genre_games/1
  # DELETE /genre_games/1.json
  def destroy
    @genre_game.destroy
    respond_to do |format|
      format.html { redirect_to genre_games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre_game
      @genre_game = GenreGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genre_game_params
      params.require(:genre_game).permit(:game_id, :genre_id)
    end
end
