class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment, null: false
      t.belongs_to :tweet, null: false
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
  end
end
