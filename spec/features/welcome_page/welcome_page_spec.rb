require "rails_helper"

RSpec.describe "Welcome Page", type: :feature do
  before :each do
    @user = create(:user)
    visit root_path
  end
  
  describe "When a user visits the root path they should be on the landing page ('/') which includes:" do
    it "Title of Application" do 
      expect(page).to have_content("Viewing Party Lite")
    end

    it "Has a Button to Register a New User" do
      expect(page).to have_button("Register New User")
    end

    it "has a List of Existing Users if logged in" do
      user1 = User.create!(name: "Mike Smith", email: "msmith@gmail.com", password: "password1")
      click_on "Log in"
      fill_in :email, with: user1.email
      fill_in :password, with: user1.password
      click_on "Log In"
      visit root_path
      expect(page).to have_content("Existing Users")
      within(".existing_users") do
        expect(page).to have_content("#{@user.email}")
        expect(page).to have_no_link("Home Page")
      end
    end

    it "has a link to go back to the welcome page" do
      within(".links") do
        expect(page).to have_link("Home Page")
        expect(page).to have_no_link("#{@user.name}")
      end
    end
  end
end