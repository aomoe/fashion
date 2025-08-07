class PostsController < ApplicationController

  def naw
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.present?
      @post.save
      redirect_to post_edit_path
      flash[ :notice ] = "投稿しました"
    else
      render new_post_path
      flash[ :alert ] = "投稿に失敗しました"
    end
  end

  def index
    @posts = Post.all
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :post_image, :original_image_url, :adjusted_image_url, :brightness_level).merge(user_id: current_user.id)
    end
end
