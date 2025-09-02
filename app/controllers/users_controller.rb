class UsersController < ApplicationController

  def show
    @user = current_user

    @my_posts = @user.posts.with_attached_image.order(created_at: :desc)
    @liked_posts = @user.liked_posts.with_attached_image.order(created_at: :desc)
    @liked_posts_count = @user.liked_posts_count
  end
end