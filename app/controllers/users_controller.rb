class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
    @dogs = @user.dogs
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(3)
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     redirect_to user_path(@user),notice: "更新に成功しました。"
    else
     render :edit
    end
  end

  def search
    @users = User.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(6)
  end


  def confirm
  end

  # user退会処理
  def out
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
def user_params
  params.require(:user).permit(:email, :name, :profile_image, :is_deleted)
end

end
