class Member < ApplicationRecord
  acts_as_tenant

  belongs_to :user
end
