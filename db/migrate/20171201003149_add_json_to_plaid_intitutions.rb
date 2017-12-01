class AddJsonToPlaidIntitutions < ActiveRecord::Migration[5.1]
  def change
    add_column :plaid_institutions, :json, :text
  end
end
