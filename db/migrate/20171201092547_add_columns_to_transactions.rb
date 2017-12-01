class AddColumnsToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :plaid_account_owner, :string
    add_column :transactions, :plaid_pending, :boolean
    add_column :transactions, :plaid_id, :string
    add_column :transactions, :plaid_transaction_type, :string
  end
end
