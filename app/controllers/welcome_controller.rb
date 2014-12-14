class WelcomeController < ApplicationController
  def index
    if current_user
      @posts = Post.all.order created_at: :desc
      render 'posts/index'
    end
  end
end
