json.array! @projects do |project|
    json.extract! project, :slug, :id, :name, :desc, :date_begining 
end 