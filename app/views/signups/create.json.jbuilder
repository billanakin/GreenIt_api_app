json.data do
  json.partial! 'users/user', user: @signup_form
end
json.message :signup_success
