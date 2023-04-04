require 'rails_helper'

RSpec.describe "Logging Out" do
  before :each do 
    user1 = User.create!(name: "Mike Smith", email: "msmith@gmail.com", password: "password1")
    visit root_path
    click_on "Log in"
    fill_in :email, with: user1.email
    fill_in :password, with: user1.password
    click_on "Log In"
    visit root_path
  end
  it "can no longer see a log in or create an account link on the landing page" do
    expect(page).to have_no_link("Log in")
    expect(page).to have_no_button("Register New User")
  end

  it "I see a link to Log Out. When I click the link to Log Out I'm taken to the landing page And I can see that the Log Out link has changed back to a Log In link" do
    expect(page).to have_link("Log Out")

    click_on "Log Out"
    expect(current_path).to eq(root_path)
    expect(page).to have_no_link("Log Out")
    expect(page).to have_link("Log in")
    expect(page).to have_button("Register New User")
    expect(page).to have_content("You have been logged out.")
  end
end