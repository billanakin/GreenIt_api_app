json.data do
  json.partial! 'like', like: @like
end
json.message :create_like_success
