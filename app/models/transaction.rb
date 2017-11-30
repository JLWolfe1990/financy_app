class Transaction < ApplicationRecord
  belongs_to :classification
  belongs_to :rule
end
