require 'rails_helper'

RSpec.describe Cat, type: :model do
  describe "Validations" do
    it "validates presence of name" do
      cat = build(:cat, name: nil)

      expect(cat.valid?).to be false
      expect(cat.errors[:name].present?).to be true
    end

    it "validates presence of email" do
      cat = build(:cat, email: nil)

      expect(cat.valid?).to be false
      expect(cat.errors[:email].present?).to be true
    end

    it "validates presence of password" do
      cat = build(:cat, password: nil)

      expect(cat.valid?).to be false
      expect(cat.errors[:password].present?).to be true
    end
  end

  describe "#followers association" do
    let(:cat) { create(:cat) }

    it "returns the list of visible cats that are followed by cat" do
      followed1 = create(:follower_relation, cat: cat)
      followed2 = create(:follower_relation, cat: cat)
      create(:follower_relation, cat: cat, followed: create(:cat, visible: false))

      expect(cat.followers.order("id ASC").all).to eq([followed1.followed, followed2.followed])
    end
  end

  describe "#followed_by association" do
    let(:cat) { create(:cat) }

    it "returns the list of visible cats that are following cat" do
      follower1 = create(:follower_relation, followed: cat)
      follower2 = create(:follower_relation, followed: cat)
      create(:follower_relation, cat: create(:cat, visible: false), followed: cat)

      expect(cat.followed_by.all).to eq([follower1.cat, follower2.cat])
    end
  end

end
