class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.date   :birthday

      t.timestamps
    end
  end
end
