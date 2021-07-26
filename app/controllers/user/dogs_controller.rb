class User::DogsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @dogs = @user.dogs
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.user_id = current_user.id
    if @dog.save
      redirect_to dog_path(@dog), notice: "わんちゃんの登録が完了しました"
    else
      @user = current_user
      @dogs = @user.dogs
      render 'show'
    end
  end

  def destroy
    dog = Dog.find(params[:id])
    dog.destroy
    redirect_to request.referer, notice: "わんちゃんの情報を削除しました"
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :dog_type, :dog_size)
  end
end
