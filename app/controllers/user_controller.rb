
class UserController < ApplicationController
  def new
  end

  def create
    user = User.first
    if user && user.authenticate(params[:user][:password])
      log_in user
      redirect_to api_shows_path
    else
      flash[:danger] = 'Wrong password, try again...'
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end
end
