class CreateAuthorizations < ActiveRecord::Migration[5.1]
  def change
    create_table :authorizations do |t|
      t.belongs_to :plaid_institution, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.string :token
      t.string :name

      t.timestamps
    end
  end
end
