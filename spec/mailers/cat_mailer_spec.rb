require "rails_helper"

RSpec.describe CatMailer, type: :mailer do
  describe "#welcome" do
    let(:cat) { create(:cat) }

    # http://guides.rubyonrails.org/testing.html#testing-your-mailers
    it "sends a welcome email for the specified cat" do
      email = CatMailer.welcome(cat).deliver_now

      expect(ActionMailer::Base.deliveries).not_to be_empty

      expect(email.from).to match_array(["catbook@esdeluxe.com"])
      expect(email.to).to match_array([cat.email])
      expect(email.subject).to eq("Welcome to CatBook! Miauuuuu")
      expect(email.to_s).to match(/Welcome to CatBook, #{cat.name}!/)
    end
  end
end
