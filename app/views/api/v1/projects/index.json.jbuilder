json.array! @projects do |project|
    json.extract! project, :slug, :id, :image, :name, :desc, :date_begining 
end 