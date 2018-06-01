# == Schema Information
#
# Table name: event_joins
#
#  id         :integer          not null, primary key
#  user       :integer
#  event      :integer
#  remark     :text             default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventJoin < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id }
end
