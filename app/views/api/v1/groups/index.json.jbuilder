json.array! @groups do |group| 
    json.extract group, :id, :slug, :name, :desc
end 