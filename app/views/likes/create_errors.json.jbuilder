json.errors do
  json.partial! 'shared/errors', model: @like
end
json.message :create_like_validation_failed
