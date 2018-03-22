class Event < ApplicationRecord
  belongs_to :user
  has_many :event_join
  
end
