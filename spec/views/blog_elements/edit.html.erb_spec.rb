require 'rails_helper'

RSpec.describe "blog_elements/edit", type: :view do
  before(:each) do
    @blog_element = assign(:blog_element, BlogElement.create!(
      content: nil,
      blog_image: "MyText",
      element_type: "MyString",
      blog_image_caption: "MyString"
    ))
  end

  it "renders the edit blog_element form" do
    render

    assert_select "form[action=?][method=?]", blog_element_path(@blog_element), "post" do

      assert_select "input[name=?]", "blog_element[content]"

      assert_select "textarea[name=?]", "blog_element[blog_image]"

      assert_select "input[name=?]", "blog_element[element_type]"

      assert_select "input[name=?]", "blog_element[blog_image_caption]"
    end
  end
end
