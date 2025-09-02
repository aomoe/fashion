class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    unless @post.liked_by?(current_user)
      @post.likes.create(user: current_user)
    end

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    like = @post.likes.find_by(user: current_user)
    like&.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
