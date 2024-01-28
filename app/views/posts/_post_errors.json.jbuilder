errors_hash = post.errors.to_hash
json.data do
  errors_hash.each_pair do |key, value|
    if key == :post_images
      json.post_images do
        json.array! post.post_images do |post_image|
          post_image_errors_hash = post_image.errors.to_hash
          json.rank post_image.rank
          post_image_errors_hash.each_pair do |key, value|
            json.set!(key, value)
          end
        end
      end
    else
      json.set!(key, value)
    end
  end
end
