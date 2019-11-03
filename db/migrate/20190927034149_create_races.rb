class CreateRaces < ActiveRecord::Migration[6.0]
  def change
    create_table :races do |t|
      t.string :name
      t.integer :length
      t.integer :elevation
      t.date :date
      t.time :departure_time
      t.text :description
      t.text :goodies
      t.string :location
      t.float :latitude
      t.float :longitude
      t.references :organization, foreign_key: true
      t.string :race_type
      t.boolean :single_price
      t.string :cover_picture
      t.text :rules
      t.text :website
      t.string :video
      t.timestamps
    end
  end
end
