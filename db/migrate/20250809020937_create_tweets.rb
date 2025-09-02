class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :live_name
      t.string :shop_name
      t.string :shop_type
      t.text :review

      t.timestamps
    end
  end
end
