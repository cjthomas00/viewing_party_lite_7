require "rails_helper"

RSpec.describe MovieFacade do
  before :each do
    @user = create(:user)
    @facade = MovieFacade.new(238, @user)
  end

  it 'can create a new MoviesFacade' do
    expect(@facade).to be_instance_of(MovieFacade)
    expect(@facade.user).to eq(@user)
    expect(@facade.movie_id).to eq(238)
  end

  it 'can create a new service' do
    expect(@facade.service).to be_instance_of(MoviedbService)
  end

  it "can find a movie and its attributes" do
    VCR.use_cassette("godfather_movie") do
      @result = @facade.movie
    end
    expect(@result).to be_instance_of(Movie)
  end

  it "can find a movie's cast members" do
    VCR.use_cassette("godfather_movie_cast") do
      @result = @facade.movie_cast
    end

    expect(@result).to be_instance_of(Array)
    expect(@result.first).to be_instance_of(CastMember)
  end

  it 'can put movie reviews into a hash' do
    VCR.use_cassette("godfather_movie_reviews") do
      @result = @facade.movie_reviews_hash
    end
    
    expect(@result).to be_instance_of(Array)
    expect(@result.first).to be_instance_of(Hash)

  end

  it "can find a movie's reviews" do
    VCR.use_cassette("godfather_movie_reviews") do
      @result = @facade.movie_reviews
    end
    
    expect(@result).to be_instance_of(Array)
    expect(@result.first).to be_instance_of(Review)
  end
end