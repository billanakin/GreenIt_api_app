class Post < ApplicationRecord
  belongs_to :user
  has_many :post_images, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  scope :trending, -> { order(created_at: :desc) }
  scope :near_me, -> (latitude, longitude) { order(created_at: :desc) }
  scope :latest, -> { order(created_at: :desc).limit(30) }
  scope :recommended, -> { order(created_at: :desc) }
  scope :from_friends, -> (user_id) { order(created_at: :desc) }
end
