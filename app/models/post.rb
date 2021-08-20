class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_for, against: %i(title intro), associated_against: {
    user: [:first_name, :last_name]
    #blog_element: [:content],
  }

  belongs_to :user
  has_many :blog_elements, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :cover_image

  has_many :taggings
  has_many :tags, through: :taggings

  scope :published, -> { where(publish: true) }
  scope :published_at, -> { where('publish_at <= ?', DateTime.tomorrow) }

  validates :title, length: {minimum: 5}, presence: true
  validates :intro, length: {minimum: 5}, presence: true

  def views_counter
    self.views_count += 1
    save
  end

  def tag_list
    tags.map(&:name).join(',')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first
    end
  end
end
