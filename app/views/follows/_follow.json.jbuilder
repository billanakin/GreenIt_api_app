json.id follow.id
if current_user?(follow.from_user)
  json.from_user :me
else
  json.from_user do
    json.partial! 'users/user', user: follow.from_user
  end
end
if current_user?(follow.to_user)
  json.to_user :me
else
  json.to_user do
    json.partial! 'users/user', user: follow.to_user
  end
end
json.created_at follow.created_at
json.updated_at follow.updated_at
