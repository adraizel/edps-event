class User < ApplicationRecord
  authenticates_with_sorcery!
  enum role: [member: 0, mailer: 1, readonly: 2, executive: 3]
  
  has_many :event_joins
  has_many :events
  
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
end
