class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      tag_names = params[:post][:tag_names].to_s.split(/[\,\s　]+/).map(&:strip).reject(&:blank?).uniq
      tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
      @post.tags = tags

      redirect_to posts_path
      flash[:notice] = "投稿しました"
    else
      render :new, status: :unprocessable_entity
      flash.now[:alert] = "投稿に失敗しました"
    end
  end

  def index
    @posts = Post.includes(:user)
  end

  def edit
  
  end

  def update

  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :original_image_url, :adjusted_image_url, :brightness_level)
  end
end
