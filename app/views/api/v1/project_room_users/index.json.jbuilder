json.array! @project_room_users do |pru|
    json.extract! pru, :id, :project, :messages
end 