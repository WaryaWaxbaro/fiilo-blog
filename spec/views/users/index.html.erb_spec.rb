require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        first_name: "First Name",
        last_name: "Last Name",
        username: "Username"
      ),
      User.create!(
        first_name: "First Name",
        last_name: "Last Name",
        username: "Username"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: "Username".to_s, count: 2
  end
end
