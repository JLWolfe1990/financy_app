class Authorization < ApplicationRecord
  acts_as_tenant

  belongs_to :plaid_institution
  belongs_to :user

  has_many :accounts

  def connected?
    !!access_token
  end

  def retreive_public_token!
    exchange_token_response = PlaidWrapper.client.item.public_token.create(self.access_token)
    self.public_token = exchange_token_response['public_token']
    self.save!
  end

  def retreive_access_token!
    exchange_token_response = PlaidWrapper.client.item.public_token.exchange(public_token)
    self.access_token = exchange_token_response['access_token']
    self.save!
  end

  def retreive_account_details
    # todo: too many saves
    retreive_public_token!
    retreive_access_token!
    Plaid::Auth.new(PlaidWrapper.client).get(self.access_token)
  end

  def refresh_accounts!(current_user)
    retreived_accounts = retreive_account_details

    # todo: will throw error w/ no accts
    fresh_accounts = retreived_accounts.numbers.ach.map do |acct|
      next unless acct.account

      # NOTE: acct ids sometimes change, so this will refresh them
      Account.find_or_initialize_by(
        account_number: acct.account,
        routing_number: acct.routing
      ).tap do |account|
         account.update! plaid_id: acct.account_id,
                         plaid_institution_id: plaid_institution.id,
                         user: current_user,
                         authorization_id: id
      end
    end

    retreived_accounts.accounts.each do |acct|
      account = Account.active.find_by(plaid_id: acct.account_id)

      next unless account

      account.update! mask: acct.mask,
                      plaid_name: acct.name,
                      plaid_official_name: acct.official_name,
                      authorization_id: id
    end


    # fresh_accounts.each do |fresh|
    #   debugger
    # end

    Account.find_each.each do |account|
      account.update! archived: true, closed: true unless fresh_accounts.detect { |fresh| fresh == account }
    end

    true
  end

  def unauthorize!
    update! access_token: nil
  end

  def create_accounts!
    accounts_response = PlaidWrapper.client.accounts.get(self.access_token)

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
