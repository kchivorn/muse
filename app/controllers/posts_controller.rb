class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @comments = Comment.all.order(created_at: :desc)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
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

  def upvote
    @post.upvote_by current_user
    redirect_to @post
  end

  def downvote
    @post.downvote_by current_user
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, :description, :image)
  end
end
