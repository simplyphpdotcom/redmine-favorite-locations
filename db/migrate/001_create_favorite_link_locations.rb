class CreateFavoriteLinkLocations < ActiveRecord::Migration
  def change
    create_table :favorite_link_locations, :force => true do |t|
      t.references :user
      t.string :page_title
      t.string :link_path
      t.timestamps
    end
  end
end
