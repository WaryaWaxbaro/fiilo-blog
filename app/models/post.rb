class Post < ApplicationRecord
  belongs_to :user
  has_many :blog_elements

  has_one_attached :cover_image
end
