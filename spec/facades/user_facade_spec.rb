require 'rails_helper'

describe UserFacade do
  before :each do
    VCR.use_cassette("user") do

      @user = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @user4 = create(:user)
      @user5 = create(:user)
      @user6 = create(:user)
      @user7 = create(:user)
      @user8 = create(:user)
      params = {"controller"=>"movies",
        :action=>"index",
        :id=>@user.id,
        :movie_title=>"Despicable"}
      @movie_facade = MovieFacade.new(params[:movie_title], @user)
      @user_facade = UserFacade.new(@user)
      @vp1 = ViewingParty.create!({duration: 180, party_date: Date.new(2011, 1, 1,), start_time: '21:00', movie_id: 238})
      @vp2 = ViewingParty.create!({duration: 180, party_date: Date.new(2021, 1, 1,), start_time: '21:00', movie_id: 238})
      ViewingPartyUser.create!(user_id: @user.id, viewing_party_id: @vp1.id, host: true)
      ViewingPartyUser.create!(user_id: @user2.id, viewing_party_id: @vp1.id, host: false)
      ViewingPartyUser.create!(user_id: @user2.id, viewing_party_id: @vp2.id, host: true)
      ViewingPartyUser.create!(user_id: @user.id, viewing_party_id: @vp2.id, host: false)
    end
  end

  it 'can create a new UserFacade' do
    VCR.use_cassette("user") do
     expect(@user_facade).to be_instance_of(UserFacade)
     expect(@user_facade.user).to be_an_instance_of(User)
    end
  end

  it 'can create a new service' do
    expect(@movie_facade.service).to be_instance_of(MoviedbService)
  end

  it 'can determine viewing parties by host' do
    VCR.use_cassette("user") do
      @result = @user_facade.hosted_parties
    end
    
    expect(@result.first).to be_an_instance_of(ViewingParty)
  end

  it 'can determine viewing parties by attendee' do
    VCR.use_cassette("user") do
      @result = @user_facade.attended_parties
    end
    
    expect(@result.first).to be_an_instance_of(ViewingParty)
  end
end