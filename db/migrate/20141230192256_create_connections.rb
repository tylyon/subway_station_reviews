class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :station_id
      t.integer :line_id

      t.timestamps null: false
    end
    add_index :connections,[:station_id,:line_id], unique: true
  end
end
