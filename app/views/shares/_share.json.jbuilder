json.id share.id
if current_user?(share.user)
  json.shared_by :me
else
  json.shared_by do
    json.partial! 'users/user', user: share.user
  end
end
json.post do
  json.id share.post_id
end
json.created_at share.created_at
json.updated_at share.updated_at
