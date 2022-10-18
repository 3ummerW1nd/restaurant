class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(phone: user_params[:phone]).try(:authenticate, user_params[:password])
    recaptcha_valid = verify_recaptcha(model: user, action: 'login', minimum_score: 0.1)
    p recaptcha_valid
    # if recaptcha_valid
      if user
        if session[:user_token] && $redis.get(session[:user_token])
          $redis.del(session[:user_token])
        end
        session[:user_token] = user.generate_authentication_token
        if user.owner
          redirect_to restaurants_list_path session[:user_token]
        else
          redirect_to restaurants_path
        end
      else
        flash.now[:login_error] = "invalid phone or password"
        render "new"
      end
    # end
  end

  def logout
    $redis.del(session[:user_token])
    session[:user_token] = nil
    redirect_to new_session_path
  end

  private
  def user_params
    params.require(:session).permit(:phone, :password)
  end
end
