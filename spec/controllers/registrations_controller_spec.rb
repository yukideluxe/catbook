require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    it "redirects to cats_path if succesfull" do
      post :create, cat: { name: "Name", email: "email@email.com", password: "password", password_confirmation: "password" }
      expect(response).to redirect_to(cats_path)
    end

    it "creates a new cat with data and encrypted password" do
      post :create, cat: { name: "Name", email: "email@email.com", password: "password", password_confirmation: "password" }

      last_cat = Cat.last
      expect(last_cat.name).to  eq("Name")
      expect(last_cat.email).to eq("email@email.com")

      expect(last_cat.password_digest).to_not eq("password")
      expect(last_cat.authenticate("password")).to be last_cat
    end

    it "renders new template if validation errors" do
      post :create, cat: { email: "email@email.com", password: "password", password_confirmation: "password" }

      expect(response).to render_template("new")
    end
  end
end
