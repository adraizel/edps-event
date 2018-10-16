class MailData
  include ActiveModel::Model

  attr_accessor :target, :targets, :title, :content

  validates :target, presence: :true, if: :targets_present?
  validates :targets, presence: :true, if: :target_present?
  validates :title, presence: :true
  validates :content, presence: :true

  def target_present?
    target.present? == false
  end

  def targets_present?
    targets.present? == false
  end
end
