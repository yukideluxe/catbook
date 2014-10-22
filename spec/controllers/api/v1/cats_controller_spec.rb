require 'rails_helper'

# These tests are also full of code that could be totally extracted in
# helper methods!
#
# DO IT :)
RSpec.describe Api::V1::CatsController, type: :controller do
  describe "GET #index" do
    before do
      @cat               = create(:cat)
      @other_visible_cat = create(:cat)
      @non_visible_cat   = create(:cat, visible: false)

      create(:follower_relation, cat: @cat, followed: @other_visible_cat)
    end

    it "renders list of cats in json format" do
      expected_result = JSON.generate([
        {
          name: @cat.name,
          birthday: @cat.birthday,
          followers_count: @cat.follower_relations.count,
          followed_by_count: @cat.followed_relations.count,
          links: {
            public: cat_url(@cat),
            api: api_v1_cat_url(@cat)
          }
        },
        {
          name: @other_visible_cat.name,
          birthday: @other_visible_cat.birthday,
          followers_count: @other_visible_cat.follower_relations.count,
          followed_by_count: @other_visible_cat.followed_relations.count,
          links: {
            public: cat_url(@other_visible_cat),
            api: api_v1_cat_url(@other_visible_cat)
          }
        }
      ])

      get :index

      expect(response.body).to eq(expected_result)
    end

    it "accepts limit/offset params" do
      expected_result = JSON.generate([
        {
          name: @other_visible_cat.name,
          birthday: @other_visible_cat.birthday,
          followers_count: @other_visible_cat.follower_relations.count,
          followed_by_count: @other_visible_cat.followed_relations.count,
          links: {
            public: cat_url(@other_visible_cat),
            api: api_v1_cat_url(@other_visible_cat)
          }
        }
      ])

      get :index, offset: 1, limit: 1

      expect(response.body).to eq(expected_result)
    end

    it "only returns specified fields" do
      expected_result = JSON.generate([
        {
          name: @other_visible_cat.name,
          links: {
            public: cat_url(@other_visible_cat),
            api: api_v1_cat_url(@other_visible_cat)
          }
        }
      ])

      get :index, offset: 1, limit: 1, fields: "name,links"

      expect(response.body).to eq(expected_result)
    end

    it "accepts order param" do
      expected_result = JSON.generate([
        {
          name: @cat.name,
          birthday: @cat.birthday,
          followers_count: @cat.follower_relations.count,
          followed_by_count: @cat.followed_relations.count,
          links: {
            public: cat_url(@cat),
            api: api_v1_cat_url(@cat)
          }
        },
        {
          name: @other_visible_cat.name,
          birthday: @other_visible_cat.birthday,
          followers_count: @other_visible_cat.follower_relations.count,
          followed_by_count: @other_visible_cat.followed_relations.count,
          links: {
            public: cat_url(@other_visible_cat),
            api: api_v1_cat_url(@other_visible_cat)
          }
        }
      ])

      get :index, order: "id ASC"

      expect(response.body).to eq(expected_result)
    end
  end

  describe "GET #show" do
    let(:cat) { create(:cat, visible: true) }

    it "renders cat info in json format" do
      expected_result = JSON.generate({
        name: cat.name,
        birthday: cat.birthday,
        followers_count: cat.follower_relations.count,
        followed_by_count: cat.followed_relations.count,
        links: {
          public: cat_url(cat),
          api: api_v1_cat_url(cat)
        }
      })

      get :show, id: cat.id

      expect(response.body).to eq(expected_result)
    end

    it "renders specified fields" do
      expected_result = JSON.generate({
        name: cat.name
      })

      get :show, id: cat.id, fields: "name"

      expect(response.body).to eq(expected_result)
    end

    it "renders 404 if cat non visible" do
      cat.update(visible: false)

      get :show, id: cat.id, fields: "name"

      expect(response).to have_http_status(404)
    end
  end
end
