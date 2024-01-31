json.errors do
  json.partial! 'shared/errors', model: @create_form, ignore_errors: %i[post_images]

  if @create_form.errors.key?(:post_images)
    json.set!("images:errors") do
      errored_post_images = @create_form.post_images.reject(&:valid?)
      json.array! errored_post_images do |post_image|
        next if post_image.valid?
        json.partial! 'shared/errors', model: post_image
      end
    end
  end
end
json.message :create_post_validation_failed
