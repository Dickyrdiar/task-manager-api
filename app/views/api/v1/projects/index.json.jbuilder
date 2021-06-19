json.array! @projects do |project|
    json.extract! project, :slug, :id, :image, :user, :name, :desc, :date_begining
end 