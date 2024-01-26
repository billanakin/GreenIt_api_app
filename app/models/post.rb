class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  scope :recent, -> { order(created_at: :desc).limit(30) }
end
