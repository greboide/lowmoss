class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def post_comments
    @post = Post.new
    @post.user = current_user
    @post.original_post_id = params[:original_post_id]
    post_id = params[:original_post_d]
    respond_to do |format|
      format.js { render :post_comments, locals: {original_post_id: post_id, post_id: post_id} }
    end
  end
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        @posts = current_user.posts.original_post.order('created_at desc')
        @post = Post.new(post_params)
        format.js { render :create, layout: false}
      else
        format.js { render :error_form,
                             layout: false }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body, :user_id, :original_post_id)
    end
end
