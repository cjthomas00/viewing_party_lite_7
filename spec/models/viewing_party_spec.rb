require "rails_helper"

describe ViewingParty, type: :model do
  describe "relationship" do
    it { should have_many :viewing_party_users }
    it { should have_many(:users).through(:viewing_party_users) }
  end
  
  # # describe "validations" do
  # #   before :each do
  # #     VCR.use_cassette("fight_club_2") do
  # #       @movie = MoviedbService.new.movie(550)
  # #       @vp1 = ViewingParty.create!({duration: 500, party_date: Date.new(2011, 3, 1,), start_time: '21:00', movie_id: 550})
  # #     end
  # #   end
  # #     it { should validate_presence_of :duration }
  # #     it { should validate_presence_of :party_date }
  # #     it { should validate_presence_of :start_time }
  # #     it { should validate_presence_of :movie_id }
  # end

  describe "instance methods" do
    it "#viewing_party_movie" do
    VCR.use_cassette("fight_club_6") do
      @movie = MoviedbService.new.movie(550)
      @user = create(:user, password: "password1", password_confirmation: "password1")
      @user2 = create(:user, password: "password1", password_confirmation: "password1")
      @vp1 = ViewingParty.create!({duration: 500, party_date: Date.new(2011, 3, 1,), start_time: '21:00', movie_id: 550})
      ViewingPartyUser.create!(user_id: @user.id, viewing_party_id: @vp1.id, host: true)
      ViewingPartyUser.create!(user_id: @user2.id, viewing_party_id: @vp1.id, host: false)
      expect(@vp1.viewing_party_movie).to be_instance_of(Movie)
      expect(@vp1.viewing_party_movie.title).to eq("Fight Club")
    end
    end
  end
end