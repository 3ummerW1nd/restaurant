class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    params.require(:user).permit(:name, :password, :phone)
    password_digits = BCrypt::Password.create(:password)
    @user = User.new()
  end

end
