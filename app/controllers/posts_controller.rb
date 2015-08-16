class PostsController < ApplicationController
  # before_action :set_post, only: [:show, :edit, :update, :destroy] #

  def post_comments
    @post = Post.new
    @post.user = current_user
    @post.original_post_id = params[:original_post_id]
    post_id = params[:original_post_d]
    respond_to do |format|
      format.js { render :post_comments, locals: {original_post_id: post_id, post_id: post_id} }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        if params[:post][:original_post_id]
          @posts = Post.find(params[:post][:original_post_id]).user.posts.original_post.order('created_at desc')
        else
          @posts = current_user.posts.original_post.order('created_at desc')
        end
        format.js { render :create, layout: false}
      end
    end
  end
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:body, :user_id, :original_post_id)
  end
end
