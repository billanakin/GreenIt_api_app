json.id post.id
json.title post.title
json.body post.body
json.latitude post.geo_location&.x
json.longitude post.geo_location&.y
if current_user?(post.user)
  json.author :me
else
  json.author do
    json.partial! 'users/user', user: post.user
  end
end
json.images do
  json.array! post.post_images.order(rank: :asc), partial: 'post_images/post_image', as: :post_image
end
