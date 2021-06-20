json.array! @messages do |message|
    json.extract! message, :id, :slug, :text, :image
end 