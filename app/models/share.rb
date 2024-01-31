class Share < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true

  validates :post_id, uniqueness: { scope: :user_id }
end
