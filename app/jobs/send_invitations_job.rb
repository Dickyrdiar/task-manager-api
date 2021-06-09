class SendInvitationsJob < ApplicationJob
  queue_as :invitations

  def perform(invitation_id)
    invite = Invitation.find(invitation_id)

    InviteMailer.invite(user).deliver_now
  end
end
