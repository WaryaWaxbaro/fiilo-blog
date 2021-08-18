class Authors::TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy]
  before_action :set_post, only: %i[ index create update destroy]

  # GET /tags or /tags.json
  def index
    query = params[:query]
    posts = @post.tags.map(&:id)
    @tags = Tag.all.where.not(id: posts).where("lower(name) LIKE ?", "%#{query}%".downcase)
    if query.present?
      @tags = @tags.where("lower(name) LIKE ?", "%#{query}%".downcase)
    else
      @tags
    end

    render json: @tags
  end

  # GET /tags/1 or /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        Tagging.create(tag_id: @tag.id, post_id: @post.id)
        format.html { redirect_to edit_authors_post_path(@post), notice: "Tag was successfully created." }
        format.json { render json: {success: 'success'}, status: :created}
      else
        format.html { redirect_to edit_authors_post_path(@post), alert: 'Error. Could not add the tag.' }
        format.json { render json: {error: @tag.errors}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    tagging = Tagging.new(tag_id: @tag.id, post_id: @post.id)
    respond_to do |format|
      if tagging.save
        format.html { redirect_to edit_authors_post_path(@post), notice: "Tag was successfully added to the post." }
        format.json { render json: {success: 'success'}}
      else
        format.html { redirect_to edit_authors_post_path(@post), notice: "Error. Could not add tag to the post" }
        format.json { render json: {error: 'error'}}
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    tagging = Tagging.where(tag_id: @tag.id, post_id: @post.id).first
    #@tag.destroy
    respond_to do |format|
      if tagging
        tagging.destroy
        format.html { redirect_to edit_authors_post_path(@post), notice: "Tag was successfully removed from the post." }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_authors_post_path(@post), notice: "Error deleting the tag." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      #params.require(:tag).permit(:name)
      params.permit(:name, :post_id)
    end
end
