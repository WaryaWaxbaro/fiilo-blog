require 'rails_helper'

RSpec.describe "blog_elements/show", type: :view do
  before(:each) do
    @blog_element = assign(:blog_element, BlogElement.create!(
      content: nil,
      blog_image: "MyText",
      element_type: "Element Type",
      blog_image_caption: "Blog Image Caption"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Element Type/)
    expect(rendered).to match(/Blog Image Caption/)
  end
end
