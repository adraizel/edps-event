class Event < ApplicationRecord
  belongs_to :user
  has_many :event_joins, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :charge, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :location, presence: true

  def validate_on_create
    validate :checkDate
  end
  
  def validate_on_update
  end

  def checkDate
    errors.add(:start_time,'は今日以降の日時を指定してください') unless Date.today <= start_time
    errors.add(:join_limit,'は今日以降の日時を指定してください') unless Date.today <= join_limit
    unless join_limit < start_time
      errors.add(:join_limit,"は#{:start_time}よりも前の日時にしてください")
      errors.add(:start_time,"は#{:join_limit}よりも後の日時にしてください")
    end
  end

  def isJoined?(user)
    event_joins.map{|j|j.user_id}.include?(user.id)
  end
end