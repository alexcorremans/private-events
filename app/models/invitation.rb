class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :invitee, class_name: "User"
  belongs_to :inviter, class_name: "User"
  validates_presence_of :event
  validates_presence_of :invitee
  validate :not_yet_invited

  private

  def not_yet_invited
    return if event_id.blank? || invitee_id.blank?
    if User.find(invitee_id).received_invitations.where(event_id: event_id).exists?
      errors[:base] << "This person has already been invited!"
    end
  end
end
