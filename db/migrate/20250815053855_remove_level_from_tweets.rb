class RemoveLevelFromTweets < ActiveRecord::Migration[7.2]
  def change
    remove_column :tweets, :level, :integer
  end
end
