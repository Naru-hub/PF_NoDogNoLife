class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(6)
  end
  
  def show
  end
end
