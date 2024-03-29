class User::DogsController < ApplicationController
  before_action :authenticate_user!

  def dog_form
    @user = current_user
    @dogs = @user.dogs
    @dog = Dog.new
  end
  
  def create
    @dog = Dog.new(dog_params)
    @dog.user_id = current_user.id
    if @dog.save
      redirect_to dog_form_path, notice: "わんちゃんの登録が完了しました"
    else
      @user = current_user
      @dogs = @user.dogs
      render 'dog_form'
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
