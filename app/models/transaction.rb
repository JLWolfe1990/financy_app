class Transaction < ApplicationRecord
  belongs_to :classification, optional: true
  belongs_to :rule, optional: true
  belongs_to :account

  has_one :user, through: :account

  scope :unclassified, -> { where(classification_id: nil) }
  scope :for_user, -> (user) { joins(:account).where(accounts: { user_id: user.id }) }
  scope :focus, -> { where("transactions.classification_id NOT IN (#{Classification.ignored.map(&:id).join(', ')}) or transactions.classification_id IS NULL") }

  def pending?
    !!plaid_pending
  end

  def focus?
    !Classification.ignored.include?(classification)
  end
end
