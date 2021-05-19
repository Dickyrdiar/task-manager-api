class GroupMailer < ApplicationMailer
    default from: 'dickyardiar1@gmail.com'

    def welcome_email
       @account = recipient 
       mail(to: recipient.email_addres_with_name)
    end 
end
