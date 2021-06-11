json.array! @groups do |g|
    json.extract! g, :slug, :id, :image, :name, :desc, :date_begining 
end 