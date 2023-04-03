require "rails_helper"

describe ViewingPartyUser, type: :model do
  describe "relationship" do
    it { should belong_to :user}
    it { should belong_to :viewing_party}
  end

  describe "validations" do
    it { should validate_inclusion_of(:host).in?([true, false]) }
  end

  describe "'instance methods" do
    it "#host_user" do
    VCR.use_cassette("godfather_5") do
      @user1 = create(:user, name: "Caleb", password: "password1", password_confirmation: "password1")
      @user2 = create(:user, name: "John", password: "password1", password_confirmation: "password1")
      @user3 = create(:user, name: "Mike", password: "password1", password_confirmation: "password1")
      @vp1 = ViewingParty.create!({duration: 180, party_date: Date.new(2011, 1, 1,), start_time: '21:00', movie_id: 238})
      @party= ViewingPartyUser.create!(user_id: @user1.id, viewing_party_id: @vp1.id, host: true)
      ViewingPartyUser.create!(user_id: @user2.id, viewing_party_id: @vp1.id, host: false)
    end

      expect(@party.host_user.first).to be_an_instance_of(ViewingParty)
    end
  end
end