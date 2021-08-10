require 'rails_helper'

RSpec.describe "blog_elements/new", type: :view do
  before(:each) do
    assign(:blog_element, BlogElement.new(
      content: nil,
      blog_image: "MyText",
      element_type: "MyString",
      blog_image_caption: "MyString"
    ))
  end

  it "renders new blog_element form" do
    render

    assert_select "form[action=?][method=?]", blog_elements_path, "post" do

      assert_select "input[name=?]", "blog_element[content]"

      assert_select "textarea[name=?]", "blog_element[blog_image]"

      assert_select "input[name=?]", "blog_element[element_type]"

      assert_select "input[name=?]", "blog_element[blog_image_caption]"
    end
  end
end
