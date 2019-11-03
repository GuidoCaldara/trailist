class CreateRacePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :race_prices do |t|
      t.date :start_date
      t.date :end_date
      t.integer :price
      t.references :race, foreign_key: true

      t.timestamps
    end
  end
end
