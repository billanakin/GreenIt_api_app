json.id post.id
json.title post.title
json.body post.body
json.latitude post.geo_location&.x
json.longitude post.geo_location&.y
json.author do
  json.partial! 'users/post', user: post.user
end
json.images do
  json.array! post.post_images.order(rank: :asc), partial: 'post_images/post_image', as: :post_image
end
