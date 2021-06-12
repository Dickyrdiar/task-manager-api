class ProjectInviteMailer < ApplicationMailer
    default from: 'example@mail.com'

    def project_invite
        @project_invite = params[:project_invite]
        @url = 'http://localhost:3001'
        mail(:to => @project_invite.email, :subject => "welcome to project")
    end 
end
