class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name, null: false
      t.string :latitude, null: false
      t.string :longitude, null: false
      t.string :address

      t.timestamps null: false
    end
  end
end
