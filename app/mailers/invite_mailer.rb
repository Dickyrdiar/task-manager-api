class InviteMailer < ApplicationMailer
    default from: "dickyardiar1@gmail.com"

    def inivite_email
        @invitation = invitation
        mail(to: @invitation.email, subject: 'join group')
    end 
end
