class User::ReportsController < ApplicationController

  def create
    report = current_user.reports.new(post_id: params[:post_id])
    if report.save
      redirect_to posts_path, notice: "不適切な表現の投稿を通報しました"
    else
      render show
    end  
  end

end
