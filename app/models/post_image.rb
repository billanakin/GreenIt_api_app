class PostImage < ApplicationRecord
  IMAGE_MAX_SIZE = 3.megabyte
  ACCEPTABLE_IMAGE_TYPES = [
    "image/jpeg",
    "image/png"
  ].freeze

  belongs_to :post

  has_one_attached :image

  validate :image_size_validation, if: ->{ image.attached? }
  validate :image_type_validation, if: ->{ image.attached? }

  private

  def image_size_validation
    return if image.blob.byte_size <= IMAGE_MAX_SIZE

    errors.add(:image, "is too big")
  end

  def image_type_validation
    return if ACCEPTABLE_IMAGE_TYPES.include?(image.content_type)

    errors.add(:image, "must be a JPEG or PNG")
  end
end
