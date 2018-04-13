class User < ApplicationRecord
  authenticates_with_sorcery!
  enum role: [member: 0, mailer: 1, readonly: 2, executive: 3]
  
  has_many :event_joins, dependent: :destroy
  has_many :events, dependent: :destroy
  
  majors = %w(CM HP HS LA LB LG LK LR LT LZ NE A E J M W)
  
  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :student_number, uniqueness: true
  validates :student_number, format: {with: /\A(#{majors.map{|t|Regexp.escape(t)}.join('|')})\d{2}-\d{4}[A-Z]\z/}

end
