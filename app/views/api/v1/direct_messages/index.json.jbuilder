json.array! @direct_messages do |dm|
    json.extract! dm, :id, :conversation 
end 