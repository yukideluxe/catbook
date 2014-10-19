class AddVisibleToCats < ActiveRecord::Migration
  def change
    add_column :cats, :visible, :boolean, default: true
  end
end
