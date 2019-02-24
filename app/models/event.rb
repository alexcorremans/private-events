class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :date, presence: true
  validates :location, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 2, maximum: 1000 }

end
