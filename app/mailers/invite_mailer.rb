class InviteMailer < ApplicationMailer
    def welcome_email(invitation)
        @invitation = invitation 
        mail(to: @user.invitation, subject: 'welcome to teamwork please finish the signup')
    end 
end
