require 'rails_helper'

RSpec.describe CatsController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads visible cats into @cats" do
      visible_cat       = create(:cat, visible: true)
      other_visible_cat = create(:cat, visible: true)
      invisible_cat     = create(:cat, visible: false)
      get :index

      expect(assigns(:cats)).to match_array([visible_cat, other_visible_cat])
    end
  end

  describe "GET #show" do
    let(:cat) { create(:cat, visible: true) }

    it "responds successfully with an HTTP 200 status code if cat is visible" do
      get :show, id: cat
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template if cat is visible" do
      get :show, id: cat
      expect(response).to render_template("show")
    end

    it "loads requested cat into @cat" do
      get :show, id: cat

      expect(assigns(:cat)).to eq(cat)
    end

    it "renders 404 if cat non visible" do
      cat.update_attribute(:visible, false)

      get :show, id: cat

      expect(response).to have_http_status(404)
    end
  end

  describe "GET #edit" do
    let(:cat) { create(:cat, visible: true) }

    it "responds successfully with an HTTP 200 status code if cat is visible" do
      get :edit, id: cat
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template if cat is visible" do
      get :edit, id: cat
      expect(response).to render_template("edit")
    end

    it "loads requested cat into @cat" do
      get :edit, id: cat

      expect(assigns(:cat)).to eq(cat)
    end

    it "renders 404 if cat non visible" do
      cat.update_attribute(:visible, false)

      get :edit, id: cat

      expect(response).to have_http_status(404)
    end
  end

  describe "PUT #update" do
    let(:cat) { create(:cat, visible: true) }

    it "redirects to show if cat is successfully updated" do
      put :update, id: cat, cat: { name: "New name" }
      expect(response).to redirect_to(cat_path(cat))
    end

    it "updates cat information" do
      put :update, id: cat, cat: { name: "New name" }

      cat.reload

      expect(cat.name).to eq("New name")
    end

    it "renders edit template if validation errors" do
      put :update, id: cat, cat: { name: "a" }

      expect(response).to render_template("edit")
    end

    it "renders 404 if cat non visible" do
      cat.update_attribute(:visible, false)

      put :update, id: cat, cat: { name: "New name" }

      expect(response).to have_http_status(404)
    end
  end
end
