class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_for, against: %i(title intro), associated_against: {
    user: [:first_name, :last_name, :email]
    #blog_element: [:content],
  }

  belongs_to :user
  has_many :blog_elements, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :cover_image

  scope :published, -> { where(publish: true) }
  scope :published_at, -> { where('publish_at < ? ', DateTime.now) }

  def views_counter
    self.views_count += 1
    save
  end
end
