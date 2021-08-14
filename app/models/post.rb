class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_for, against: %i(title, intro), associated_against: {
    blog_element: [:content],
    user: [:first_name, :last_name, :email]
  }

  belongs_to :user
  has_many :blog_elements

  has_one_attached :cover_image
end
