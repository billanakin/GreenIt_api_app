class Post < ApplicationRecord
  belongs_to :user
  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  scope :trending, -> { order(created_at: :desc) } #TODO: 
  scope :near_me, -> { order(created_at: :desc) } #TODO: 
  scope :latest, -> { order(created_at: :desc).limit(30) } #TODO: 
  scope :recommended, -> { order(created_at: :desc) } #TODO: 
  scope :from_friends, -> { order(created_at: :desc) } #TODO: 
end
