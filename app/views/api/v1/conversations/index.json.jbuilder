json.array! @conversations do |conv|
    json.extract! conv, :id, :author, :receiver, :direct_messages 
end 