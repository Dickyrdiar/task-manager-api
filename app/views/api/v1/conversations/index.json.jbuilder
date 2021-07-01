json.array! @direct_message do |dm|
    json.extract! dm, :id, :body 
end 