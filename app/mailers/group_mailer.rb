class GroupMailer < ApplicationMailer
    default from: 'Teamwork@mail.com'

    def welcome_email 
        @user = params[:user]
        mail(to: @user.email, subject: 'Welcome to Teamwork')
    end 
end
