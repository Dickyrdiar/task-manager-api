class SendInviteProjectsEmailJob < ApplicationJob
  queue_as :invite_projects

  def perform(project_invite_id)
    project_invite = ProjectInvite.find(project_invite_id)
    ProjectInvite.projects_ivnites(project_invite).deliver_now
  end
end
