class AddAuthorizationToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_reference :accounts, :authorization, foreign_key: true
  end
end
