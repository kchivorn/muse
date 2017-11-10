class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: "The comment was successfully created."
    else
      redirect_to @post, notice: "The comment failed to be created."
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params[:comment].permit(:content)
  end
end
