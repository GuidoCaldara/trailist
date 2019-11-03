class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :logo
      t.text :description
      t.references :organizer, foreign_key: true
      t.string :location
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
