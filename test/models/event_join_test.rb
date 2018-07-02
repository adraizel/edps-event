# == Schema Information
#
# Table name: user_events
#
#  id         :integer          not null, primary key
#  user       :integer
#  event      :integer
#  remark     :text             default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UserEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
