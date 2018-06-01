# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  charge      :integer
#  location    :string
#  start_time  :datetime
#  join_limit  :datetime
#  user_id     :integer
#  official    :boolean
#  deleted     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ApplicationRecord
  belongs_to :user
  has_many :user_events, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :charge, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :location, presence: true
  validate :checkDate

  def validate_on_create
    validate :checkDateOnCreate
  end
  
  def validate_on_update
  end

  def checkDate
    unless join_limit < start_time
      errors.add(:join_limit,"は#{:start_time}よりも前の日時にしてください")
      errors.add(:start_time,"は#{:join_limit}よりも後の日時にしてください")
    end
  end

  def checkDateOnCreate
    errors.add(:start_time,'は今日以降の日時を指定してください') unless Date.today <= start_time
    errors.add(:join_limit,'は今日以降の日時を指定してください') unless Date.today <= join_limit
  end

  def isJoined?(user)
    user_events.map{|j|j.user_id}.include?(user.id) if user
  end
end
