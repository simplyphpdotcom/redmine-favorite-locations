class CreateFavoriteLinkLocations < ActiveRecord::Migration
  def change
    create_table :favorite_link_locations do |t|
      t.references :user
      t.references :project
      t.string :link_text
      t.string :link_location
      t.timestamps
    end
  end
end
