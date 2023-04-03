require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user1 = User.create!(name: "Mike Smith", email: "msmith@gmail.com", password: "password1", password_confirmation: "password1")

    visit root_path

    click_on "Log in"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user1.email
    fill_in :password, with: user1.password

    click_on "Log In"

    expect(current_path).to eq(user_path(user1))
  end
end