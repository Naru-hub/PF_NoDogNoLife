class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_posts_path, notice: "userの退会情報を更新しました"
    end
  end

  def user_params
    params.require(:user).permit(:is_deleted)
  end
end
