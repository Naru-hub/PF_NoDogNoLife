class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
    # if params[:sort] == 'desc'
      
    #   @posts = Post.left_joins(:reports).group(:id).select('posts.*, count(reports.id) as report_count')
    #   @posts.sort_by(&:report_count).reverse!
    # elsif params[:sort] == 'asc'
    #   @posts = Post.left_joins(:reports).group(:id).select('posts.*, count(reports.id) as report_count')
    #   @posts.sort_by(&:report_count)
    # end
    
  #   reports = Report.all.count
  #   array = reports.sort do |a, b|
  #     b[:post_id] <=> a[:post_id]
  #   end
  #   @posts = []
  # array.each do |report|
  #   post = Post.find(report.post_id)
  #   @post.push(post)
  # end
    
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path(@post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  def search
    @post = Post.joins(:reports).group("reports.post_id").order("count(reports.id) desc")
  end


  private

  def post_params
    params.require(:post).permit(:report)
  end


end
