class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :location
      t.boolean :public_league, default: false
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
