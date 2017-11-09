class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: "The post was created successfully."
    else
      render :new, notice: "The post failed to be created."
    end
  end

  def edit

  end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post, notice: "The post was successfully updated."
    else
      render :edit, notice: "The post failed to be updated."
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, :description)
  end
end
