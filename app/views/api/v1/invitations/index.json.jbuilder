json.array! @invitations do |invitation|
    json.extract! invitation, :id, :sender, :email, :token, :recipient_id, :updated_at, :created_at
end 