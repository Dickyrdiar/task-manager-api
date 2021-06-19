json.array! @messages do |message|
    json.extract! message, :id, :slug, :ext
end 