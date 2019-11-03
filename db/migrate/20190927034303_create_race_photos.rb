class CreateRacePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :race_photos do |t|
      t.references :race, foreign_key: true
      t.string :picture
      t.timestamps
    end
  end
end
