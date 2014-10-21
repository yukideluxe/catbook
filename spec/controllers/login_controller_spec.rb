require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe "POST #create" do
    let(:cat) { create(:cat, email: "email@email.com", password: "password") }

    it "authenticates cat and redirects to cats_path with session engaded" do
      post :create, email: cat.email, password: "password"
      expect(response).to redirect_to(cats_path)
      expect(session[:current_cat_id]).to eq(cat.id)
    end

    it "sets error flash message if invalid password and redirects to cats_path" do
      post :create, email: cat.email, password: "INVALID PASSWORD"

      expect(response).to redirect_to(cats_path)
      expect(session[:current_cat_id]).to be nil
    end

    it "sets error flash message if invalid email and redirects to cats_path" do
      post :create, email: "INVALID EMAIL", password: "password"

      expect(response).to redirect_to(cats_path)
      expect(session[:current_cat_id]).to be nil
    end
  end

  describe "DELETE #destroy" do
    let(:cat) { create(:cat, email: "email@email.com", password: "password") }

    it "clears user session and redirects to cats_path (JS FORMAT)" do
      session[:current_cat_id] = cat

      delete :destroy, format: :js
      expect(session[:current_cat_id]).to be nil
      expect(response.body).to eq("window.location.href='#{cats_path}'")
    end

    it "clears user session and redirects to cats_path (HTML FORMAT)" do
      session[:current_cat_id] = cat

      delete :destroy
      expect(response).to redirect_to(cats_path)
    end
  end
end
