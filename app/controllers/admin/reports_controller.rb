class Admin::ReportsController < ApplicationController
  
  def destroy
    Report.find_by(post_id: params[:post_id]).destroy
    redirect_to admin_post_path(params[:post_id])
  end
end
