json.errors do
  json.partial! 'shared/errors', model: @create_comment_form
end
json.message :create_comment_validation_failed
