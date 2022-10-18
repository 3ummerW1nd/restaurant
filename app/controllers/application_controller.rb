class ApplicationController < ActionController::Base
  private
  def auth_user
    unless session[:user_token] && $redis.get(session[:user_token])
      redirect_to new_session_url
    end
  end
end
