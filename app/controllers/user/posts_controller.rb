class User::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.joins(:user).where(users: { is_deleted: false }).order(created_at: :desc).page(params[:page]).per(12)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿が完了しました"
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿の編集が完了しました"
    else
      render "edit"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  def search
    @posts = Post.joins(:user).where(users: { is_deleted: false }).search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(12)
    if params[:category_id].present?
      @posts = @posts.where(category_id: params[:category_id])
    end
    if params[:dog_size].present?
      @posts = @posts.where(dog_size: params[:dog_size])
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :category_id, :place, :address, :introduction, :dog_size,
                                 :latitude, :longitude, :report)
  end
end
