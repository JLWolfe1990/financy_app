class AddPlaidOfficialNameToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :plaid_official_name, :string
  end
end
