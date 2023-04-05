require 'rails_helper'

describe MoviesFacade do
  before :each do
    @user = create(:user)
    @facade = MoviesFacade.new("Despicable", @user)
  end

  it 'can create a new MoviesFacade' do
    expect(@facade).to be_instance_of(MoviesFacade)
    expect(@facade.user).to eq(@user)
    expect(@facade.movie_results).to eq("Despicable")
  end

  it 'can create a new service' do
    expect(@facade.service).to be_instance_of(MoviedbService)
  end

  it 'can determine the request type as search' do
    expect(@facade.request_type).to eq("search")
  end

  it 'can determine the request type as top_rated' do
    facade = MoviesFacade.new(@user)

    expect(facade.request_type).to eq("top_rated")
  end

  it 'can determine the top_rated movies' do
    facade = MoviesFacade.new(@user)

    VCR.use_cassette("top_rated") do
      @result_0 = facade.top_rated_movies
    end

    expect(@result_0).to be_instance_of(Array)
    expect(@result_0.first).to be_instance_of(Movie)
    expect(@result_0.size).to eq(20)
  end

  it 'can determine search results' do
    VCR.use_cassette('movie_search') do
      @result = @facade.search_results
    end
    expect(@result).to be_an Array
    expect(@result.first).to be_instance_of(Movie)
    expect(@result.first.title).to include("Despicable")
  end

  it 'can determine if the movie_request returned nothing' do
    params = {"controller"=>"movies",
      :action=>"index",
      :user_id=>@user.id,
      :movie_title=>"tobacco and worms for breakfast"}
    @facade = MoviesFacade.new(params[:movie_title], @user)

    VCR.use_cassette('nil_search_results') do
      @result_2 = @facade.empty_request?
    end

    expect(@result_2).to eq(true)
  end
end