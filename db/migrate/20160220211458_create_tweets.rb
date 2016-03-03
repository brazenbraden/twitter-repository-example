class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet, null: false

      t.timestamps null: false
    end
  end
end
