class DropToy < ActiveRecord::Migration
  def change
  	drop_table :toys
  	drop_table :comments
  	drop_table :ratings
  end
end
