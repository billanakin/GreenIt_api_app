json.data do
  json.array! comments, partial: 'comments/comment', as: :comment
end
json.partial! 'shared/paging', pagy: @pagy
