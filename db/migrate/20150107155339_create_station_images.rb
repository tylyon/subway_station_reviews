class CreateStationImages < ActiveRecord::Migration
  def change
    create_table :station_images do |t|
      t.string :url, null: false
      t.string :description
      t.integer :station_id, null: false

      t.timestamps null: false
    end
  end
end
