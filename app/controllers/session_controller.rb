class SessionController < ApplicationController
  def destroy
    logout
    redirect_to api_root_url
  end
end
