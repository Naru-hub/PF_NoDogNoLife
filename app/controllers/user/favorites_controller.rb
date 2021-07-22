class  User::FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = Favorite.new(post_id: @post.id, user_id: current_user.id)
    favorite.save
    @post.create_notification_like!(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: @post.id, user_id: current_user.id)
    favorite.destroy
  end
end
