json.array! @projects do |project|
    json.extract! project, :slug, :id, :name, :desc, :project_invites, :date_begining 
end 