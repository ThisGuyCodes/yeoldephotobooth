class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :verify_owner, except: [:create]

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

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy!

    redirect_to post_url(@post)
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def verify_owner
    if current_user != @comment.user
      # You can delete comments of others on your own posts
      if current_user != @comment.post.user
        redirect_to @comment.post, alert: "You didn't say that, so you can't do that!"
      end
    end
  end
end
