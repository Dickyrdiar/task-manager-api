json.array! @invitations do |invitation|
    json.extract! invitation, :id, :sender, :email, :token, :recipient_id
end 