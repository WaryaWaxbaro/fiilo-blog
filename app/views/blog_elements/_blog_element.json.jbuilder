json.extract! blog_element, :id, :content, :blog_image, :element_type, :blog_image_caption, :created_at, :updated_at
json.url blog_element_url(blog_element, format: :json)
json.content blog_element.content.to_s
