class Post < ApplicationRecord
  DEFAULT_NEAR_ME_DISTANCE_IN_MILES = 100

  geocoded_by :geo_location

  belongs_to :user
  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :shares, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  after_commit :update_latitude_and_longitude

  scope :trending, -> { where("#{Post.table_name}.shares_count > 0").order(shares_count: :desc, created_at: :desc) }
  scope :latest, -> { order(created_at: :desc, created_at: :desc) }
  scope :recommended, -> { where("#{Post.table_name}.likes_count > 0").order(likes_count: :desc, created_at: :desc) }
  scope :from_friends, -> (current_user) { joins(:user).where(posts: { user_id: current_user.followed_users.pluck(:id) }).order(created_at: :desc) }

  private

  def update_latitude_and_longitude
    return if geo_location.blank?

    update_column(:latitude, geo_location.x)
    update_column(:longitude, geo_location.y)
  end
end
