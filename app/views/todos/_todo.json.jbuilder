json.extract! todo, :id, :title, :description, :status, :created_at, :updated_at
json.url todo_url(todo, format: :json)
