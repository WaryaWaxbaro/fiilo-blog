class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings

  attr_accessor :post_id

  validates :name, presence: true
end
