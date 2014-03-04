require 'test_helper'

class GenreGamesControllerTest < ActionController::TestCase
  setup do
    @genre_game = genre_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:genre_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create genre_game" do
    assert_difference('GenreGame.count') do
      post :create, genre_game: { game_id: @genre_game.game_id, genre_id: @genre_game.genre_id }
    end

    assert_redirected_to genre_game_path(assigns(:genre_game))
  end

  test "should show genre_game" do
    get :show, id: @genre_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @genre_game
    assert_response :success
  end

  test "should update genre_game" do
    patch :update, id: @genre_game, genre_game: { game_id: @genre_game.game_id, genre_id: @genre_game.genre_id }
    assert_redirected_to genre_game_path(assigns(:genre_game))
  end

  test "should destroy genre_game" do
    assert_difference('GenreGame.count', -1) do
      delete :destroy, id: @genre_game
    end

    assert_redirected_to genre_games_path
  end
end
