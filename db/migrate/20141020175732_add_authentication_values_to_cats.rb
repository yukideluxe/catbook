# http://api.rubyonrails.org/classes/ActiveRecord/Migration.html
# Difference between using #change or #up and #down methods
class AddAuthenticationValuesToCats < ActiveRecord::Migration
  def up
    # What are the benefits of using bulk: true?
    # http://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/change_table
    change_table(:cats, bulk: true) do |t|
      t.string :email
      t.text   :password_digest

      # Why this index, what does unique does?
      # http://robots.thoughtbot.com/the-perils-of-uniqueness-validations
      t.index :email, unique: true
    end
  end

  # Just another notation
  # What is the difference?
  # Will it remove the index?
  def down
    remove_column :cats, :email
    remove_column :cats, :password_digest
  end
end
