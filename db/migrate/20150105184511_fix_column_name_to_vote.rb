class FixColumnNameToVote < ActiveRecord::Migration
  def change
    rename_column :votes, :total, :value
  end
end
