class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  respond_to :html, :json

  # GET /users/new
  def new
    @user = User.new
  end

  def show
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'User was successfully created.' if @user.save
      redirect_to root_url
    else
      respond_with @user
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update user_params
      flash[:success] = 'User was successfully updated.'
    end
    redirect_to edit_user_url
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
