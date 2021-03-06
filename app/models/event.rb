class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_and_belongs_to_many :attendees, class_name: "User",
                                      join_table: "attended_events_attendees",
                                      foreign_key: "attended_event_id", 
                                      association_foreign_key: "attendee_id"
  has_many :invitations

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :date, presence: true
  validates :location, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 2, maximum: 1000 }

  default_scope { order(date: :asc) }
  scope :upcoming, -> { where("date > ?", Time.current) }
  scope :past, -> { where("date < ?", Time.current) }

  def upcoming?
    Event.upcoming.exists?(self.id)
  end

  def previous?
    Event.past.exists?(self.id)
  end

  def created_by?(user)
    creator_id == user.id
  end
end
