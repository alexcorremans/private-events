class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_and_belongs_to_many :attendees, class_name: "User",
                                      join_table: "attended_events_attendees",
                                      foreign_key: "attended_event_id", 
                                      association_foreign_key: "attendee_id"

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :date, presence: true
  validates :location, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 2, maximum: 1000 }

end