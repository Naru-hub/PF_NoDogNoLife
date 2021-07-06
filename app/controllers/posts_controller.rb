class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:image, :category_id, :place, :address, :introduction, :dog_size)
  end

end
