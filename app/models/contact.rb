class Contact < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_for, against: %i(name email phone message extra_info)

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validates :message,length: {minimum: 2}, presence: true
end
