class Rule < ApplicationRecord
  acts_as_tenant

  belongs_to :classification
  belongs_to :user

  has_many :transactions

  delegate :name, to: :classification, prefix: true, allow_nil: true
  delegate :group, to: :classification, prefix: true, allow_nil: true
  delegate :display_name, to: :classification, prefix: true, allow_nil: true

  validates :regex, presence: true, uniqueness: { scope: :user_id }

  def self.apply_all
    all.each(&:apply!)
  end

  def apply!
    Transaction.unclassified.find_each do |txn|
      if txn.description.match(Regexp.new(regex))
        txn.update! classification: classification, rule: self
      end
    end
  end

  def reapply!
    transactions.update_all(rule_id: nil, classification_id: nil)

    Rule.apply_all
  end

  def display_name
    "/#{regex}/ #{classification_display_name}"
  end
end
