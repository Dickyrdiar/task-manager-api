class InviteMailer < ApplicationMailer
  def user_invite(group_id, email)
    @group = Group.find(group_id)
    mail to: email, subject: "#{@invitation.email} send your link"
  end  
end
