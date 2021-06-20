json.array! @users do |user| 
    json.extract! user, :email, :username
end 