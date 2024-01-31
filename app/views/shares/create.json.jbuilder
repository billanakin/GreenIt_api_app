json.data do
  json.partial! 'share', share: @share
end
json.message :create_share_success
