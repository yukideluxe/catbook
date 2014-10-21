class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :toy_id
      t.integer :cat_id
      t.text :comment

      t.timestamps
    end
  end
end
