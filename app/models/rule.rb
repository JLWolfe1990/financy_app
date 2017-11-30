class Rule < ApplicationRecord
  belongs_to :classification

  delegate :name, to: :classification, prefix: true, allow_nil: true
  delegate :group, to: :classification, prefix: true, allow_nil: true
end
