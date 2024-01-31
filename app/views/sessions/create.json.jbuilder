json.data do
  json.partial! 'users/user', user: @create_form.user
end
json.auth_token @create_form.auth_token
json.message :signin_success
