# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  markdown    :boolean          default(FALSE)
#  charge      :integer
#  location    :string
#  start_time  :datetime
#  join_limit  :date
#  owner_id    :integer
#  official    :boolean          default(FALSE)
#  deleted     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
