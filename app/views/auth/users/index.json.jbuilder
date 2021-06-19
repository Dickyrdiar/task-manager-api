json.array! @users do |user| 
    json.extract! :email, :username, :created_at
end 