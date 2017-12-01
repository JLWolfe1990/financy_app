class PlaidInstitution < ApplicationRecord
  def self.refresh!
    batch_size = 500
    offset = 0
    count = 0
    client = PlaidWrapper.client

    loop do
      institutions = client.institutions.get(count: batch_size, offset: offset)

      count = institutions['total'] unless offset > 0

      institutions['institutions'].each do |hash|
        pi = PlaidInstitution.find_or_initialize_by name: hash['name'], plaid_id: hash['institution_id']

        if pi.new_record?
          pi.json = hash
          pi.save!
        end
      end

      count = count - batch_size
      offset = offset + batch_size

      break if count <= 0
    end
  end

  # def create_account_for_user(user, username, password)
  #   account = user.accounts.detect {|account| account == self}
  #   return account if account
  #
  #   item_response = PlaidWrapper.client.item.create credentials: { username: username, password: password },
  #                                                   institution_id: plaid_id,
  #                                                   initial_products: %i(transactions)
  #   access_token = item_response['access_token']
  #   user.accounts.create! access_token: access_token,
  #                         plaid_institution: self,
  #                         username: username
  # end
end
