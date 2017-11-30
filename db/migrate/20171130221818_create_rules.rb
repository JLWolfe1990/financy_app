class CreateRules < ActiveRecord::Migration[5.1]
  def change
    create_table :rules do |t|
      t.string :regex
      t.belongs_to :classification, foreign_key: true

      t.timestamps
    end
  end
end
