class ViewingParty < ApplicationRecord
  has_many :viewing_party_users
  has_many :users, through: :viewing_party_users

  validates_presence_of :duration, :party_date, :start_time, :movie_id

  before_validation :check_for_movie_duration
  validates_presence_of :duration, :party_date, :start_time, :movie_id
  
  def movie_title
    MoviedbService.new.movie(self.movie_id)[:original_title]
  end  
  
  private
  def check_for_movie_duration
    facade = MovieFacade.new({id: movie_id})
    runtime = facade.movie.runtime

    if duration >= runtime
      return
    else
      errors.add(:base, "Duration must be greater than or equal to movie runtime: #{runtime} minutes")
      throw :abort
    end
  end
end