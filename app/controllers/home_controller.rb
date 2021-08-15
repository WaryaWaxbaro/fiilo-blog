class HomeController < ApplicationController
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
end
