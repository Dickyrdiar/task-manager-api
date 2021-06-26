json.array! @direct_messages do |dm|
    json.extract! dm, :id, :text, :image, :user, :created_at 
end 