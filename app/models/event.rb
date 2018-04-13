class Event < ApplicationRecord
  belongs_to :user
  has_many :event_joins, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :charge, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :location, presence: true

  def isJoined?(user)
    event_joins.map{|j|j.user_id}.include?(user.id)
  end
end
