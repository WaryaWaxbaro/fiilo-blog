class BlogElement < ApplicationRecord
  belongs_to :post
  has_rich_text :content
  has_one_attached :blog_image
end
