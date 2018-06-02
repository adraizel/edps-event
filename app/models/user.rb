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

class User < ApplicationRecord
  authenticates_with_sorcery!

  # 定数
  MAJORS = %w(CM HP HS LA LB LG LK LR LT LZ NE A E J M W)


  # 関連
  has_many :user_events, dependent: :destroy
  has_many :held_events, class_name: 'Event', foreign_key: 'owner_id', dependent: :destroy
  has_many :joined_events, class_name: 'UserEvent', foreign_key: 'user_id', dependent: :destroy


  # バリデーション
  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :student_number, format: {with: /\A(#{MAJORS.join('|')})\d{2}-\d{4}[A-Z]?\z/}, uniqueness: true


  # メソッド
  def age
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10000
  end

  def adult?
    20 <= age
  end

  def age_by_date(date)
    date_format = "%Y%m%d"
    (date.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10000
  end

  def adult_by_date?(date)
    20 <= age_by_date(date)
  end

  def grade
    spl = student_number.split('-')
    spl[0].gsub!(/[A-Z]{2}/,'')
    spl[1] = spl[1].slice!(0)
    if spl[1].match('1')
      y = ("20" + spl[0]).to_i
    else
      y = 1988 + spl[0].to_i
    end
    Date.today.year - y + 1
  end

  # プライベートメソッド
end
