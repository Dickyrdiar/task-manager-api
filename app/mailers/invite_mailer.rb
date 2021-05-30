class InviteMailer < ApplicationMailer
    default from: "dickyardiar1@gmail.com"

    layout "mailer"

    def welcome_email
        @invitation = params[:invitation]
        mail(to: @invitation.email, subject: 'welcome to teamwork please finish the signup')
    end 
end
