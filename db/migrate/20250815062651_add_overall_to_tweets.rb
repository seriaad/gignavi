class AddOverallToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :overall, :integer
  end
end
