class User < ApplicationRecord
  authenticates_with_sorcery!
  
  has_many :event_joins, dependent: :destroy
  has_many :events, dependent: :destroy
  
  majors = %w(CM HP HS LA LB LG LK LR LT LZ NE A E J M W)
  
  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :student_number, format: {with: /\A(#{majors.join('|')})\d{2}-\d{4}[A-Z]?\z/}, uniqueness: true

  def age
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10000
  end

  def isAdult?
    20 <= age
  end

  def ageByDate(date)
    date_format = "%Y%m%d"
    (date.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10000
  end

  def isAdultByDate?(date)
    20 <= ageByDate(date)
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
end
