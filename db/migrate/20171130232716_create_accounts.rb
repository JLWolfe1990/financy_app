class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :access_token
      t.belongs_to :plaid_institution, foreign_key: true

      t.timestamps
    end
  end
end
