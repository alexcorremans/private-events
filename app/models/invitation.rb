class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :invitee, class_name: "User"
  belongs_to :inviter, class_name: "User"
  validates_presence_of :event
  validates_presence_of :invitee
  validate :not_yet_invited

  scope :pending, -> { where(accepted: "pending") }

  def pending?
    Invitation.pending.exists?(self.id)
  end

  private

  def not_yet_invited
    return if event_id.blank? || invitee_id.blank?
    if User.find(invitee_id).received_invitations.where(event_id: event_id).exists?
      errors[:base] << "You've already invited this person to this event!"
    end
  end
end
