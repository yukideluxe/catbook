require 'rails_helper'

RSpec.describe "Routing to registrations", type: :routing do
  it "routes GET / to registrations#new" do
    expect(get: "/").to route_to(
      controller: "registrations",
      action: "new"
    )
  end

  it "routes GET /register to registrations#new" do
    expect(get: "/register").to route_to(
      controller: "registrations",
      action: "new"
    )
  end

  it "routes POST /register to registrations#create" do
    expect(post: "/register").to route_to(
      controller: "registrations",
      action: "create"
    )
  end
end
