class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def top
    @posts = Post.includes(:user)
  end
end
