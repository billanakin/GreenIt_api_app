json.data do
  json.array! posts, partial: 'post', as: :post
end
json.partial! 'paging', pagy: @pagy
