class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :date
      t.integer :buy_in
      t.string :address
      t.references :season, foreign_key: true
      t.boolean :completed, default: false

      t.timestamps null: false
    end
  end
end
