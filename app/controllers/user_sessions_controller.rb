class UserSessionsController < ApplicationController
  before_action :set_user_session, only: [:destroy]
  respond_to :html, :json

  # GET /user_sessions/new
  def new
    @user_session = UserSession.new
  end

  # POST /user_sessions
  # POST /user_sessions.json
  def create
    @user_session = UserSession.new user_session_params

    if @user_session.save
      flash[:success] = 'Successfully logged in'
      redirect_to root_url
    else
      respond_with @user_session
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.json
  def destroy
    @user_session.destroy
    flash[:success] = 'Successfully loged out'
    redirect_to root_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_session
    @user_session = UserSession.find
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_session_params
    params.require(:user_session).permit(:username, :password)
  end
end
