class BlogElement < ApplicationRecord
  belongs_to :post
  has_rich_text :content
  has_one_attached :blog_image


  def paragraph?
    element_type == 'paragraph'
  end

  def image?
    element_type == 'image'
  end
end
