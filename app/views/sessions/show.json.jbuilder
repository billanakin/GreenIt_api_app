json.data do
  json.partial! 'users/user', user: current_user
end
json.message :session_valid
