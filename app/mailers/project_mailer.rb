class ProjectMailer <  ApplicationMailer
    default from: 'teamwork@mail.com'

    def welcome_email
        @user = params[:user] 
    end 
end 