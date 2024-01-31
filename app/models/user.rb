class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :post
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :shares, dependent: :destroy
  has_many :shared_posts, through: :shares, source: :post

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_create :attach_temporary_avatar

  private

  def attach_temporary_avatar
    return null if email.blank?

    slug = email.gsub(/\W+/, '-').downcase
    self.profile_pic_url = Faker::Avatar.image(slug: slug, size: "833x786")
  end
end
