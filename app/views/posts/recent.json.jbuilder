json.data do
  json.array! @recent_posts do |post|
    json.id post.id
    json.title post.title
    json.body post.body
    json.geo_location do
      geo_location = post.geo_location

      json.lat geo_location.x
      json.lon geo_location.y
    end
    json.user do
      user = post.user

      json.id user.id
      json.email user.email
      json.first_name user.first_name
      json.last_name user.last_name
    end
  end
end
json.paging do
  json.page @pagy.page
  json.items @pagy.items
  json.count @pagy.count
end
