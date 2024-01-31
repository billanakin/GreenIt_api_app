json.data do
  json.array! comments, partial: 'comment', as: :comment
end
json.partial! 'shared/paging', pagy: @pagy
