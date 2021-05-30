class InviteMailer < ApplicationMailer
    default from: "dickyardiar1@gmail.com"

    layout 'welcome_email'

    def welcome_email
        @invitation = params[:invitation]
        mail(to: @invitation.email, subject: 'welcome to teamwork please finish the signup')
    end 
end
