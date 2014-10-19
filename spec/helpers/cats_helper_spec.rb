require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CatsHelper. For example:
#
# describe CatsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CatsHelper, type: :helper do
  describe "#localize_date" do
    it "localizes date with short format" do
      date = Date.today

      expect(I18n.l(date, format: :short)).to eq(helper.localize_date(date))
    end

  end
end
