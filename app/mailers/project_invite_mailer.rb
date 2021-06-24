class ProjectInviteMailer < ApplicationMailer
    def project_invites(project_invite)
        @project_invite = project_invite
        # @email = email
       
        mail(to: @email, subject: "project is for you")
    end 
end
