json.data do
  json.partial! 'comment', comment: @comment
end
json.message :create_comment_success
