json.data do
  json.partial! 'user', user: @user
end
json.message :update_user_success
