class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, 
                    length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    
  has_many :created_events, class_name: "Event", foreign_key: "creator_id"
  has_and_belongs_to_many :attended_events, class_name: "Event",
                                            join_table: "attended_events_attendees",
                                            foreign_key: "attendee_id",
                                            association_foreign_key: "attended_event_id"

  def upcoming_events
    attended_events.upcoming
  end

  def past_events
    attended_events.past
  end
end
