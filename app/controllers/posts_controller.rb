class PostsController < ApplicationController
  # GET /posts or /posts.json
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 15
    query = params[:query]

    all_posts = Post.all
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.fetch(:post, {})
    end
end
