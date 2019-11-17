class AddAttributesToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :website, :string
    add_column :organizations, :facebook, :string
  end
end
