class AddLoginToCats < ActiveRecord::Migration
  def change
    add_column :cats, :email, :text
    add_column :cats, :password_digest, :string
  end
end
