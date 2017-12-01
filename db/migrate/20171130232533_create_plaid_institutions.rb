class CreatePlaidInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :plaid_institutions do |t|
      t.string :name
      t.string :plaid_id

      t.timestamps
    end
  end
end
