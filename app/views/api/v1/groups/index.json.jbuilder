json.array! @groups do |g| 
    json.extract g, :id, :slug, :name, :desc
end 