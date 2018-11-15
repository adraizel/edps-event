class MailData
  include ActiveModel::Model

  attr_accessor :target_event, :target_grade, :target_grade_str, :title, :content

  validates :target_event, presence: :true, if: :target_grade_present?
  validates :target_grade, presence: :true, if: :target_event_present?
  validates :title, presence: :true
  validates :content, presence: :true

  def target_event_present?
    target_event.present? == false
  end

  def target_grade_present?
    target_grade.present? == false
  end
end
