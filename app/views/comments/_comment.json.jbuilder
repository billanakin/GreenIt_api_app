json.id comment.id
json.body comment.body
if current_user?(comment.user)
  json.author :me
else
  json.author do
    json.partial! 'users/user', user: comment.user
  end
end
json.post do
  json.id comment.post_id
end
json.created_at comment.created_at
json.updated_at comment.updated_at
