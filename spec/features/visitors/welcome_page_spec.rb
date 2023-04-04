require "rails_helper"

RSpec.describe "Welcome Page as a Visitor" do
  before :each do
    @user1 = User.create!(name: "Mike Smith", email: "msmith@gmail.com", password: "password1")
    visit root_path
  end

  it "When I visit the landing page I don't see a section of the page that lists existing users" do
    expect(current_path).to eq(root_path)
    expect(page).to have_no_content("Existing Users")
  end

  it "And then try to visit '/dashboard' I remain on the landing page And I see a message telling me that I must be logged in or registered to access my dashboard" do
    visit user_path(@user1)
    expect(page).to have_content("Please login or register to visit your dashboard.")
    expect(current_path).to eq(root_path)
  end
end