class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :get_s3, only: [:new, :edit]
  before_action :verify_owner, except: [:create, :new, :index, :show]

  # GET /posts
  # GET /posts.json
  def index
    if current_user
      @posts = current_user.posts.all.order created_at: :desc
      @hide_author = true
    else
      @posts = Post.all.order created_at: :desc
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    if not current_user
      redirect_to :login
    else
      @post = current_user.posts.new
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    if not current_user
      redirect_to :login
    else
      @post = current_user.posts.new(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    old_image = @post.image_key
    respond_to do |format|
      if @post.update(post_params)
        S3_BUCKET.objects[old_image].delete
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
    if @post.image_key
      S3_BUCKET.objects[@post.image_key].delete
    end
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
    params.require(:post).permit(:title, :body, :image_key)
  end

  def verify_owner
    if current_user != @post.user
      redirect_to @post, alert: "Not yours, so you can't do that!"
    end
  end

  def get_s3
    @s3_direct_post = S3_BUCKET.presigned_post(key: "posts/#{current_user.id}/#{SecureRandom.uuid}", success_action_status: 201, acl: :public_read)
  end
end
