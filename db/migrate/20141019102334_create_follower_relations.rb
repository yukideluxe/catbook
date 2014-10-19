class CreateFollowerRelations < ActiveRecord::Migration
  def change
    create_table :follower_relations do |t|
      t.integer :cat_id
      t.integer :followed_cat_id

      t.timestamps
    end

    # I am missing something on purpose, follow the classes to know what!
  end
end
