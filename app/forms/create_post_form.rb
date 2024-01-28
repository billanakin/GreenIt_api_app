class CreatePostForm < ActiveType::Record[Post]
  attribute :latitude, :string
  attribute :longitude, :string
  attribute :images, :array

  before_validation :set_geo_location
  before_validation :set_images

  private

  def set_geo_location
    return if latitude.blank? || longitude.blank?

    write_attribute(:geo_location, [latitude, longitude])
  end

  def set_images
    return if images.blank?
    @image_tempfiles = []
    images.each { |image_hash| set_image(image_hash) }
  end

  def set_image(image_hash)
    data_uri = image_hash[:data_uri]
    image_tempfile = convert_data_uri_to_image_tempfile(data_uri)

    rank = image_hash[:rank]

    post_image = post_images.build(rank: rank)
    post_image.image.attach(io: image_tempfile, filename: SecureRandom.hex)

    @image_tempfiles << image_tempfile
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
