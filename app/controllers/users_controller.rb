class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end 
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] = "プロフィールが更新されました！"
     redirect_to user_path(@user)
    else
      render :edit
    end
  end 
  
  def following
    @user = current_user
    @users = @user.following
  end
  
  def followers
    @user = current_user
    @users = @user.followers
  end 
  
  private 
  
  def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end
