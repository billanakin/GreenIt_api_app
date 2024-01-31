class Follow < ApplicationRecord
  belongs_to :from_user, class_name: User.name, counter_cache: :following_count
  belongs_to :to_user, class_name: User.name

  validates :to_user_id, uniqueness: { scope: :from_user_id }

  after_create :increment_to_user_follower_count
  after_destroy :decrement_to_user_follower_count

  private

  def increment_to_user_follower_count
    update_to_user_follower_count(to_user.follower_count + 1)
  end

  def decrement_to_user_follower_count
    update_to_user_follower_count(to_user.follower_count - 1)
  end

  def update_to_user_follower_count(updated_count)
    updated_count = 0 if updated_count.negative?
    to_user.update_column(:follower_count, updated_count)
  end
end
