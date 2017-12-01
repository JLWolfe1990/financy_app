class Authorization < ApplicationRecord
  belongs_to :plaid_institution
  belongs_to :user

  has_many :accounts

  def connected?
    !!access_token
  end

  def retreive_access_token!
    exchange_token_response = PlaidWrapper.client.item.public_token.exchange(public_token)
    self.access_token = exchange_token_response['access_token']
    self.save!
  end

  def create_accounts!
    accounts_response = PlaidWrapper.client.accounts.get(access_token)

    accounts_response['accounts'].each do |acct|
      Account.find_or_create_by(
        plaid_id: acct['account_id'],
        plaid_name: acct['name'],
        plaid_official_name: acct['official_name'],
        plaid_type: acct['type'],
        plaid_sub_type: acct['subtype'],
        user_id: user.id,
        authorization_id: id,
        plaid_institution_id: plaid_institution_id
      )
    end
  end
end
