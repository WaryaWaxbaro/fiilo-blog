require 'rails_helper'

RSpec.describe "blog_elements/index", type: :view do
  before(:each) do
    assign(:blog_elements, [
      BlogElement.create!(
        content: nil,
        blog_image: "MyText",
        element_type: "Element Type",
        blog_image_caption: "Blog Image Caption"
      ),
      BlogElement.create!(
        content: nil,
        blog_image: "MyText",
        element_type: "Element Type",
        blog_image_caption: "Blog Image Caption"
      )
    ])
  end

  it "renders a list of blog_elements" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Element Type".to_s, count: 2
    assert_select "tr>td", text: "Blog Image Caption".to_s, count: 2
  end
end
