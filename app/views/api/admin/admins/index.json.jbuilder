json.array! @admins do |admin|
    json.extract! admin, :id, :email, :username
end 