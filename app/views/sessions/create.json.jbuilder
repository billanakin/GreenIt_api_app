json.data do
  json.partial! 'users/user', user: @signin_form.user
end
json.auth_token @signin_form.auth_token
json.message :signin_success
