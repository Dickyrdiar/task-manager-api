class InviteMailer < ApplicationMailer
  def user_invite(invitation)
    # @email = email
    # @url = url
    @invitation = invitation
    mail( to: @email , subject: "welcome to Teamwork")
  end  
end
