class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "Sign Up Successful!"
      redirect_to new_session_path
    else
      render action: :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :phone, :email, :gender, :birthday, :owner)
  end
end
