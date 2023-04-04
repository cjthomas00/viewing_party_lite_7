require "rails_helper"

RSpec.describe "Welcome Page as a Visitor" do
  before :each do
    visit root_path
  end

  it "When I visit the landing page I don't see a section of the page that lists existing users" do
    expect(current_path).to eq(root_path)
    expect(page).to have_no_content("Existing Users")
  end
end