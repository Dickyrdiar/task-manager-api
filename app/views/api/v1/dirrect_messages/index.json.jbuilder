json.array! @direct_messages do |dm| 
    json.extract! dm, :id, :user, :direct_message 
end 