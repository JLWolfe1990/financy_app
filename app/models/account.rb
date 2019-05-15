class Account < ApplicationRecord
  # acct key from the api is actually routing number : account number combo
  acts_as_tenant

  belongs_to :plaid_institution
  belongs_to :user
  belongs_to :authorization
  has_many :transactions, dependent: :destroy
  scope :active, -> { where('archived = false OR archived is null') }
  scope :archived, -> { where(archived: true) }

  def fetch_transactions!(start_date=nil, end_date=nil)
    start_date ||= 1.year.ago.strftime('%Y-%m-%d')
    end_date ||= Date.today.strftime('%Y-%m-%d')

    batch_size = 500
    count = 0
    offset = 0

    loop do
      txns = PlaidWrapper.client.transactions.get(
        authorization.access_token,
        start_date,
        end_date,
        {
          account_ids: [plaid_id],
          count: batch_size,
          offset: offset
        }
      )

      count = txns['total_transactions'] if count == 0 and offset == 0

      txns['transactions'].each do |txn|
        transaction = Transaction.find_by(plaid_id: txn['transaction_id'])

        attrs = {
          account_id: id,
          amount: txn['amount'],
          description: txn['name'],
          date: txn['date'],
          plaid_account_owner: txn['account_owner'],
          plaid_pending: txn['pending'],
          plaid_id: txn['transaction_id'],
          plaid_transaction_type: txn['transaction_type']
        }

        transaction.present? ? transaction.update!(attrs) : Transaction.create!(attrs)
      end

      count = count - batch_size
      offset = offset + batch_size

      break if count <= 0
    end
  end

  def display_name
    name || plaid_name
  end

  def connected?
    authorization.present?
  end
end
