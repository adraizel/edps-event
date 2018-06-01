# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  crypted_password :string
#  salt             :string
#  name             :string           not null
#  student_number   :string           not null
#  birthday         :date             not null
#  allergy_data     :string           default("")
#  remark           :string           default("")
#  executive        :boolean          default(FALSE)
#  mailer           :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
