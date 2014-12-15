class CommentsController < ApplicationController
  def create
    if not current_user
      redirect_to :login, notice: "You must be logged in to comment"
    else
      @post = Post.find(params[:post_id])
      @comment = @post.comments.create(comment_params)
      @comment.user = current_user
      @comment.save!
      redirect_to post_path(@post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
