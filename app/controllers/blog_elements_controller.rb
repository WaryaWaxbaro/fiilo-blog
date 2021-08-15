class BlogElementsController < ApplicationController
  before_action :set_blog_element, only: %i[ show edit update destroy ]

  # GET /blog_elements or /blog_elements.json
  def index
    @blog_elements = BlogElement.all
  end

  # GET /blog_elements/1 or /blog_elements/1.json
  def show
  end

  # GET /blog_elements/new
  def new
    @blog_element = BlogElement.new
  end

  # GET /blog_elements/1/edit
  def edit
  end

  # POST /blog_elements or /blog_elements.json
  def create
    @blog_element = BlogElement.new(blog_element_params)

    respond_to do |format|
      if @blog_element.save
        #format.html { redirect_to @blog_element, notice: "Blog element was successfully created." }
        format.html { redirect_to edit_post_path(@blog_element.post_id), notice: "Blog element was successfully created." }
        format.json { render :show, status: :created, location: @blog_element }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog_elements/1 or /blog_elements/1.json
  def update
    respond_to do |format|
      if @blog_element.update(blog_element_params)
        #format.html { redirect_to @blog_element, notice: "Blog element was successfully updated." }
        format.html { redirect_to edit_post_path(@blog_element.post_id), notice: "Blog element was successfully updated." }
        format.json { render :show, status: :ok, location: @blog_element }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_elements/1 or /blog_elements/1.json
  def destroy
    @blog_element.destroy
    respond_to do |format|
      format.html { redirect_to blog_elements_url, notice: "Blog element was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_element
      @blog_element = BlogElement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_element_params
      params.require(:blog_element).permit(:content, :blog_image, :element_type, :blog_image_caption, :post_id)
    end
end
