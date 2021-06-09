class InviteMailer < ApplicationMailer
    default from: 'notificationexample@example.com'

    def invite_email
        @invitation = params[:invitation]
        @url = 'http://teamwork.com'
        # mail(to: @invitation.email, subject: 'signup to continue') 
    end 
end
