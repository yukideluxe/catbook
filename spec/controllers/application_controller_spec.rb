require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do

  describe "GET current_user" do
    it "returns http success" do
      get :current_cat
      expect(response).to be_success
    end
  end

end
