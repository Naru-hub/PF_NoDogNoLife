class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # report（通報)があったpost(投稿)だけを多い順で並べる
    if params[:order] == 'desc'
      @posts = Post.joins(:reports).group(:post_id).order('count(post_id) desc').page(params[:page]).per(10)
    # report（通報)があったpost(投稿)だけを少ない順で並べる
    elsif params[:order] == 'asc'
      @posts = Post.joins(:reports).group(:post_id).order('count(post_id) asc').page(params[:page]).per(10)
    # すべての投稿を表示  
    else
      @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to admin_posts_path, notice: "投稿を削除しました"
    end
  end

  private

  def post_params
    params.require(:post).permit(:report)
  end
end
