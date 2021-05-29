class InviteMailer < ApplicationMailer
    def welcome_email
        @invitation = invitation 
        mail(to: @invitation.email, subject: 'welcome to teamwork please finish the signup')
    end 
end
