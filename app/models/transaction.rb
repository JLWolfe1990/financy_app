class Transaction < ApplicationRecord
  belongs_to :classification, optional: true
  belongs_to :rule, optional: true
  belongs_to :account

  has_one :user, through: :account

  scope :unclassified, -> { where(classification_id: nil) }
  scope :for_user, -> (user) { where(accounts: { user_id: user.id }) }

  def pending?
    !!plaid_pending
  end
end
