class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :review_id, null: false
      t.integer :total, { default: 0, null: false }

      t.timestamps null: false
    end
  end
end
