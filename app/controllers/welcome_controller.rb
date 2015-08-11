class WelcomeController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  def index
    respond_to do |format|
      format.html {
        if user_signed_in?
          @user = params[:user_id] ? User.find(params[:user_id]) : current_user
          @post = Post.new
          @post.user = @user
        else
          @user = params[:user_id] ? User.find(params[:user_id]) : User.random
        end
        @posts = @user.posts.original_post.order('created_at desc')
        @users = smart_listing_create :users, User.all, partial: "users/listing"
      }
      format.js {
        if params[:filter]
          query = '%' + params[:filter] + '%'
        else
          query = '%tes%'
        end
        users_scope = User.where(['email like :tag', tag: query])
        @users = smart_listing_create :users, users_scope, partial: "users/listing"
        render 'users/index'
      }
    end
  end
  def search
    users_scope = User.active.joins(:stats)
    users_scope = User.active.joins(:stats)
    users_scope = users_scope.like(params[:filter]) if params[:filter]
    @users = smart_listing_create :users, users_scope, partial: "users/listing"
  end
  # def post_comments
  #   @post = Post.new
  #   @post.user = current_user
  #   @post.original_post_id = 1
  #   respond_to do |format|
  #     format.js { render :post_comments}
  #   end
  # end
end
