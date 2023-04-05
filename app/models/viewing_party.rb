class ViewingParty < ApplicationRecord
  has_many :viewing_party_users
  has_many :users, through: :viewing_party_users

  before_validation :check_for_movie_duration
  validates_presence_of :duration, :party_date, :start_time, :movie_id
  
  def viewing_party_movie
    MovieFacade.new(movie_id).movie
  end  
  
  private
  def check_for_movie_duration
    facade = MovieFacade.new(movie_id )
    runtime = facade.movie.runtime

    if duration >= runtime
      return
    else
      errors.add(:base, "Duration must be greater than or equal to movie runtime: #{runtime} minutes")
      throw :abort
    end
  end
end