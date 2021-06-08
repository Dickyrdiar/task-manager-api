json.array! @invitations do |invitation|
    json.extract! invitation, :id, :email, :token, :recipient_id
end 