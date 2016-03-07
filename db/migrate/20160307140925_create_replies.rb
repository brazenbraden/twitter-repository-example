class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.belongs_to :user
      t.string :content
      t.timestamps null: false
    end
  end
end
