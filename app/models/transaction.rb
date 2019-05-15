class Transaction < ApplicationRecord
  acts_as_tenant

  default_scope { order(date: :desc) }

  belongs_to :classification, optional: true
  belongs_to :rule, optional: true
  belongs_to :account

  has_one :user, through: :account

  scope :unclassified, -> { where(classification_id: nil) }
  scope :focus, -> { where("transactions.classification_id NOT IN (#{Classification.ignored.map(&:id).join(', ')}) or transactions.classification_id IS NULL") }
  scope :range, ->(start_at, end_at) { where('date >= ? and date <= ?', start_at.strftime('%Y/%m/%d'), end_at.strftime('%Y/%m/%d'))}
  scope :not_excluded, -> { joins(:classification).where('classifications.excluded IS NULL or classifications.excluded = false') }
  scope :active, -> { joins(:account).where("accounts.archived = false OR accounts.archived IS NULL") }


  def pending?
    !!plaid_pending
  end

  def focus?
    !Classification.ignored.include?(classification)
  end
end
