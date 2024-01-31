json.errors do
  json.partial! 'shared/errors', model: @user
end
json.message :update_user_validation_failed
