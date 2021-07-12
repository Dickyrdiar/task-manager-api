json.array! @projects do |project|
    json.extract! project, :slug, :id, :user, :name, :desc, :date_begining
end 