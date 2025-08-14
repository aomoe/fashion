class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user

    @my_posts = @user.posts.with_attached_image.order(created_at: :desc)
    @liked_posts = []
  end
end