class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :race, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :partecipation_year
      t.integer :track
      t.integer :organization
      t.integer :recomandation
      t.integer :difficulty
      t.text :content

      t.timestamps
    end
  end
end
