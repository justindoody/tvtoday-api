module UserHelper
  def logged_in?
    current_user.present?
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in_user
    redirect_to login_path, notice: 'Please sign in.' unless logged_in?
  end

  def current_user
    if session[:user_id].present?
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
