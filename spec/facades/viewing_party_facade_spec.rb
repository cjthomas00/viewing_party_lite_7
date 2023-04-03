require 'rails_helper'

describe ViewingPartyFacade do
  before :each do
    @user = create(:user, password: "password1", password_confirmation: "password1")
    @user2 = create(:user, password: "password1", password_confirmation: "password1")
    @user3 = create(:user, password: "password1", password_confirmation: "password1")
    @user4 = create(:user, password: "password1", password_confirmation: "password1")
    @user5 = create(:user, password: "password1", password_confirmation: "password1")
    @user6 = create(:user, password: "password1", password_confirmation: "password1")
    @user7 = create(:user, password: "password1", password_confirmation: "password1")
    @user8 = create(:user, password: "password1", password_confirmation: "password1")
    params = {"controller"=>"movies",
      :action=>"index",
      :user_id=>@user.id,
      :movie_title=>"Despicable"}
    @movie_facade = MovieFacade.new(params)
    @vp_facade = ViewingPartyFacade.new(params)
  end

  it 'can create a new ViewingPartyFacade' do
    VCR.use_cassette("viewing_party") do
     expect(@vp_facade).to be_instance_of(ViewingPartyFacade)
     expect(@vp_facade.user).to be_an_instance_of(User)
     expect(@vp_facade.movie).to be_an_instance_of(Movie)
    end
  end

  it 'can create a new service' do
    expect(@vp_facade.service).to be_instance_of(MoviedbService)
  end

  it 'can create a new movie' do
    VCR.use_cassette("viewing_party") do
      @result = @vp_facade.movie
    end

    expect(@result).to be_instance_of(Movie)  
  end

  it 'can create a new viewing_party' do
    VCR.use_cassette("viewing_party") do
      @result = @vp_facade.new_viewing_party
    end

    expect(@result).to be_instance_of(ViewingParty)  
  end

  it "can find all users other than current user" do
    VCR.use_cassette("godfather_movie_reviews") do
      @result = @vp_facade.users
    end

    expect(@result.count).to eq(7)
    expect(@result).to include(@user2, @user3, @user4, @user5, @user6, @user7)
  end
end