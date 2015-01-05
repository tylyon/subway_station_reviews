class AddIndexesToVotes < ActiveRecord::Migration
  def change
    add_index :votes, :user_id
    add_index :votes, :review_id
  end
end
