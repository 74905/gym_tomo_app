class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  
  def following
    user = current_user
    @users = user.following
  end
end
