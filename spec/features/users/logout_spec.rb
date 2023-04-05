require 'rails_helper'

describe 'as a logged in user when i visit the landing page' do
  before(:each) do
    @user_1 = create(:user)

    visit '/'
    click_on "Log In"

    fill_in 'Email', with: @user_1.email
    fill_in 'Password', with: @user_1.password

    click_on 'Log In'

    visit '/'
  end

  it "I no longer see a link to log in or create an account" do
    expect(page).to have_no_button("Log In")
  end

  it "I see a link to log out" do
    expect(page).to have_button("Log Out")
  end

  describe "when i click the link to log out" do
    before(:each) do
      click_on 'Log Out'
    end

    it "I am taken to the landing page" do
      expect(page.current_path).to eq("/")
    end

    it "I can see that the log out link has changed back to a log in link" do
      expect(page).to have_button("Log In")
    end
  end
end
