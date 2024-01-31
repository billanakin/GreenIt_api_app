json.errors do
  json.partial! 'shared/errors', model: @share
end
json.message :create_share_validation_failed
