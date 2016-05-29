module ApplicationHelper
  def logged_in?
    cookies[:lockup].present?
  end

end
