class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :description, null: false
      t.integer :rating, null: false
      t.integer :station_id, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
