class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.date :date
      t.string :description
      t.belongs_to :classification, foreign_key: true
      t.belongs_to :rule, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
