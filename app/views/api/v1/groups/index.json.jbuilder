json.array! @groups do |g|
    json.extract! g, :id, :slug, :name, :desc, :created_at, :updated_at
end 