class InviteMailer < ApplicationMailer
  default from: 'notificationexmpale@example.com'

  def invite_email
    @invitation = params[:invitation]
    @url = 'http://localhost:3001'
    # mail(:to => invitation.email, :subject => "welcome next to signup")
  end  
end
