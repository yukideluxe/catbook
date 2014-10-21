class Toy < ActiveRecord::Base
	has_many :ratings
	has_many :comments
	has_many :cat_id
end
