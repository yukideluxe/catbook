class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :toy_id
      t.integer :cat_id
      t.integer :rating

      t.timestamps
    end
  end
end
