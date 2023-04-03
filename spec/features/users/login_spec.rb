require 'rails_helper'

describe 'as a registerd user' do
  describe 'when When I visit the landing page I see a link for login' do
    describe "When I click on Log In I'm taken to a Log In page ('/login') where I can input my unique email and password." do
      it 'can take me to the login page correctly' do
        visit '/'

        click_on "Log In"

        expect(page).to have_current_path('/login')
        expect(page).to have_field('Email')
        expect(page).to have_field('Password')
        expect(page).to have_button('Log In')
      end
    end

    describe "When I enter my unique email and correct password I'm taken to my dashboard page" do
      it "can log in successfully" do
        @user_1 = create(:user)

        visit '/'
        click_on "Log In"

        fill_in 'Email', with: @user_1.email
        fill_in 'Password', with: @user_1.password

        click_on 'Log In'

        expect(page).to have_current_path(user_path(@user_1))
      end
    end

    describe "sad path" do
      it "keeps you on the login page with a flash message if login credentials are invalid" do
        @user_1 = create(:user)

        visit '/'
        click_on "Log In"

        fill_in 'Email', with: @user_1.email
        fill_in 'Password', with: "not it"

        click_on 'Log In'

        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end