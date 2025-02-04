class MoviedbService
  def movie(id)
    get_url("/3/movie/#{id}?api_key=#{ENV['TMDB_API_KEY']}&language=en-US")
  end

  def search_results(keyword)
    get_url("/3/search/movie?api_key=#{ENV['TMDB_API_KEY']}&language=en-US&query=#{keyword}&page=1&include_adult=false")
  end

  def top_rated_movies
    get_url("/3/movie/top_rated?api_key=#{ENV['TMDB_API_KEY']}&language=en-US&page=1")
  end

  def movie_cast(id)
    get_url("/3/movie/#{id}/credits?api_key=#{ENV['TMDB_API_KEY']}&language=en-US&page=1")
  end

  def movie_reviews(id)
    get_url("/3/movie/#{id}/reviews?api_key=#{ENV['TMDB_API_KEY']}&language=en-US&page=1")
  end

  def image(poster_path)
    "https://image.tmdb.org/t/p/h100#{poster_path}"
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org/") do |faraday|
    end
  end
end