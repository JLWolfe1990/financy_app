class FixupAccounts < ActiveRecord::Migration[5.1]
  def change
    remove_column(:accounts, :username, :string)
    remove_column(:accounts, :access_token, :string)

    add_column(:accounts, :plaid_id, :string)
    add_column(:accounts, :plaid_name, :string)
    add_column(:accounts, :plaid_type, :string)
    add_column(:accounts, :plaid_sub_type, :string)
  end
end
