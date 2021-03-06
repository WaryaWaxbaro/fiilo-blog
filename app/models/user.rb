class User < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_for, against: %i(first_name last_name email phone)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable

  has_many :posts
  has_many :comments

  has_one_attached :avatar

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    roles.include? 'admin'
  end

  def author?
    roles.include? 'author'
  end
end
