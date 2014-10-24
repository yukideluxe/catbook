require 'rails_helper'

RSpec.describe "Routing to logins", type: :routing do
  it "routes POST /login to login#create" do
    expect(post: "/login").to route_to(
      controller: "login",
      action: "create"
    )
  end

  it "routes DELETE /login to login#destroy" do
    expect(delete: "/logout").to route_to(
      controller: "login",
      action: "destroy"
    )
  end
end
