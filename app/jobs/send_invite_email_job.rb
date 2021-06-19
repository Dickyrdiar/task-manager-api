class SendInviteEmailJob < ApplicationJob
  queue_as :invite_email

  def perform(invitation_id)
    invitation = Invitation.find(invitation_id)
    InviteMailer.user_invite(invitation).deliver_now
  end
end
