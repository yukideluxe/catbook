class FollowerRelation < ActiveRecord::Base
  # Why don't you need to specify class_name and foreign_key here?
  belongs_to :cat
  belongs_to :followed, class_name: "Cat", foreign_key: "followed_cat_id"

  validates :cat_id,          presence: true
  validates :followed_cat_id, presence: true
end
