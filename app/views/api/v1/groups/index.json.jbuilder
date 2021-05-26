json.array! @groups do |grpups|
    json.extract! grpups, :slug, :id, :name, :desc
end 