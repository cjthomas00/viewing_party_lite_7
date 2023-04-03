require "rails_helper"

RSpec.describe "Welcome Page", type: :feature do
  before :each do
    @user = create(:user, password: "password1", password_confirmation: "password1")
    visit "/"
  end
  
  describe "When a user visits the root path they should be on the landing page ('/') which includes:" do
    it "Title of Application" do 
      expect(page).to have_content("Viewing Party Lite")
    end

    it "Has a Button to Register a New User" do
      expect(page).to have_button("Register New User")
    end

    it "has a List of Existing Users" do
      expect(page).to have_content("Existing Users")
      within(".existing_users") do
        expect(page).to have_link("#{@user.name}")
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