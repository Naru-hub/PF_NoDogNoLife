class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @categories = Category.all
    @category = Category.new
  end
  
  def create
    category = Category.new(params_category)
    if category.save
      redirect_to admin_categories_path, notice: "カテゴリーを保存しました"
    else
      @categories = Category.all
      render :index
    end
  end
  
  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to admin_categories_path, notice: "カテゴリーを削除しました"
  end
  
  private
  
  def params_category
    params.require(:category).permit(:name)
  end
  
end
