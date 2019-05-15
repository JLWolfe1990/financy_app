class AddMaskToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :mask, :string
  end
end
