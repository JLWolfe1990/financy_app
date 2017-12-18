class Transaction < ApplicationRecord
  default_scope { order(date: :desc) }

  belongs_to :classification, optional: true
  belongs_to :rule, optional: true
  belongs_to :account

  has_one :user, through: :account

  scope :unclassified, -> { where(classification_id: nil) }
  scope :for_user, -> (user) { joins(:account).where(accounts: { user_id: user.id }) }
  scope :focus, -> { where("transactions.classification_id NOT IN (#{Classification.ignored.map(&:id).join(', ')}) or transactions.classification_id IS NULL") }
  scope :range, ->(start_at, end_at) { where('date >= ? and date <= ?', start_at.strftime('%Y/%m/%d'), end_at.strftime('%Y/%m/%d'))}


  def pending?
    !!plaid_pending
  end

  def focus?
    !Classification.ignored.include?(classification)
  end
end
