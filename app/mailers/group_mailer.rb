class GroupMailer < ApplicationMailer
    default from: 'dickyardiar1@gmail.com'

    def welcome_email
        @user = params[:user]
    end 
end
