class AddDistanceTypeTpraces < ActiveRecord::Migration[6.0]
  def change
     add_column :races, :distance_type, :string
  end
end
