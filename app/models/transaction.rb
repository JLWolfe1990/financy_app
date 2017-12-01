class Transaction < ApplicationRecord
  belongs_to :classification, optional: true
  belongs_to :rule, optional: true
  belongs_to :account

  delegate :name, to: :rule, allow_nil: true, prefix: true

  def pending?
    !!plaid_pending
  end
end
