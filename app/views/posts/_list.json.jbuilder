json.data do
  json.array! posts, partial: 'posts/post', as: :post
end
json.partial! 'shared/paging', pagy: @pagy
