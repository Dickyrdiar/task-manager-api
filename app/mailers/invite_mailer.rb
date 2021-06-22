class InviteMailer < ApplicationMailer
  def user_invite(invitation)
    # @url = url
    @invitation = invitation
    mail( to: @email , subject: "welcome to Teamwork")
  end  
end
