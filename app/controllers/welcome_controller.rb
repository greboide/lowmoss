class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      user = current_user
      @post = Post.new
      @post.user = user
    else
      user = User.random
    end
    @posts = user.posts.original_post.order('created_at desc')
  end
  def post_comments
    @post = Post.new
    @post.user = current_user
    @post.original_post_id = 1
    respond_to do |format|
      format.js { render :post_comments}
    end
  end
end
