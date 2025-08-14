class PostsController < ApplicationController
before_action :set_post, only: [:show, :edit, :update, :destroy]
before_action :authorize_post_owner!, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @post.style_category = current_user.style_category
    @post.height_range = current_user.height_range
    @categories = Category.order(:name)
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
      @categories = Category.order(:name)
      render :new, status: :unprocessable_entity
      flash.now[:alert] = "投稿に失敗しました"
    end
  end

  def index
    @posts = Post.includes(:user)
  end

  def show;end

  def edit
    @categories = Category.order(:name)
  end

  def update
    if @post.update(post_params)
      tag_names = params[:post][:tag_names].to_s.split(/[\,\s　]+/).map(&:strip).reject(&:blank?).uniq
      tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
      @post.tags = tags

      redirect_to @post, notice: '更新しました'
    else
      @categories = Category.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: '投稿を削除しました'
    else
      redirect_to @post, alert: '削除権限がありません'
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :original_image_url, :adjusted_image_url, :brightness_level, :style_category, :height_range, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post_owner!
    unless @post.user_id == current_user&.id
      redirect_to @post, alert: "編集権限がありません"
    end
  end
end
