json.data do
  json.partial! 'follow', follow: @follow
end
json.message :create_follow_success
