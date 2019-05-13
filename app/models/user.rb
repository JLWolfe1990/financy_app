class User < ApplicationRecord
  acts_as_universal_and_determines_account
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable,
         :trackable, :validatable

  has_one :member, :dependent => :destroy

  has_many :accounts
  has_many :authorizations
  has_many :transactions, through: :accounts

  def tenants
    Tenant.unscoped.find(Member.unscoped.where(user: self).pluck(:tenant_id).uniq)
  end
end
