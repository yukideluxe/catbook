require 'rails_helper'

RSpec.describe "Routing to cats", type: :routing do
  it "routes GET /cats to cats#index" do
    expect(get: "/cats").to route_to(
      controller: "cats",
      action: "index"
    )
  end

  it "routes GET /cats/:id to cats#show" do
    expect(get: "/cats/1").to route_to(
      controller: "cats",
      action: "show",
      id: "1"
    )
  end

  it "routes GET /cats/:id/edit to cats#edit" do
    expect(get: "/cats/1/edit").to route_to(
      controller: "cats",
      action: "edit",
      id: "1"
    )
  end

  it "routes PATCH /cats/:id to cats#update for cat" do
    expect(patch: "/cats/1").to route_to(
      controller: "cats",
      action: "update",
      id: "1"
    )
  end
end
