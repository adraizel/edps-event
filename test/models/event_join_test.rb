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

require 'test_helper'

class EventJoinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
