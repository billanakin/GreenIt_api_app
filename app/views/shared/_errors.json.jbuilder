errors_hash = model.errors.to_hash
ignore_errors = ignore_errors || []
model.errors.each do |model_error|
  error_key = model_error.attribute.to_sym
  next if ignore_errors.include?(error_key)

  json.set!(error_key) do
    json.type model_error.type
    json.options model_error.options
    json.messages errors_hash[model_error.attribute]
  end
end
