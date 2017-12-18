class Tenant < ApplicationRecord
  acts_as_universal_and_determines_tenant

  has_many :members, dependent: :destroy
  has_many :users, through: :members
end
