class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.belongs_to :user, foreign_key: true
      t.string :type
    end
  end
end
