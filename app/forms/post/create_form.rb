class Post::CreateForm < ActiveType::Record[Post]
  attribute :latitude, :string
  attribute :longitude, :string
  attribute :images, :array

  validates :latitude, presence: true
  validates :longitude, presence: true

  before_validation :set_images
  before_create :set_geo_location

  private

  def set_geo_location
    write_attribute(:geo_location, [latitude, longitude])
  end

  def set_images
    return if images.blank?

    images.sort_by! { |image_hash| image_hash[:rank] }
    assign_unique_ranks!(images)

    images.each { |image_hash| set_image(image_hash) }
  end

  def sort_images(images)
    images.sort_by! { |image_hash| image_hash[:rank] }
  end

  def assign_unique_ranks!(images)
    rank = 0
    images.each do |image_hash|
      image_hash[:rank] = rank
      rank += 1
    end
  end

  def set_image(image_hash)
    data_uri = image_hash[:data_uri]
    image_tempfile = convert_data_uri_to_image_tempfile(data_uri)

    rank = image_hash[:rank]

    post_image = post_images.build(rank: rank)
    post_image.image.attach(io: image_tempfile, filename: SecureRandom.hex)
  end

  def convert_data_uri_to_image_tempfile(data_uri)
    base64_encoded_image = data_uri.split(",").last
    decoded_image = Base64.decode64(base64_encoded_image)
    tempfile = Tempfile.new(binmode: true)
    tempfile.write(decoded_image)
    tempfile.rewind
    tempfile
  end
end
