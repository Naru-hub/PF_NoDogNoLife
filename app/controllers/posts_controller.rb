class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
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
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    if params[:category_id].present?
      @posts = @posts.where(category_id: params[:category_id])
    end
    if params[:dog_size].present?
      @posts = @posts.where(dog_size: params[:dog_size])
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :category_id, :place, :address, :introduction, :dog_size, :latitude, :longitude)
  end

end
