class ProjectInviteMailer < ApplicationMailer
    def projects_ivnites(project_invite_id, email)
        @project_invite = ProjectInvite.find(project_invite_id)
        mail to: email, subject: "#{@project_invite.email} send link to invite you to project"
    end 
end
