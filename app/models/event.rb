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
#  start_time  :date
#  join_limit  :date
#  owner_id    :integer
#  official    :boolean          default(FALSE)
#  deleted     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :user_events, dependent: :destroy
  has_many :participated_user, through: :user_events, source: :user

  before_validation :convert_to_markdown
  
  scope :deleted_events, -> { where(deleted: true) }
  scope :available_events, -> { where(deleted: false) }
  scope :after_finishing, -> { where('? > start_time', Date.today) }
  scope :before_beginning, -> { where('? <= start_time', Date.today) }
  scope :acceptance_finished, -> { where('join_limit < ?', Date.today) }
  scope :during_acceptance, -> { where('join_limit >= ?', Date.today) }
  scope :member_events, -> { where(official: false) }
  scope :circle_events, -> { where(official: true) }

  validates :title, presence: true
  validates :description, presence: true
  validates :converted_description, presence: true
  validate :check_date
  validate :check_date_on_create, on: :create

  def check_date
    unless join_limit < start_time
      errors.add(:join_limit, "は#{:start_time}よりも前の日時にしてください")
      errors.add(:start_time, "は#{:join_limit}よりも後の日時にしてください")
    end
  end

  def check_date_on_create
    errors.add(:start_time, 'は今日以降の日時を指定してください') unless Date.today <= start_time
    errors.add(:join_limit, 'は今日以降の日時を指定してください') unless Date.today <= join_limit
  end

  def isJoined?(user)
    user_events.map(&:user_id).include?(user.id) if user
  end

  private
  def convert_to_markdown
    convert = Qiita::Markdown::Processor.new
    self.converted_description = convert.call(description)[:output].to_s
  end
end
