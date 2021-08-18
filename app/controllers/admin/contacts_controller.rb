class Admin::ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]

  # GET /contacts or /contacts.json
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    query = params[:query]

    contacts_all = Contact.all.order(created_at: :desc)
    contacts_all = contacts_all.search_for(query) unless query.blank?
    @current_page = page
    @pagy, @contacts = pagy(contacts_all, link_extra: 'data-remote="true"', page: page, items: per_page.to_i)

    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /contacts/1 or /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to admin_contact_path(@contact), notice: "Contact was successfully created." }
        format.json { render :show, status: :created, location: admin_contact_path(@contact) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to admin_contact_path(@contact), notice: "Contact was successfully updated." }
        format.json { render :show, status: :ok, location: admin_contact_path(@contact) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to admin_contacts_url, notice: "Contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :message, :extra_info)
    end
end
