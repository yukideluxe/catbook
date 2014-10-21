class AddIndexesToFollowerRelationsTable < ActiveRecord::Migration
  def change
  	add_index :follower_relations, :cat_id
  	add_index :follower_relations, :followed_cat_id
  end
end
