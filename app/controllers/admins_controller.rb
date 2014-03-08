class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :verify_give_rights, only: [:index, :new, :edit, :create, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @users = User.all
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
    @users = User.all
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admins_path, notice: 'Admin was successfully created.'
    else
      @users = User.all
      render :new
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    if @admin.update(admin_params)
      redirect_to admins_path, notice: 'Admin was successfully updated.'
    else
      @users = User.all
      render :edit
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:user_id, :add_game, :remove_game, :edit_game, :add_genre, :remove_genre, :edit_genre, :give_rights)
    end

    def verify_give_rights
      redirect_to "/" unless is_user_allowed_to?("give_rights")
    end
end
