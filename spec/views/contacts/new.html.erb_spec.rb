require 'rails_helper'

RSpec.describe "contacts/new", type: :view do
  before(:each) do
    assign(:contact, Contact.new(
      name: "MyString",
      email: "MyString",
      phone: "MyString",
      message: "MyText",
      extra_info: "MyText"
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input[name=?]", "contact[name]"

      assert_select "input[name=?]", "contact[email]"

      assert_select "input[name=?]", "contact[phone]"

      assert_select "textarea[name=?]", "contact[message]"

      assert_select "textarea[name=?]", "contact[extra_info]"
    end
  end
end
