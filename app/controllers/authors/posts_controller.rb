class Authors::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ edit update destroy ]

  # GET /posts or /posts.json
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    query = params[:query]

    all_posts = current_user.admin? ? Post.all.order(created_at: :desc) : current_user.posts.order(created_at: :desc)
    all_posts = all_posts.search_for(query) unless query.blank?
    @current_page = page
    @pagy, @posts = pagy(all_posts, link_extra: 'data-remote="true"', page: page, items: per_page.to_i)

    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find_by(slug: params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @blog_element = @post.blog_elements.build
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user if current_user
    @post.slug = "#{post_params[:title]}".parameterize

    respond_to do |format|
      if @post.save
        format.html { redirect_to edit_authors_post_path(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to edit_authors_post_path(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to authors_posts_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :title, :intro, :publish, :publish_at, :cover_image)
    end
end
