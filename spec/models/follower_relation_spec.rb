require 'rails_helper'

RSpec.describe FollowerRelation, :type => :model do
  describe "Validations" do
    it "validates presence of follower_relation_id" do
      follower_relation = build(:follower_relation, cat_id: nil)

      expect(follower_relation.valid?).to be false
      expect(follower_relation.errors[:cat_id].present?).to be true
    end

    it "validates presence of followed_cat_id" do
      follower_relation = build(:follower_relation, followed_cat_id: nil)

      expect(follower_relation.valid?).to be false
      expect(follower_relation.errors[:followed_cat_id].present?).to be true
    end
  end

  describe "#cat association" do
    it "returns the cat that is following" do
      cat = create(:cat)
      follower_relation = create(:follower_relation, cat_id: cat.id)

      expect(follower_relation.cat).to eq(cat)
    end
  end

  describe "#followed association" do
    it "returns the followed cat" do
      cat = create(:cat)
      follower_relation = create(:follower_relation, followed_cat_id: cat.id)

      expect(follower_relation.followed).to eq(cat)
    end
  end
end
