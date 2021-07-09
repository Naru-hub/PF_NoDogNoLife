class DogsController < ApplicationController
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
      flash[:notice] = "ワンちゃんの登録が完了しました"
      redirect_to dog_path(@dog)
    else
      @dogs = Dog.all
      render 'show'
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :dog_type, :dog_size)
  end
end
