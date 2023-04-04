require "rails_helper"

RSpec.describe "Register", type: :feature do
  describe "When a user visits the '/register' path" do
    before :each do 
      @user1 = User.create!(name: "Mike Smith", email: "msmith@gmail.com", password: "password1") 
      visit "/register"
    end

    it "they should see a form to register." do

      expect(page).to have_link("Home Page")
      expect(page).to have_content("Register New User")
      expect(page).to have_field("Name:")
      expect(page).to have_field("Email:")
      expect(page).to have_field("Password:")
      expect(page).to have_button("Register")
    end

    it "Once the user registers they should be taken to a dashboard page '/users/:id', where :id is the id for the user that was just created." do

      fill_in "Name", with: "Max Power"
      fill_in "Email", with: "mpower@aol.com"
      fill_in :password, with: "qwerty"
      click_button("Register")
      user = User.last

      expect(current_path).to eq(user_path(user))
      expect(page).to have_content("#{user.name}'s Dashboard")

      click_link("Home Page")

      expect(current_path).to eq("/")

      within(".existing_users") do 
        expect(page).to have_content(user.email)
      end
    end

    it "Won't register someone with the same email" do
      fill_in "Name", with: "Max Power"
      fill_in "Email", with: "msmith@gmail.com"
      fill_in :password, with: "qwerty"
      click_button("Register")
      expect(current_path).to eq(register_path)
      expect(page).to have_content("Email has already been taken")
    end

    it "Won't let a field be left blank" do
      fill_in "Name", with: "Max Power"
      click_button("Register")
      expect(page).to have_content("Email can't be blank")
      expect(current_path).to eq(register_path)

      fill_in "Email", with: "mpower@aol.com"
      click_button("Register")
      expect(page).to have_content("Name can't be blank")
      expect(current_path).to eq(register_path)

      fill_in "Name", with: "Max Power"
      fill_in "Email", with: "mpower@aol.com"
      click_button("Register")
      expect(page).to have_content("Password can't be blank")
      expect(current_path).to eq(register_path)
    end
  end
end