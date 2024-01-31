json.id like.id
if current_user?(like.user)
  json.liked_by :me
else
  json.liked_by do
    json.partial! 'users/user', user: like.user
  end
end
json.post do
  json.id like.post_id
end
json.created_at like.created_at
json.updated_at like.updated_at
