require "rails_helper"

RSpec.describe "Welcome Page", type: :feature do
  before :each do
    @user = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    visit "/"
  end
  
  describe "When a user visits the root path they should be on the landing page ('/') which includes:" do
    before :each do
      click_on "Log In"

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password

      click_on 'Log In'

      visit '/'
    end

    it "Title of Application" do 
      expect(page).to have_content("Viewing Party Lite")
    end

    it "Has a Button to Register a New User" do
      expect(page).to have_button("Register New User")
    end

    it "has a List of Existing Users email addresses" do
      expect(page).to have_content("Existing Users")
      within(".existing_users") do
        expect(page).to have_content("#{@user.email}")
        expect(page).to have_content("#{@user_2.email}")
        expect(page).to have_content("#{@user_3.email}")
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

  describe "As a visitor" do
    it "should not have a list of all the users" do
      expect(page).to have_no_content("Existing Users")
    end

    it "should not be able to access a /dashboard page" do
      visit '/dashboard'

      expect(page.current_path).to eq("/")
      expect(page).to have_content("You must be logged in and registered to view your dashboard")
    end
  end
end