class Rule < ApplicationRecord
  belongs_to :classification
  belongs_to :user

  has_many :transactions

  delegate :name, to: :classification, prefix: true, allow_nil: true
  delegate :group, to: :classification, prefix: true, allow_nil: true
  delegate :display_name, to: :classification, prefix: true, allow_nil: true

  validates :regex, presence: true, uniqueness: { scope: :user_id }

  def apply!(user)
    user.transactions.unclassified.find_each do |txn|
      if txn.description.match(Regexp.new(regex))
        txn.update! classification: classification, rule: self
      end
    end
  end

  def display_name
    "/#{regex}/ #{classification_display_name}"
  end
end
