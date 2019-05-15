class AddFieldsToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :routing_number, :string
    add_column :accounts, :account_number, :string
    add_column :accounts, :closed, :boolean
  end
end
