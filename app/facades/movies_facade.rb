class MoviesFacade
  attr_reader :user, :movie_results

  def initialize(movie_title = nil, user)
    @user = user
    @movie_results = movie_title
  end

  def service
    MoviedbService.new
  end

  def request_type
    if @movie_results.present?
      "search"
    else
      "top_rated"
    end
  end
  
  def top_rated_movies
    json = service.top_rated_movies
    
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
  
  def search_results
    json = service.search_results(@movie_results)
    
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end    
  end

  def empty_request?
    request_type == "search" && search_results.empty?
  end
end